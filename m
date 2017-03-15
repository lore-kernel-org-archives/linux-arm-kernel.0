From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 15 Mar 2017 11:02:38 -0500
Subject: Enumerating an empty bus hangs the entire system
In-Reply-To: <1eeea8ff-0840-a005-38b4-61f3c253cee1@free.fr>
References: <1eeea8ff-0840-a005-38b4-61f3c253cee1@free.fr>
Message-ID: <20170315160238.GB5073@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 04:25:44PM +0100, Mason wrote:
> Hello,
> 
> My driver works reasonably well on revision 1 of the PCIe controller.
> (For lax enough values of "reasonably well"...)
> 
> So I wanted to try it out on revision 2 of the controller.
> 
> Turns out the system hangs if I boot with no card inserted in the PCIe
> slot. (This does not happen on revision 1.) If I log all config space
> accesses, this is what I see:
> 
> ...
> [    2.966402] tango_config_read: bus=0 devfn=0 where=128 size=2
> [    2.972284] tango_config_read: bus=0 devfn=0 where=140 size=4
> [    2.978167] tango_config_read: bus=0 devfn=0 where=146 size=2
> [    2.984144] pci_bus 0000:01: busn_res: can not insert [bus 01-ff] under [bus 00-3f] (conflicts with (null) [bus 00-3f])
> [    2.995105] tango_config_write: bus=0 devfn=0 where=24 size=4 val=0xff0100
> [    3.002134] pci_bus 0000:01: scanning bus
> [    3.006274] tango_config_read: bus=1 devfn=0 where=0 size=4
> 
> Basically, the PCI framework tries to read vendor and device IDs
> of the non-existent device on bus 1, which hangs the system,
> because the read never completes :-(
> 
> I had the same problem with the legacy driver for 3.4 but I was
> hoping I would magically avoid it in a recent kernel.
> 
> The only work-around I see is: assuming the first access to a
> bus will be to register 0, check the PHY for an active link
> before sending an actual read request to register 0.
> 
> Is that reasonable?
> 
> Is it compliant for the PCIe controller to hang like that,
> or should it handle some kind of time out?
> 
> Liviu suggested: "The PCIe controller probably generates (or propagates)
> a bus abort that it should actually trap in HW.	Check if there is a SW
> configurable way to recover that."

I agree; generally the PCIe controller will timeout and report an
error somehow.  On most systems the PCIe controller fabricates all
ones read data (0xffffffff) to satisfy the CPU's read request.

I'm not enough of a hardware person to point you to a spec section
that addresses this, but the Linux PCI core is definitely not prepared
to deal with config requests that hang.

If checking for link in your accessor is the best you can do, maybe
that's all you can do.  I thought there was another driver that did
that, but I can't find it now.  It doesn't seem perfectly safe to me,
since the link could go down after you check for "link up" and before
you actually issue the read.

Bjorn
