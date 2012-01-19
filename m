From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 19 Jan 2012 13:21:06 +0000
Subject: [PATCH v6 6/9] ARM: vexpress: Motherboard RS1 memory map support
In-Reply-To: <4F047FE1.5030002@citrix.com>
References: <1323957761-13553-1-git-send-email-pawel.moll@arm.com>
 <1323957761-13553-7-git-send-email-pawel.moll@arm.com>
 <4F047FE1.5030002@citrix.com>
Message-ID: <1326979266.32197.60.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry about loooong delay - I've been on holiday.

On Wed, 2012-01-04 at 16:35 +0000, David Vrabel wrote:
> On 15/12/11 14:02, Pawel Moll wrote:
> > This patch adds support for RS1 memory map based Versatile Express
> > motherboard.
> > 
> [...]
> > --- a/arch/arm/mach-vexpress/include/mach/debug-macro.S
> > +++ b/arch/arm/mach-vexpress/include/mach/debug-macro.S
> > @@ -10,12 +10,41 @@
> >   * published by the Free Software Foundation.
> >   */
> >  
> > -#define DEBUG_LL_UART_OFFSET	0x00009000
> > +#define DEBUG_LL_PHYS_BASE		0x10000000
> > +#define DEBUG_LL_UART_OFFSET		0x00009000
> > +
> > +#define DEBUG_LL_PHYS_BASE_RS1		0x1c000000
> > +#define DEBUG_LL_UART_OFFSET_RS1	0x00090000
> > +
> > +#define DEBUG_LL_VIRT_BASE		0xf8000000
> >  
> >  		.macro	addruart,rp,rv,tmp
> > -		mov	\rp, #DEBUG_LL_UART_OFFSET
> > -		orr	\rv, \rp, #0xf8000000	@ virtual base
> > -		orr	\rp, \rp, #0x10000000	@ physical base
> > +
> > +		@ Check the MMU state
> > +#if defined(CONFIG_MMU)
> > +		mrc	p15, 0, \tmp, c1, c0	@ SCTRL
> > +		tst	\tmp, #1		@ MMU enabled?
> > +		moveq	\tmp, #DEBUG_LL_PHYS_BASE
> > +		movne	\tmp, #DEBUG_LL_VIRT_BASE
> > +#else
> > +		mov	\tmp, #DEBUG_LL_PHYS_BASE
> > +#endif
> > +
> > +		@ PL011 present in "original" place?
> > +		orr	\tmp, \tmp, #DEBUG_LL_UART_OFFSET
> > +		ldr	\tmp, [\tmp, #0xfe0]	@ PeriphID0
> 
> This doesn't work with CONFIG_EARLY_PRINTK=y on a system with the RS1
> memory map.  

It does for me:

# zcat /proc/config.gz | grep EARLY_PRINTK
CONFIG_EARLY_PRINTK=y
# cat /proc/device-tree/motherboard/arm,v2m-memory-map && echo
rs1     
#

Can you tell me what exactly is going wrong in your case? Does it hang
without any warning? Do you get at least part of the boot log? Can you
send me (privately probably) your kernel config?

>  __create_page_tables has only mapped the single physical
> page at 0x1c090000 and thus the test for the UART in the other memory
> map faults.

I investigated this when writing the code and I vaguely remember it was
fine, partly by accident. I'll dig in again and let you know my
findings.

Thanks for trying this out!

Pawe?
