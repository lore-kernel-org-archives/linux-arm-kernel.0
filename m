From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 4 Jan 2013 15:45:18 +0200
Subject: [PATCH 05/12] ARM: OMAP3xxx: PM: convert to use the functional
 power states API
In-Reply-To: <20121209175312.6933.92995.stgit@dusk.lan>
References: <20121209174545.6933.59371.stgit@dusk.lan>
 <20121209175312.6933.92995.stgit@dusk.lan>
Message-ID: <1357307118.2221.93.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Sun, 2012-12-09 at 10:53 -0700, Paul Walmsley wrote:

<clip>

> @@ -112,24 +112,26 @@ static void omap3_core_restore_context(void)
>  static void omap3_save_secure_ram_context(void)
>  {
>  	u32 ret;
> -	int mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
> +	int mpu_next_fpwrst;
>  
> -	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
> -		/*
> -		 * MPU next state must be set to POWER_ON temporarily,
> -		 * otherwise the WFI executed inside the ROM code
> -		 * will hang the system.
> -		 */
> -		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
> -		ret = _omap_save_secure_sram((u32 *)
> -				__pa(omap3_secure_ram_storage));
> -		pwrdm_set_next_pwrst(mpu_pwrdm, mpu_next_state);
> -		/* Following is for error tracking, it should not happen */
> -		if (ret) {
> -			pr_err("save_secure_sram() returns %08x\n", ret);
> -			while (1)
> -				;
> -		}
> +	if (omap_type() == OMAP2_DEVICE_TYPE_GP)
> +		return;
> +
> +	/*
> +	 * MPU next state must be set to POWER_ON temporarily,
> +	 * otherwise the WFI executed inside the ROM code will hang
> +	 * the system.
> +	 */
> +	mpu_next_fpwrst = pwrdm_read_next_fpwrst(mpu_pwrdm);
> +	pwrdm_set_next_fpwrst(mpu_pwrdm, PWRDM_FUNC_PWRST_ON);
> +	ret = _omap_save_secure_sram((u32 *)__pa(omap3_secure_ram_storage));
> +	pwrdm_set_next_fpwrst(mpu_pwrdm, mpu_next_fpwrst);
> +	/* Following is for error tracking, it should not happen */
> +	/* XXX This needs to be converted to a BUG() or removed */
> +	if (ret) {
> +		pr_err("save_secure_sram() returns %08x\n", ret);
> +		while (1)
> +			;

Just a minor comment here, this can be converted to BUG_ON right now, as
it is only used from init code.

Another thing to consider with this code is, that there might be someone
who actually wants to use secure services from the kernel, and in this
case you need to do the save every time you are entering off-mode if
secure services have been used. If this save fails, the core powerdomain
should be re-programmed to RET, or prevent idle completely. Maybe this
needs to be moved into secure driver or something, and use cpu_pm
notifiers.... they don't support failures currently though.

-Tero
