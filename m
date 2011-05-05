From: khilman@ti.com (Kevin Hilman)
Date: Thu, 05 May 2011 07:58:17 -0700
Subject: [PATCH v2 11/12] OMAP: Serial: Use resume call from prcm to
	enable uart
In-Reply-To: <BANLkTi=32NfMr7exWpOoPHX7_-Jc0i5LqA@mail.gmail.com> (Govindraj's
	message of "Thu, 5 May 2011 17:16:37 +0530")
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
	<1304080796-625-12-git-send-email-govindraj.raja@ti.com>
	<87pqnym2f2.fsf@ti.com>
	<BANLkTi=32NfMr7exWpOoPHX7_-Jc0i5LqA@mail.gmail.com>
Message-ID: <87liylkxdi.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Govindraj <govindraj.ti@gmail.com> writes:

[...]

>>
>> ... this is just putting back basically the same thing that was removed in
>> patch 1. ?IOW, this is now being checked for *every* PRCM wakeup, which
>> is no different than having it in the idle path.
>>
>> I thought I understood that you had the SW IRQ triggering working, so
>> this part should not be necessary.
>
> Actually I tried few experiments but couldn't get it working.

What exactly is not working?   The interrupt is not firing at all?  The
driver's ISR is not being called? 

> Tried below but didn't help.
>
> ------------------------------------
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 3960330..2c1dfc2 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -288,6 +288,16 @@ static irqreturn_t prcm_interrupt_handler (int
> irq, void *dev_id)
>         do {
>                 if (irqstatus_mpu & (OMAP3430_WKUP_ST_MASK |
>                                      OMAP3430_IO_ST_MASK)) {
> +#if 1
> +                       /*
> +                        * EXP-1: SET UART1 SOFT IRQ BIT
> +                        * 3430 -SDP UART1 console.
> +                        * M_IRQ_72, INTCPS_ISR_SET
> +                        * 0x4820 0090 + (0x20 * n)
> +                        * bit-8 n = 2
> +                        */
> +                       __raw_writel(0x100 , 0x482000D0);
> +#endif
>                         c = _prcm_int_handle_wakeup();
>
>                         /*
>
> -----------------------------------
>
> Currently we are planning to integrate irq_chaining patches
> on top uart_runtime patches which is work-in-progress.
> Will remove resume_idle once we have irq_chaining patches available.

Well, I'm not OK with $SUBJECT patch as it is since it's just moving an
ugly hack from serial.c to the PRCM ISR.  If the hack is going to stay,
then it should stay where it is until it can be fixed for real.

Kevin
