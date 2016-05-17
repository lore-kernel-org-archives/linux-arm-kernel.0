From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 17 May 2016 23:56:44 +0200
Subject: [PATCH 1/2] Revert "clk: rockchip: reset init state before mmc
 card initialization"
In-Reply-To: <1463076197-15900-1-git-send-email-dianders@chromium.org>
References: <1463076197-15900-1-git-send-email-dianders@chromium.org>
Message-ID: <1546506.kPA2J5E1Tb@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 12. Mai 2016, 11:03:16 schrieb Douglas Anderson:
> This reverts commit 7a03fe6f48f3 ("clk: rockchip: reset init state
> before mmc card initialization").
> 
> Though not totally obvious from the commit message nor from the source
> code, that commit appears to be trying to reset the "_drv" MMC clocks to
> 90 degrees (note that the "_sample" MMC clocks have a shift of 0 so are
> not touched).
> 
> The major problem here is that it doesn't properly reset things.  The
> phase is a two bit field and the commit only touches one of the two
> bits.  Thus the commit had the following affect:
> - phase   0  => phase  90
> - phase  90  => phase  90
> - phase 180  => phase 270
> - phase 270  => phase 270
> 
> Things get even weirder if you happen to have a bootloader that was
> actually using delay elements (should be no reason to, but you never
> know), since those are additional bits that weren't touched by the
> original patch.
> 
> This is unlikely to be what we actually want.  Checking on rk3288-veyron
> devices, I can see that the bootloader leaves these clocks as:
> - emmc:  phase 180
> - sdmmc: phase 90
> - sdio0: phase 90
> 
> Thus on rk3288-veyron devices the commit we're reverting had the effect
> of changing the eMMC clock to phase 270.  This probably explains the
> scattered reports I've heard of eMMC devices not working on some veyron
> devices when using the upstream kernel.
> 
> The original commit was presumably made because previously the kernel
> didn't touch the "_drv" phase at all and relied on whatever value was
> there when the kernel started.  If someone was using a bootloader that
> touched the "_drv" phase then, indeed, we should have code in the kernel
> to fix that.  ...and also, to get ideal timings, we should also have the
> kernel change the phase depending on the speed mode.  In fact, that's
> the subject of a recent patch I posted at
> <https://patchwork.kernel.org/patch/9075141/>.
> 
> Ideally, we should take both the patch posted to dw_mmc and this
> revert.  Since those will likely go through different trees, here I
> describe behavior with the combos:
> 
> 1. Just this revert: likely will fix rk3288-veyron eMMC on some devices
>    + other cases; might break someone with a strange bootloader that
>    sets the phase to 0 or one that uses delay elements (pretty
>    unpredicable what would happen in that case).
> 2. Just dw_mmc patch: fixes everyone.  Effectly the dw_mmc patch will
>    totally override the broken patch and fix everything.
> 3. Both patches: fixes everyone.  Once dw_mmc is initting properly then
>    any defaults from the clock code doesn't mattery.
> 
> Fixes: 7a03fe6f48f3 ("clk: rockchip: reset init state before mmc card
> initialization") Signed-off-by: Douglas Anderson <dianders@chromium.org>

I've tested this revert myself on rk3288-veyron-jerry and rk3288-firefly 
[everything still works] and have put it temporarily into my clk-fixes branch 
to hopefully get a report from kernelci for rk3288-rock2, but may drop it 
again if necessary.


Heiko
