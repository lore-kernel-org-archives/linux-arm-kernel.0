From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 Apr 2012 11:59:13 -0700
Subject: [PATCH 25/40] ARM: imx: add common clock support for clk busy
In-Reply-To: <1334065553-7565-26-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-26-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4F848301.4080607@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/12 06:45, Sascha Hauer wrote:
> +static int clk_busy_wait(void __iomem *reg, u8 shift)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(10);
> +
> +	while (readl_relaxed(reg) & (1 << shift))
> +		if (time_after(jiffies, timeout))
> +			return -ETIMEDOUT;
> +
> +	return 0;
> +}

MSM also has a bit to poll to see if a clock is enabled or not, similar
to this rate switch complete bit. Would it make sense to have another
few clock ops like wait_for_enable(), wait_for_rate(),
wait_for_disable()? Then you should be able to copy the basic divider
ops and assign the wait ops and avoid the wrappers.

Also, why are these drivers in arch/arm? Shouldn't we be putting all
clock drivers into drivers/clk/ now?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
