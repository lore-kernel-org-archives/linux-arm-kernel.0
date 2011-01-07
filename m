From: liu.h.jason@gmail.com (Jason Liu)
Date: Fri, 7 Jan 2011 17:30:28 +0800
Subject: [patch 1/1] mx51: add support for pwm
In-Reply-To: <20110107090656.517403682@rtp-net.org>
References: <20110107090656.517403682@rtp-net.org>
Message-ID: <AANLkTin7U0+sJ+Xz7BiJ2NbtiGXsyQbdVKejU9M5qrUp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Arnaud,

2011/1/7 Arnaud Patard <arnaud.patard@rtp-net.org>:
> This patch is adding support for pwm1 and pwm2 devices found
> on mx51.
> [ this patch has been tested with pwm-backlight driver ]
>
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Index: linux-2.6-submit/arch/arm/mach-mx5/clock-mx51-mx53.c
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/mach-mx5/clock-mx51-mx53.c ? 2011-01-04 11:36:15.000000000 +0100
> +++ linux-2.6-submit/arch/arm/mach-mx5/clock-mx51-mx53.c ? ? ? ?2011-01-04 11:39:55.000000000 +0100
> @@ -1206,6 +1206,11 @@
> ?DEFINE_CLOCK(gpt_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG9_OFFSET,
> ? ? ? ?NULL, ?NULL, &ipg_clk, &gpt_ipg_clk);
>
> +DEFINE_CLOCK(pwm1_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG6_OFFSET,
> + ? ? ? NULL, NULL, &ipg_clk, NULL);
> +DEFINE_CLOCK(pwm2_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG8_OFFSET,
> + ? ? ? NULL, NULL, &ipg_clk, NULL);
> +
> ?/* I2C */
> ?DEFINE_CLOCK(i2c1_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG9_OFFSET,
> ? ? ? ?NULL, NULL, &ipg_clk, NULL);
> @@ -1298,6 +1303,8 @@
> ? ? ? ?_REGISTER_CLOCK("imx-uart.2", NULL, uart3_clk)
> ? ? ? ?_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
> ? ? ? ?_REGISTER_CLOCK("fec.0", NULL, fec_clk)
> + ? ? ? _REGISTER_CLOCK("mxc_pwm.0", "pwm", pwm1_clk)
> + ? ? ? _REGISTER_CLOCK("mxc_pwm.1", "pwm", pwm2_clk)
> ? ? ? ?_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
> ? ? ? ?_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
> ? ? ? ?_REGISTER_CLOCK("imx-i2c.2", NULL, hsi2c_clk)
> Index: linux-2.6-submit/arch/arm/mach-mx5/devices.c
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/mach-mx5/devices.c ? 2011-01-04 11:11:43.000000000 +0100
> +++ linux-2.6-submit/arch/arm/mach-mx5/devices.c ? ? ? ?2011-01-04 11:39:55.000000000 +0100
> @@ -120,6 +120,44 @@
> ? ? ? ?},
> ?};
[...]
> +struct platform_device mxc_pwm2_device = {
> + ? ? ? .name = "mxc_pwm",
> + ? ? ? .id = 1,
> + ? ? ? .num_resources = ARRAY_SIZE(pwm2_resources),
> + ? ? ? .resource = pwm2_resources,
> +};
> +

Why not follow the arch/arm/plat-mxc/devices/platform-imx-xxx to add
devices support?
I saw that some devices was added in arch/arm/mach-mx5/devices.c, but
most are in
 arch/arm/plat-mxc/devices/xx, what's the rule for it when we add
device support?

[...]
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
