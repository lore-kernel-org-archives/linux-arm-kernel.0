From: adrian.hunter@intel.com (Adrian Hunter)
Date: Wed, 22 Jun 2016 15:34:13 +0300
Subject: [PATCH v3 06/15] mmc: sdhci-of-arasan: Always power the PHY
 off/on when clock changes
In-Reply-To: <1466445414-11974-7-git-send-email-dianders@chromium.org>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org>
 <1466445414-11974-7-git-send-email-dianders@chromium.org>
Message-ID: <576A85C5.2060700@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/16 20:56, Douglas Anderson wrote:
> In commit 802ac39a5566 ("mmc: sdhci-of-arasan: fix set_clock when a phy
> is supported") we added code to power the PHY off and on whenever the
> clock was changed but we avoided doing the power cycle code when the
> clock was low speed.  Let's now do it always.
> 
> Although there may be other reasons for power cycling the PHY when the
> clock changes, one of the main reasons is that we need to give the DLL a
> chance to re-lock with the new clock.
> 
> One of the things that the DLL is for is tuning the Receive Clock in
> HS200 mode and STRB in HS400 mode.  Thus it is clear that we should make
> sure we power cycle the PHY (and wait for the DLL to lock) when we know
> we'll be in one of these two speed modes.  That's what the original code
> did, though it used the clock rate rather than the speed mode.  However,
> even in speed modes other than HS200,/HS400 the DLL is used for
> something since it can be clearly observed that the PHY doesn't function
> properly if you leave the DLL off.
> 
> Although it appears less important to power cycle the PHY and wait for
> the DLL to lock when not in HS200/HS400 modes (no bugs were reported),
> it still seems wise to let the locking always happen nevertheless.
> 
> Note: as part of this, we make sure that we never try to turn the PHY on
> when the clock is off (when the clock rate is 0).  The PHY cannot work
> when the clock is off since its DLL can't lock.
> 
> This change requires ("phy: rockchip-emmc: Increase lock time
> allowance") and will cause problems if picked without that change.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
