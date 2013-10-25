From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 25 Oct 2013 12:39:39 +0200
Subject: [PATCH 1/2] ARM: s3c64xx: cpuidle: convert to platform driver
In-Reply-To: <1382685074-16502-1-git-send-email-daniel.lezcano@linaro.org>
References: <1382685074-16502-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <6431720.IUjkN7MGOG@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

[Sending again, without HTML part. Sorry for the noise.]

On Friday 25 of October 2013 09:11:13 Daniel Lezcano wrote:
> The driver is tied with the pm low level code making difficult to split
> the driver into a more arch independent code. The platform driver allows
> to move the standby callback into the platform data field and use a
> simple driver with no more dependency on the low level code.
> 
> The standby callback has a portion of code to set the standby method and
> the effective cpu_do_idle switching the cpu to the right mode. As this
> code is redundant in the cpu suspend code, it has been factored out when
> implementing the standby methdod.
> 
> By this way, the driver is ready to be moved out to the drivers/cpuidle.

The idea itself is quite good, but unfortunately I have to NAK this. Please 
see details in comments below.

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-s3c64xx/cpuidle.c |   38
> ++++++++++++++++---------------------- arch/arm/mach-s3c64xx/pm.c      |
>   33 ++++++++++++++++++++++++++------- 2 files changed, 42
> insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/cpuidle.c
> b/arch/arm/mach-s3c64xx/cpuidle.c index 3c8ab07..8022f5f 100644
> --- a/arch/arm/mach-s3c64xx/cpuidle.c
> +++ b/arch/arm/mach-s3c64xx/cpuidle.c
> @@ -9,33 +9,16 @@
>   * published by the Free Software Foundation.
>  */
[snip]
>  static int s3c64xx_enter_idle(struct cpuidle_device *dev,
>  			      struct cpuidle_driver *drv,
>  			      int index)
>  {
> -	unsigned long tmp;
> -
> -	/* Setup PWRCFG to enter idle mode */
> -	tmp = __raw_readl(S3C64XX_PWR_CFG);
> -	tmp &= ~S3C64XX_PWRCFG_CFG_WFI_MASK;
> -	tmp |= S3C64XX_PWRCFG_CFG_WFI_IDLE;

Note the S3C64XX_PWRCFG_CFG_WFI_IDLE flag here.

> -	__raw_writel(tmp, S3C64XX_PWR_CFG);
> -
> -	cpu_do_idle();
> +	s3c64xx_standby();
> 
>  	return index;
>  }
[snip]
> +static void s3c64xx_set_standby(void)
> +{
> +	unsigned long tmp;
> +
> +	tmp = __raw_readl(S3C64XX_PWR_CFG);
> +	tmp &= ~S3C64XX_PWRCFG_CFG_WFI_MASK;
> +	tmp |= S3C64XX_PWRCFG_CFG_WFI_SLEEP;

Note the S3C64XX_PWRCFG_CFG_WFI_SLEEP flag here, which is different from 
the S3C64XX_PWRCFG_CFG_WFI_IDLE flag above.

> +	__raw_writel(tmp, S3C64XX_PWR_CFG);
> +}
> +
> +static void s3c64xx_standby(void)
> +{
> +	s3c64xx_set_standby();
> +	cpu_do_idle();
> +}
> +
>  /* since both s3c6400 and s3c6410 share the same sleep pm calls, we
>   * put the per-cpu code in here until any new cpu comes along and
> changes * this.
> @@ -269,11 +286,7 @@ static int s3c64xx_cpu_suspend(unsigned long arg)
>  	unsigned long tmp;
> 
>  	/* set our standby method to sleep */
> -
> -	tmp = __raw_readl(S3C64XX_PWR_CFG);
> -	tmp &= ~S3C64XX_PWRCFG_CFG_WFI_MASK;
> -	tmp |= S3C64XX_PWRCFG_CFG_WFI_SLEEP;

Finally note the S3C64XX_PWRCFG_CFG_WFI_SLEEP flag here again.

I believe it should be visible now what's wrong with this patch. To make 
sure it is, let me explain how the system controller of S3C64xx handles WFI 
requests.

When the CPU issues WFI request to the syscon, it takes an action depending 
on how it is configured. A bit field is there in one of syscon registers 
(S3C64XX_PWR_CFG) that selects what action to perform in case of WFI 
request.

You can program the syscon to ignore the request, enter IDLE mode, enter 
STOP mode or enter SLEEP mode. As the names suggest, for cpuidle, it needs 
to be programmed for IDLE mode and for system-wide sleep it needs to be set 
to SLEEP mode. STOP mode is not very useful as it has mostly the same 
effect that can be achieved by performing fine-grained clock and power 
gating of peripherals manually, so it is unused by Linux.

Now, my take on the issue you are trying to solve would be a bit different. 
Since the S3C64xx does not have any interesting cpuidle modes, just a 
normal, clock-gated WFI mode, it does not need to have a cpuidle driver at 
all. All that is needed is simply setting up the S3C64XX_PWRCFG_CFG_WFI 
field to S3C64XX_PWRCFG_CFG_WFI_IDLE early at boot-up, then set it to 
S3C64XX_PWRCFG_CFG_WFI_SLEEP just before entering the sleep mode and 
restore it back to S3C64XX_PWRCFG_CFG_WFI_IDLE after waking up.

Best regards,
Tomasz
