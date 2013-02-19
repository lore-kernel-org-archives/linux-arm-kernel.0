From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Feb 2013 14:41:57 -0700
Subject: [PATCH v3 3/8] ARM i.MX6q: Add GPU, VPU, IPU, and OpenVG resets
 to System Reset Controller (SRC)
In-Reply-To: <1361273732-23357-4-git-send-email-p.zabel@pengutronix.de>
References: <1361273732-23357-1-git-send-email-p.zabel@pengutronix.de>
 <1361273732-23357-4-git-send-email-p.zabel@pengutronix.de>
Message-ID: <5123F1A5.8070507@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2013 04:35 AM, Philipp Zabel wrote:
> The SRC has auto-deasserting reset bits that control reset lines to
> the GPU, VPU, IPU, and OpenVG IP modules. This patch adds a reset
> controller that can be controlled by those devices using the
> reset controller API.

> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig

> +static int imx_src_reset(struct reset_controller_dev *rcdev,
> +		unsigned long sw_reset_idx)
...
> +	if (sw_reset_idx >= ARRAY_SIZE(sw_reset_bits))
> +		return -EINVAL;

If each reset controller were to implement an "of_xlate" function, that
error-checking could be implemented there instead. Although that would
prevent using a common shared of_xlate implementation, unless you also
add a "max reset ID" field to struct reset_controller_dev.
