From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 15 Mar 2011 19:36:45 +0100
Subject: [PATCH v2 1/1] Add core support for QQ2440.
In-Reply-To: <20110314132312.GB11441@dandreoli.com>
References: <20110314131837.540942890@gmail.com>
	<20110314132312.GB11441@dandreoli.com>
Message-ID: <4D7FB1BD.6000304@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2011 02:23 PM, Domenico Andreoli wrote:
>+static void qq2440_udc_pullup(enum s3c2410_udc_cmd_e cmd)
>+{
>+	pr_debug("udc: pullup(%d)\n", cmd);
>+
>+	switch (cmd) {
>+	case S3C2410_UDC_P_ENABLE:
>+		gpio_set_value(S3C2410_GPG(12), 1);
>+		break;
>+	case S3C2410_UDC_P_DISABLE:
>+		gpio_set_value(S3C2410_GPG(12), 0);
>+		break;
>+	case S3C2410_UDC_P_RESET:
>+		break;
>+	default:
>+		break;
>+	}
>+}
>+
>+static struct s3c2410_udc_mach_info qq2440_udc_cfg __initdata = {
>+	.udc_command = qq2440_udc_pullup,
>+};

I've recently added support to the s3c2410_udc driver to handle controlling the
pullup itself if an gpio is used[1].

 You should be able to simplify this part to:

+static struct s3c2410_udc_mach_info qq2440_udc_cfg __initdata = {
+	.pullup_pin = S3C2410_GPG(12),
+};

- Lars

[1]
http://git.kernel.org/?p=linux/kernel/git/gregkh/usb-2.6.git;a=commit;h=a74022a55e44fe2044ac3660452cafecb300aece
