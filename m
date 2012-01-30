From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 30 Jan 2012 17:26:55 +0000
Subject: [PATCH v6 6/9] ARM: vexpress: Motherboard RS1 memory map support
In-Reply-To: <1326979266.32197.60.camel@hornet.cambridge.arm.com>
References: <1323957761-13553-1-git-send-email-pawel.moll@arm.com>
 <1323957761-13553-7-git-send-email-pawel.moll@arm.com>
 <4F047FE1.5030002@citrix.com>
 <1326979266.32197.60.camel@hornet.cambridge.arm.com>
Message-ID: <20120130172655.GF2248@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 01:21:06PM +0000, Pawel Moll wrote:
> Hi,
> 
> Sorry about loooong delay - I've been on holiday.
> 
> On Wed, 2012-01-04 at 16:35 +0000, David Vrabel wrote:
> > On 15/12/11 14:02, Pawel Moll wrote:
> > > This patch adds support for RS1 memory map based Versatile Express
> > > motherboard.
> > > 
> > [...]
> > > --- a/arch/arm/mach-vexpress/include/mach/debug-macro.S
> > > +++ b/arch/arm/mach-vexpress/include/mach/debug-macro.S
> > > @@ -10,12 +10,41 @@
> > >   * published by the Free Software Foundation.
> > >   */
> > >  
> > > -#define DEBUG_LL_UART_OFFSET	0x00009000
> > > +#define DEBUG_LL_PHYS_BASE		0x10000000
> > > +#define DEBUG_LL_UART_OFFSET		0x00009000
> > > +
> > > +#define DEBUG_LL_PHYS_BASE_RS1		0x1c000000
> > > +#define DEBUG_LL_UART_OFFSET_RS1	0x00090000
> > > +
> > > +#define DEBUG_LL_VIRT_BASE		0xf8000000
> > >  
> > >  		.macro	addruart,rp,rv,tmp
> > > -		mov	\rp, #DEBUG_LL_UART_OFFSET
> > > -		orr	\rv, \rp, #0xf8000000	@ virtual base
> > > -		orr	\rp, \rp, #0x10000000	@ physical base
> > > +
> > > +		@ Check the MMU state
> > > +#if defined(CONFIG_MMU)
> > > +		mrc	p15, 0, \tmp, c1, c0	@ SCTRL
> > > +		tst	\tmp, #1		@ MMU enabled?
> > > +		moveq	\tmp, #DEBUG_LL_PHYS_BASE
> > > +		movne	\tmp, #DEBUG_LL_VIRT_BASE
> > > +#else
> > > +		mov	\tmp, #DEBUG_LL_PHYS_BASE
> > > +#endif
> > > +
> > > +		@ PL011 present in "original" place?
> > > +		orr	\tmp, \tmp, #DEBUG_LL_UART_OFFSET
> > > +		ldr	\tmp, [\tmp, #0xfe0]	@ PeriphID0
> > 
> > This doesn't work with CONFIG_EARLY_PRINTK=y on a system with the RS1
> > memory map.  
> 
> It does for me:
> 
> # zcat /proc/config.gz | grep EARLY_PRINTK
> CONFIG_EARLY_PRINTK=y
> # cat /proc/device-tree/motherboard/arm,v2m-memory-map && echo
> rs1     
> #
> 
> Can you tell me what exactly is going wrong in your case? Does it hang
> without any warning? Do you get at least part of the boot log? Can you
> send me (privately probably) your kernel config?

I had to disable this when running on the ARM fast model with your vexpress
DT series.  I didn't debug into exactly why I had to disable it, but I
think I was getting aborts when the kernel was probing for nonexistent
legacy memory map location of the UART.  I don't know whether this will
affect real hardware though... and maybe I was hitting the problem due
to something else.

Anyway unless I've misunderstood something, AMBA devices are only really
probable if there is some real bus slave at the probed address, which is
free from nasty side-effects.

Really we should have a way for getting this info from the device tree,
yada yada.  (Repeating myself here, I know)

In the meantime, I don't see a practical alternative to adding distinct
lowlevel debug UART selection options for the two memory maps ...?


Cheers
---Dave
