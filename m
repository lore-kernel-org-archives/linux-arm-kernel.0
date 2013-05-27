From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 28 May 2013 00:20:05 +0200
Subject: [PATCH 1/3] net: phy: prevent linking breakage
In-Reply-To: <51A399D6.8030000@free-electrons.com>
References: <1369671524-14797-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1369671524-14797-2-git-send-email-alexandre.belloni@free-electrons.com>
 <20130527163913.GO32299@pengutronix.de>
 <51A399D6.8030000@free-electrons.com>
Message-ID: <201305272320.08296.f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 27 mai 2013 19:38, "Alexandre Belloni" <alexandre.belloni@free-
electrons.com> a ?crit :

[snip]

> >> +/*
> >> + *  phy_register_fixup{,_for_uid,_for_id} are called from arch/ so this 
won't
> >> + *  work unless phylib is compiled in the kernel.
> >> + *  Defining stubs allows to prevent linking errors.
> >> + */
> >> +#ifdef CONFIG_PHYLIB
> >>  int phy_register_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask,
> >>              int (*run)(struct phy_device *));
> >>  int phy_register_fixup_for_id(const char *bus_id,
> >>              int (*run)(struct phy_device *));
> >>  int phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
> >>              int (*run)(struct phy_device *));
> >> +#else
> >> +#define phy_register_fixup(a, b, c, d) do { } while (0)
> >> +#define phy_register_fixup_for_id(a, b) do { } while (0)
> >> +#define phy_register_fixup_for_uid(a, b, c) do { } while (0)
> > Use static inline functions here. This breaks if someone does result
> > checking on the functions which then expands to ret = do {} while (0);
> > Also we still have
> Right, I tried that first but forgot static so I had issues with
> redefinition of the functions. I even played with __weak at some point...

You might even want to make these static inlines as mentionned earlier, and 
return something like -ENOTSUPP so that someone using these in board code and 
wondering why they do not work gets a chance to enable CONIFG_PHYLIB.
--
Florian
