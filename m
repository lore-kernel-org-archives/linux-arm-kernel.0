From: marex@denx.de (Marek Vasut)
Date: Wed, 27 Nov 2013 20:06:41 +0100
Subject: [PATCH v6 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
In-Reply-To: <CAB5oZtDD_KV+QJPUiCxU3on_x5pFd=rZOK0fzYb+meojCJisiA@mail.gmail.com>
References: <0E83723C55F66F43A6041464FE31119D40FC99@039-SN2MPN1-011.039d.mgd.msft.net>
 <20131126072557.GA6113@S2101-09.ap.freescale.net>
 <CAB5oZtDD_KV+QJPUiCxU3on_x5pFd=rZOK0fzYb+meojCJisiA@mail.gmail.com>
Message-ID: <201311272006.41202.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Harro,

> On 26 November 2013 08:26, Shawn Guo <shawn.guo@linaro.org> wrote:
> > On Tue, Nov 26, 2013 at 06:04:16AM +0000, Richard Zhu wrote:
> >> [Richard] Based on the tag " pci-v3.13-fixes-1" on pci git-repos, imx6
> >> pcie had been tested on imx6 sabresd board.
> >> 
> >> The pcie works after enable pcie support in imx6qdl-sabresd.dtsi file.
> > 
> > Great, thanks, Richard.
> > 
> > Shawn
> 
> Thanks Richard,
> 
> TC1: The following does NOT work with the mainline Linux tree on my
> SabreSD with PCIe e1000e network card:
> $ git reset --hard v3.13-rc1
> $ git apply enable_pcie_on_imx6qdl_sabresd_board.patch # patch
> supplied by Richard Zhu
> result: "phy link never came up"
> 
> TC2: But the following does work with the mainline Linux tree:
> $ git reset --hard d95d3d53c7ef85ec0dc87db63aece18212c337b0 # HEAD is
> now at d95d3d5 Merge branch 'pci/host-imx6' into next (just a few
> commits after v3.12-rc2)
> $ git cherry-pick 1c4bfb9bd842f09318bc2fa37c1ee0d68bb4e8cb # [master
> f283273] PCI: imx6: Remove redundant dev_err() in imx6_pcie_probe()
> $ git cherry-pick 01ee0c70b5b935135dbe7fbf48115d9f16348474 # [master
> 5c93c84] PCI: imx6: Fix imprecise abort handler
> $ git cherry-pick 5dcb7c402409f4b1ecb279d5e846bdb1dff9bbe0 # [master
> c3cc5c5] PCI: imx6: Increase link startup timeout
> $ git cherry-pick 832f3ca20743911508e0cc1909415080a3128532 # [master
> b4a81be] PCI: imx6: Remove redundant of_match_ptr
> $ git cherry-pick ca6457dc1fbcc1f5ed1f8311e7fcf7ff129cda55 # [master
> 45aa4ab] PCI: imx6: Probe the PCIe in fs_initcall()
> $ git cherry-pick 212555bde33eeae0bec16d41bd4045fbebc0cfab # [master
> 4db342b] ARM: dts: imx6qdl: add pcie device node
> $ git cherry-pick 64990a431469a58b2949aca5be9d69e220d53892 # [master
> 7c29353] ARM: imx6q: Add pll4_audio_div to clock tree
> $ git cherry-pick bf22172158cd6dcc5be6dc286ff5c33794dd0ae8 # [master
> 5e5852f] ARM: imx: Add LVDS general-purpose clocks to i.MX6Q
> $ git cherry-pick 74b8031307c5d33d36742c26dd0921991bd5a255 # [master
> 05ae48c] ARM: imx6q: clock and Kconfig update for PCIe support
> $ git apply enable_pcie_on_imx6qdl_sabresd_board.patch # patch
> supplied by Richard Zhu
> result: lspci detects network card
> 
> I have also tested both test cases (TC1 + TC2) with the patches
> supplied by Marek Vasut on 26-11-2013:
> $ git apply 17_pci_imx6_make_reset-gpio_optional.patch
> $ git apply 37_pci_imx6_fix_waiting_for_link_up.patch
> $ git apply 47_pci_imx6_split_away_the_phy_reset.patch
> $ git apply 57_pci_imx6_split_away_the_link_up_wait_loop.patch
> $ git apply 67_pci_imx6_fix_link_start_operation.patch
> same results:
> TC1: "phy link never came up"
> TC2: lspci detects network card

A quick remark: try not to top-post replies in the ML, it's frowned upon.

btw. with my latest patches, do you see the link in Gen=1 or Gen=2 mode ? You 
will see a line in dmesg, eventually you can try 'dmesg | grep Gen' to find it.
