From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 21:32:06 +0000
Subject: [PATCH v2 11/13] ARM: only include mach/irqs.h for !SPARSE_IRQ
In-Reply-To: <4F19DB35.9060707@gmail.com>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
 <1327091591-27125-12-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1201201608400.19587@xanadu.home>
 <4F19DB35.9060707@gmail.com>
Message-ID: <20120125213206.GJ1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 03:23:01PM -0600, Rob Herring wrote:
> On 01/20/2012 03:11 PM, Nicolas Pitre wrote:
> > On Fri, 20 Jan 2012, Rob Herring wrote:
> > 
> >> From: Rob Herring <rob.herring@calxeda.com>
> >>
> >> Make mach/irqs.h optional for SPARSE_IRQ. With this change irqs.h can be
> >> removed by converting platforms over to sparse irq.
> >>
> >> This intentionally breaks platforms that enable SPARSE_IRQ.
> > 
> > I don't get what you mean here.  The above seems contradictory.
> > 
> 
> You're right. The intro explains things more clearly. This breaks
> platforms (at boot time) that don't select SPARSE_IRQ, but let users
> enable it in their config. I don't understand why sparse irq is a user
> visible config option. We could move HAVE_SPARSE_IRQ down to each
> platform that selects SPARSE_IRQ and prevent enabling, but I think
> allowing it to break is good encouragement for others to fix those
> platforms. I'm open to other ideas.

config SPARSE_IRQ
	bool "Support sparse irq numbering" if MAY_HAVE_SPARSE_IRQ

and change all the existing 'HAVE_SPARSE_IRQ' to MAY_HAVE_SPARSE_IRQ
except those where SPARSE_IRQ gets selected.

In other words, on ARM get rid of HAVE_SPARSE_IRQ=y, don't select
MAY_HAVE_SPARSE_IRQ instead, but have each converted machine select
SPARSE_IRQ directly.  Then, people who want sparse irq to be a
question can have their cake.  While we can eat our cake too.

As a side-note, you may be pleased to know that I have SA11x0 stuff
converted to (and tested) with sparse IRQ.  That's with SA1111, the
UCB1x00 and Neponset expansion board for the Assabet all dynamically
allocating their IRQs.  The only fixed-numbered IRQs in SA11x0 in my
tree at the time of writing are the on-SoC IRQs, and the LoCoMo IRQs
(which I don't have the hardware to test for, so I'm not touching.)

Note that SA1111 support is fairly broken in current mainline because
of a half-completed (but still merged) patch which results in SA1111
overwriting IRQ0-55 with its own handlers.  Ouch.

This is /proc/interrupts for the Assabet+Neponset, with 49 SA11x0,
3 Neponset, 55 SA1111, and 16 UCB1300 IRQs:

           CPU0
 12:          1        SC  LCD
 15:       8238        SC  sa11x0-uart
 20:          0        SC  sa11x0-dma
 21:          0        SC  sa11x0-dma
 22:          0        SC  sa11x0-dma
 23:          0        SC  sa11x0-dma
 24:          0        SC  sa11x0-dma
 25:          0        SC  sa11x0-dma
 26:     599387        SC  ost0
 49:       3095         -  eth0
 73:          3  SA1111-l
103:          0  SA1111-h  SA1111 PCMCIA card detect
104:          0  SA1111-h  SA1111 CF card detect
105:          2  SA1111-h  SA1111 PCMCIA BVD1
106:          1  SA1111-h  SA1111 CF BVD1
107:          0   ucb1x00  gpio_keys
108:          0   ucb1x00  gpio_keys
109:          0   ucb1x00  gpio_keys
110:          0   ucb1x00  gpio_keys
111:          0   ucb1x00  gpio_keys
112:          0   ucb1x00  gpio_keys
Err:          0
