From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 23:47:35 +0200
Subject: [PATCHv2 2/3] usb: ehci-platform: Use devm_of_phy_get_by_index
In-Reply-To: <552D56EF.2020409@broadcom.com>
References: <1428963047-23666-1-git-send-email-arun.ramamurthy@broadcom.com>
 <552D2255.1050704@ti.com> <552D56EF.2020409@broadcom.com>
Message-ID: <4138287.C3OjQp3FFm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 April 2015 11:05:35 Arun Ramamurthy wrote:
> >
> > [1] ->
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/kbuild/kconfig-language.txt#n111
> >
> Kishon,removing select GENERIC_PHY also breaks the builds for certain 
> architectures (i386 and x84_64). Is the consensus to leave the select 
> but make GENERIC_PHY a invisible option? Thanks

I think the best solution is

- make GENERIC_PHY a silent option
- change PHY_RCAR_GEN2 to use 'select' instead of 'depends on', so
  it will still work when all other phy drivers are disabled
- change the non-phy drivers that select GENERIC_PHY to either
  use 'depends on' or no explicit dependency in case they are
  still functional without the API. Note that
  drivers/pinctrl/pinctrl-tegra-xusb.c is a phy provider as well,
  not a consumer, despite being outside of drivers/phy.

	Arnd
