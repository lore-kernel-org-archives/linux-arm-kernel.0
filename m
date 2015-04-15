From: dianders@chromium.org (Doug Anderson)
Date: Wed, 15 Apr 2015 15:38:12 -0700
Subject: [PATCH] ARM: rockchip: disable dapswjdp during suspend
In-Reply-To: <1429077431-31326-1-git-send-email-zyw@rock-chips.com>
References: <1429077431-31326-1-git-send-email-zyw@rock-chips.com>
Message-ID: <CAD=FV=W6yw8TN7GpwU-fn5WAkNSc0MYSWgQbSuurKCdM+8d5Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

On Tue, Apr 14, 2015 at 10:57 PM, Chris Zhong <zyw@rock-chips.com> wrote:
> Reset dapswjdp is controlled by JTAG_TRSTN, if the iomux of this pin is
> not "jtag_trstn". the AP would think this pin is always high, so it can
> not reset before resume. When system resume, but the dapswjdp is not in
> a default state, it may Access some illegal address, it cause system
> crash during resume.
> Let's disable this jtag function by clear the dapdeviceen bit, it
> prohibit the dapswjdp to access memory and registers. This bit would
> be enable in MASKROM, so we need clear it in suspend everytime.
>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>
> ---
>
>  arch/arm/mach-rockchip/pm.c | 7 +++++++
>  arch/arm/mach-rockchip/pm.h | 4 ++++
>  2 files changed, 11 insertions(+)

I can't say that I understand 100% of the interactions here, but I
don't think anyone without full access to the MaskROM code would be
able to understand this fully.

...but this seems sane to me.  I guess disabling it here and then
enabling it in the MaskROM will effectively give it a good reset so
we're all good.

Reviewed-by: Doug Anderson <dianders@chromium.org>

I'll trust your testing on this, since you have actual machines that
reproduce the issue.

-Doug
