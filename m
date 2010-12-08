From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Wed, 8 Dec 2010 09:30:39 +0100
Subject: [PATCH v3 06/15] ARM: mxs: Add timer support
In-Reply-To: <1291739523-25077-5-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-5-git-send-email-shawn.guo@freescale.com>
Message-ID: <19711.16943.870381.557719@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> Freescale MXS-based SoCs implement timer support in block TIMROT.
> There are two versions of TIMROT. The v1 on MX23 only gets 16 bits
> counter and has no match function. The v2 on MX28 extends the
> counter to 32 bits and add the match function.
> 
> As the result, we need two instances of timers with v1 for better
> implementation, one for clock_event and another for clocksource.
> Otherwise, get_cycles may get imprecise result after long time
> cumulating. With v2, one instance can serve two purposes well.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Changes for v3:
>  - Use term clock_event over next_event and clocksource over get_cycles
>  - Split BV_TIMROT_TIMCTRLn_SELECT__32KHZ_XTAL into two definitions for v1 and v2 respectively
>  - Turn timrot_get_cycles() into timrotv1_get_cycles() and timrotv2_get_cycles()
>  - Turn timrot_set_next_event() into timrotv1_set_next_event() and timrotv2_set_next_event()
>  - Skip flag IRQF_DISABLED
>  - Remove unncessary IRQ disabling in mxs_set_mode()
>  - Change shift of clocksource_mxs to 17
> 
> Changes for v2:
>  - Fix a bug in timrot_set_next_event(). It should read
>    HW_TIMROT_RUNNING_COUNTn to get the current counts.
> 
>  arch/arm/mach-mxs/timer.c |  276 +++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 276 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/timer.c
> 
> diff --git a/arch/arm/mach-mxs/timer.c b/arch/arm/mach-mxs/timer.c
> new file mode 100644
> index 0000000..b0e7ffe
> --- /dev/null
> +++ b/arch/arm/mach-mxs/timer.c
[...]
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		printk(KERN_ERR "mxs_set_mode: Periodic mode is not "
> +				"supported for MXS-based\n");
>
Please do not line wrap message strings. Also, if you want the
function name to appear in the message, use __func__ or __FUNCTION__.
That way the name is always correct even if the function is renamed or
the printk() statement is copied to a different function.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
