From: khilman@linaro.org (Kevin Hilman)
Date: Sun, 14 Jul 2013 13:12:48 +0100
Subject: [PATCH 08/12] ARM: DRA7: Reuse the omap44xx_restart and fix the
 device instance
In-Reply-To: <1373355139-12487-9-git-send-email-rnayak@ti.com>
References: <1373355139-12487-1-git-send-email-rnayak@ti.com>
 <1373355139-12487-9-git-send-email-rnayak@ti.com>
Message-ID: <51E295C0.4080309@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2013 08:32 AM, Rajendra Nayak wrote:
> The omap44xx_restart used on omap4 and omap5 devices can be reused
> on dra7 devices as well. The device instance however is different
> across omap5 and dra7 as compared to omap4. So fix this for omap5
> as well as dra7.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: R Sricharan <r.sricharan@ti.com>

[...]

> @@ -165,10 +168,19 @@ int omap4_prminst_deassert_hardreset(u8 shift, u8 part, s16 inst,
>  void omap4_prminst_global_warm_sw_reset(void)
>  {
>  	u32 v;
> -
> -	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
> -				    OMAP4430_PRM_DEVICE_INST,
> -				    OMAP4_PRM_RSTCTRL_OFFSET);
> +	s16 dev_inst;
> +
> +	if (cpu_is_omap44xx())
> +		dev_inst = OMAP4430_PRM_DEVICE_INST;

Please don't use cpu_is_* (or soc_is_*) at runtime.  Rather, the right
offset/instance should be setup at init time.

Kevin
