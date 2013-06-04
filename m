From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 04 Jun 2013 18:01:07 +0200
Subject: [PATCHv2 1/3] net: phy: prevent linking breakage
In-Reply-To: <CAGVrzcbRS3x5fgD1BfOk4-oTUsAY9FA2V621OvZLJQNZ01brCg@mail.gmail.com>
References: <1369741403-25315-2-git-send-email-alexandre.belloni@free-electrons.com>
 <6466898.RnYOe3jpGG@wuerfel>
 <CAGVrzcbRS3x5fgD1BfOk4-oTUsAY9FA2V621OvZLJQNZ01brCg@mail.gmail.com>
Message-ID: <1394174.ONngHnHYKL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 June 2013 16:36:50 Florian Fainelli wrote:
> It seems to me that what David proposes is to have say an
> arch/arm/mach-foo/phy-fixups.c file which is only enabled when
> CONFIG_PHYLIB is set (obj-$(CONFIG_PHYLIB) += phy-fixup.o), such that
> it does not need to have any conditionnals when calling
> phy_register_fixup. This sounds a little unusual, but why not.

I don't think it would actually help us, because then we still need
to declare a local function that gets called from the board init
code. Instead of doing

	if (IS_ENABLED(CONFIG_PHYLIB))
		 phy_register_fixup_for_uid(phy_id, foo_phy_fixup);

we would then do

	if (IS_ENABLED(CONFIG_PHYLIB))
		foo_phy_fixup_register();

which is not much different at all.

	Arnd
