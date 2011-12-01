From: khilman@ti.com (Kevin Hilman)
Date: Thu, 01 Dec 2011 07:00:31 -0800
Subject: [PATCH-V4 3/3] arm:omap:am33xx: Add low level debugging support
In-Reply-To: <79CD15C6BA57404B839C016229A409A80474A5@DBDE01.ent.ti.com>
 (Vaibhav Hiremath's message of "Thu, 1 Dec 2011 10:52:52 +0000")
References: <1320946837-32507-1-git-send-email-hvaibhav@ti.com>
 <1320946837-32507-4-git-send-email-hvaibhav@ti.com>
 <87r50pxk1i.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A80474A5@DBDE01.ent.ti.com>
Message-ID: <87pqg8s5f4.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

>> Vaibhav Hiremath <hvaibhav@ti.com> writes:
>> 
>> > From: Afzal Mohammed <afzal@ti.com>
>> >
>> > Add support for low level debugging on AM335X EVM (AM33XX family).
>> > Currently only support for UART1 console, which is used on AM335X EVM
>> > is added.
>> >
>> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
>> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
>> 
>> One minor comment below...
>> 
>> > ---
>> >  arch/arm/mach-omap2/include/mach/debug-macro.S |   17 ++++++++++++++++-
>> >  arch/arm/plat-omap/include/plat/serial.h       |    4 ++++
>> >  arch/arm/plat-omap/include/plat/uncompress.h   |    6 ++++++
>> >  3 files changed, 26 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S
>> b/arch/arm/mach-omap2/include/mach/debug-macro.S
>> > index 13f98e5..ce543ae 100644
>> > --- a/arch/arm/mach-omap2/include/mach/debug-macro.S
>> > +++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
>> > @@ -72,6 +72,8 @@ omap_uart_lsr:	.word	0
>> >  		beq	82f			@ configure UART2
>> >  		cmp	\rp, #TI816XUART3	@ ti816x UART offsets different
>> >  		beq	83f			@ configure UART3
>> > +		cmp	\rp, #AM33XXUART1	@ AM33XX UART offsets different
>> > +		beq	84f			@ configure UART1
>> >  		cmp	\rp, #ZOOM_UART		@ only on zoom2/3
>> >  		beq	95f			@ configure ZOOM_UART
>> >
>> > @@ -100,7 +102,9 @@ omap_uart_lsr:	.word	0
>> >  		b	98f
>> >  83:		mov	\rp, #UART_OFFSET(TI816X_UART3_BASE)
>> >  		b	98f
>> > -
>> > +84:		ldr	\rp, =AM33XX_UART1_BASE
>> > +		and	\rp, \rp, #0x00ffffff
>> > +		b	97f
>> >  95:		ldr	\rp, =ZOOM_UART_BASE
>> >  		str	\rp, [\tmp, #0]		@ omap_uart_phys
>> >  		ldr	\rp, =ZOOM_UART_VIRT
>> > @@ -110,6 +114,17 @@ omap_uart_lsr:	.word	0
>> >  		b	10b
>> >
>> >  		/* Store both phys and virt address for the uart */
>> 
>> Please update this comment to clarify that this block is for AM33xx
>> only, and update the following one as the catch all.
>> 
> Ok, will update.
>
>> > +97:		add	\rp, \rp, #0x44000000	@ phys base
>> > +		str	\rp, [\tmp, #0]		@ omap_uart_phys
>> > +		sub	\rp, \rp, #0x44000000	@ phys base
>> > +		add	\rp, \rp, #0xf9000000	@ virt base
>> > +		str	\rp, [\tmp, #4]		@ omap_uart_virt
>> > +		mov	\rp, #(UART_LSR << OMAP_PORT_SHIFT)
>> > +		str	\rp, [\tmp, #8]		@ omap_uart_lsr
>> 
>> The last 3 lines are unnecessarily duplicated.  They can be shared with
>> the common block that follows.  IOW, only the base addresses are
>> different, the rest of the operations are shared.
>> 
> I thought about this, but then code looks complex & ugly, just to save
> duplication of 3 lines. So I added separate code for AM33xx devices.

Yeah, you're right.

Your original version is better.   Please just update the comments
around the 2 blocks then.

Thanks,

Kevin
