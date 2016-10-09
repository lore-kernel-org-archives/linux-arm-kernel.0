From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 9 Oct 2016 08:26:08 +0800
Subject: [PATCH] clk: hi6220: use CLK_OF_DECLARE_DRIVER for sysctrl and
 mediactrl clock init
In-Reply-To: <1475933892-16021-1-git-send-email-shawn.guo@linaro.org>
References: <1475933892-16021-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20161009002608.GA8772@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 08, 2016 at 09:38:12PM +0800, Shawn Guo wrote:
> The hi6220-sysctrl and hi6220-mediactrl are not only clock provider but
> also reset controller.  It worked fine that single sysctrl/mediactrl
> device node in DT can be used to initialize clock driver and populate
> platform device for reset controller.  But it stops working after
> commit 989eafd0b609 ("clk: core: Avoid double initialization of clocks")
> gets merged.  The commit sets flag OF_POPULATED during clock
> initialization to skip the platform device populating for the same
> device node.  On hi6220, it effectively makes hi6220-sysctrl reset
> driver not probe any more.
> 
> The patch changes hi6220 sysctrl and mediactrl clock init macro from
> CLK_OF_DECLARE to CLK_OF_DECLARE_DRIVER, so that the reset driver using
> the same hardware block can continue working.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> It fixes an issue that is seen on linux-next, i.e. the new added
> hi6220-sysctrl reset driver doesn't probe at all, and consequently the
> mmc driver fails to register.

Correction: the hi6220-sysctrl has been there for a while, and the issue
is discovered by mmc driver which adds reset support recently.  So
technically, this is a regression fix.

Shawn
