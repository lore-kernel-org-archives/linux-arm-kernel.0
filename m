From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 7 Feb 2013 11:21:53 -0700
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130207183743.5c97d8b8@skate>
References: <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130129132204.GA23886@arm.com> <20130207153750.0fef1192@skate>
 <20130207155117.GA19666@arm.com> <20130207171904.70270598@skate>
 <20130207174040.3a345770@skate> <20130207165347.GA31995@arm.com>
 <20130207181418.3753b007@skate> <20130207172934.GA2811@arm.com>
 <20130207183743.5c97d8b8@skate>
Message-ID: <20130207182153.GB24688@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 07, 2013 at 06:37:43PM +0100, Thomas Petazzoni wrote:
> Dear Andrew Murray,
> 
> On Thu, 7 Feb 2013 17:29:34 +0000, Andrew Murray wrote:
> 
> > > So if I ignore the bus number, how could the PCI code find what is the
> > > matching interrupt?
> > 
> > Apologies if I've missed information about your hardware in the other
> > discussion (I've tried to keep up) - does your hardware raise a single host
> > interrupt for each pin regardless to which bridge they come in on - or do you
> > separate A,B,C,D host interrupts for each bridge?
> 
> There are separate A,B,C,D interrupts for each PCIe interface, and each
> PCIe interface is represented by an emulated PCI-to-PCI bridge. See my
> interrupt-map:
> 
> 			interrupt-map = <0x0800 0 0 1 &mpic 58
> 				         0x1000 0 0 1 &mpic 59
> 					 0x1800 0 0 1 &mpic 60
> 					 0x2000 0 0 1 &mpic 61
> 					 0x2800 0 0 1 &mpic 62
> 				         0x3000 0 0 1 &mpic 63
> 					 0x3800 0 0 1 &mpic 64
> 					 0x4000 0 0 1 &mpic 65
> 					 0x4800 0 0 1 &mpic 99
> 					 0x5000 0 0 1 &mpic 103>;
> 
> Here I have 10 PCIe interfaces, and therefore 10 interrupts.
>
> There is only one interrupt per PCIe interface, and for now, I don't
> distinguish A,B,C,D (I will do it later, it requires reading a register
> to know if the interrupt came from A, B, C or D, but that's a different
> problem).

Right, someday you can have all 40 interrupts :)

This interrupt-map stuff is ugly, I looks like it was designed as a
way for the firmware to communicate the per-device interrupt
assignment to the OS - using it to describe a HW setup is a bit more
tortured for sure..

Frankly, I think it should not be used in PCI-E drivers *at all*
beacuse there is no need for an external interrupt routing
description. [1]

PCI-E *only* has inband interrupt delivery, so the host driver has
100% of the information it needs to convert a INTx signal received on
a link to a Linux interrupt number.

So in a PCI-E world translation should look like this:
 - Start at the source device INTx
 - Traverse up bridges performing INTx swizzling according to the
   PCI-E spec
 - When the host bridge is reached call into the host driver and pass
   - The INTx number
   - The bus/device/function of last bridge traversed
 - The host bridge driver returns a Linux interrupt number.

This *always* works for (compliant) PCI-E. An OF interrupt map is
never, ever, needed. Providing a common mechanism can remove this
complex OF stuff and ultimately help everyone :)

However, if interrupt-map is used, I strongly suspect it should be
placed on each bridge node (as Andrew mentioned), and it should be
very simple:

link at 0 {
reg = <0x800 0 0  0 0>; // Bus 0, Dev 0x10, Fn 0
interrupt-mask = <0x0 0 0 7>;
interrupt-map = <0x0000 0 0 1 &mpic 58 // INTA
                 0x0000 0 0 2 &mpic 58 // INTB
                 0x0000 0 0 3 &mpic 58 // INTC
                 0x0000 0 0 4 &mpic 58>; // INTD
}

Which hopefully says 'when you reach this bridge node, look only at
the INTx pin number and convert it'.

I don't think you can make interrupt-map work were you have placed
it..

Jason
1 - For PCI/PCI-X the physical INTx interrupt pins on any device,
    anywhere in the system could by physically tied to any interrupt
    ingress in the system. Even if they are behind bridges. It is a
    total free for all.
