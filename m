From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 19 Feb 2014 12:17:03 -0800
Subject: [PATCH] clk: qcom: Add missing clock at index GCC_XO_CLK for
 MSM8974
In-Reply-To: <1392819521-25734-1-git-send-email-iivanov@mm-sol.com>
References: <1392819521-25734-1-git-send-email-iivanov@mm-sol.com>
Message-ID: <20140219201703.GG14769@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19, Ivan T. Ivanov wrote:
> From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> 
> Accessing GCC on MSM8974 trough <&gcc GCC_XO_CLK> lead to NULL

s/trough/through/

> pointer dereference. Fix this.
> 

I think you want to get the XO clock from the not yet upstreamed
RPM clock driver. This #define is for a gate that is internal to
the SoC sitting between the pin for XO and all downstream users
of the XO clock within the SoC. Futhermore, linux is not allowed
to control this gate because it's essential to the entire system.

This patch will work for now but we'll need to change the DTS in
the future to get the clock from the RPM node and then revert
this patch.

It may be better to just move the XO and sleep_clk_src clocks to
DT and make them fixed-rate clocks that get added by
of_clk_init(). Then when the RPM node is added we can remove the
XO node and update the usb node at the same time.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
