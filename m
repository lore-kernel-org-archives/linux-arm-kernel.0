From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 10 Jan 2018 15:37:57 +0800
Subject: [PATCH v2 0/2] phy: rockchip-emmc: fixes emmc-phy power on failed
 with rk3399 SoCs
Message-ID: <1515569879-31808-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

Since the Shawn isn't available, I take over this series patches for now.

As the original bug had tracked on https://issuetracker.google.com/71561742.
In some cases, the mmc phy power on failed during booting up.
The log as below:
...
[   2.375333] rockchip_emmc_phy_power: caldone timeout.
[    2.377815] phy phy-ff770000.syscon:phy at f780.4: phy poweron failed --> -110
...
[    2.489295] mmc0: mmc_select_hs400es failed, error -110
[    2.489302] mmc0: error -110 whilst initialising MMC card
..

The actual emulate, the wait 5us for calpad busy trimming, that's no enough.
We need give the enough margin for it.

Verified on url =
        https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4
This series patches can apply and bring up with kernel-next on rk3399 chromebook.

-Caesar


Changes in v2:
- print the return valut with regmap_read_poll_timeout failing.
- As Brian commented on https://patchwork.kernel.org/patch/10139891/,
  changed the note and added to print error value with
  regmap_read_poll_timeout API.

Shawn Lin (2):
  phy: rockchip-emmc: retry calpad busy trimming
  phy: rockchip-emmc: use regmap_read_poll_timeout to poll dllrdy

 drivers/phy/rockchip/phy-rockchip-emmc.c | 60 +++++++++++++++-----------------
 1 file changed, 28 insertions(+), 32 deletions(-)

-- 
2.7.4
