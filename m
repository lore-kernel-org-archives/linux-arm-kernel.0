From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 17 Jun 2016 18:09:04 +0530
Subject: [PATCH v2 0/11] Changes to support 150 MHz eMMC on rk3399
In-Reply-To: <1465859076-4868-1-git-send-email-dianders@chromium.org>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
Message-ID: <5763EF68.1040307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 14 June 2016 04:34 AM, Douglas Anderson wrote:
> The theme of this series of patches is to try to allow running the eMMC
> at 150 MHz on the rk3399 SoC, though the changes should still be correct
> and have merit on their own.  The motivation for running at 150 MHz is
> that doing so improves signal integrity and (with some eMMC devices)
> doesn't affect throughput.
> 
> These patches have been structured to keep things as separate as
> possible, but nevertheless there are still some dependencies between
> patches.  It probably makes the most sense for all of the non-device
> tree patches to go through a single tree.  If others agree, perhaps the
> most sane would be to get Acks from PHY maintainers and then to land the
> patches in the MMC tree.  Device tree patches should be able to be
> landed separately and the worst what would happen is a warning in the
> kernel log if you have the code without the device tree.
> 
> The code patches are based on Ulf's mmc-next, then 4 patches that are
> outstanding / ready to land.  Specifically:
> - https://patchwork.kernel.org/patch/9086501/
>   phy: rockchip-emmc: give DLL some extra time to be ready
> - https://patchwork.kernel.org/patch/9093681/
>   phy: rockchip-emmc: configure frequency range and drive impedance
> - https://patchwork.kernel.org/patch/9086511/
>   phy: rockchip-emmc: configure default output tap delay
> - https://patchwork.kernel.org/patch/9086531/
>   phy: rockchip-emmc: reindent the register definitions

Do you want all these "phy: rockchip-emmc:" along with the patch in this series
to go in MMC tree? Or I can take all the phy part in my linux-phy -next branch?

Thanks
Kishon
> 
> The device tree patches are based on Heiko's v4.8-armsoc/dts64.
> 
> If requested, I could repost my series with the outstanding code patches
> or I could try folding those patches into mine.  Since those patches
> aren't in 4.7-rc1 presumably they would also make sense to take through
> the MMC tree if others agree.
> 
> Changes in v2:
> - Indicate that 5.1 ms is calculated (Shawn).
> - Clean up description of rk3399 PHY (Shawn)
> - Add Rob Herring's Ack.
> - Reorder includes (Shawn)
> - Adjust commit message wording (Rob)
> - List out clocks and clock names (Rob)
> - Move code cleanup before set phyctrl_frqsel based on card clock (Shawn)
> - Warn if we're more than 15 MHz from ideal rate (Shawn)
> - Fix typo USB => SDHCI (Shawn)
> 
> Douglas Anderson (11):
>   phy: rockchip-emmc: Increase lock time allowance
>   mmc: sdhci-of-arasan: Always power the PHY off/on when clock changes
>   Documentation: mmc: sdhci-of-arasan: Add soc-ctl-syscon for corecfg
>     regs
>   mmc: sdhci-of-arasan: Properly set corecfg_baseclkfreq on rk3399
>   arm64: dts: rockchip: Add soc-ctl-syscon to sdhci for rk3399
>   Documentation: mmc: sdhci-of-arasan: Add ability to export card clock
>   mmc: sdhci-of-arasan: Add ability to export card clock
>   Documentation: phy: Let the rockchip eMMC PHY get an exported card
>     clock
>   phy: rockchip-emmc: Minor code cleanup in
>     rockchip_emmc_phy_power_on/off()
>   phy: rockchip-emmc: Set phyctrl_frqsel based on card clock
>   arm64: dts: rockchip: Provide emmcclk to PHY for rk3399
> 
>  .../devicetree/bindings/mmc/arasan,sdhci.txt       |  35 ++-
>  .../devicetree/bindings/phy/rockchip-emmc-phy.txt  |   9 +
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   5 +
>  drivers/mmc/host/sdhci-of-arasan.c                 | 333 +++++++++++++++++++--
>  drivers/phy/phy-rockchip-emmc.c                    | 120 ++++++--
>  5 files changed, 442 insertions(+), 60 deletions(-)
> 
