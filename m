From: tony@atomide.com (Tony Lindgren)
Date: Wed, 4 May 2016 10:26:35 -0700
Subject: [PATCH] ARM: dts: omap5-igep0050: Correct hdmi regulator
In-Reply-To: <6ee9d67a-e907-715a-f3f5-d90a470314c3@ti.com>
References: <1461925297-9734-1-git-send-email-peter.ujfalusi@ti.com>
 <6ee9d67a-e907-715a-f3f5-d90a470314c3@ti.com>
Message-ID: <20160504172634.GS5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Adding Nishanth to Cc.

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160429 05:15]:
> ldo7_reg, obviously ;)
> 
> > 	status = "okay";
> > 	regulator-min-microvolt = <1800000>;
> > 	regulator-max-microvolt = <1800000>;
> > };

It really seems to be ldo7, otherwise there's no HDMI output. I don't
have the schematics either.

But it seems we have at least two other regressions in Linux next that
prevent me from testing this properly:

1. On igepv5, I get this for the MMC regulator

ldo9: bypassed regulator has no supply!
ldo9: failed to get the current voltage(-517)
palmas-pmic 48070000.i2c:palmas at 48:palmas_pmic: failed to register 48070000.i2c:palmar

I'm pretty sure it really is using the ldo9 for MMC just like
omap5-uevm.. Nishanth suggested it may use something else, but
why would it as ldo9 has a nice voltage range?

2. On both omap5-uevm and igepv5, NFSroot hangs

It seems that NFSroot boots to the point where PM runtime now
just shuts down some regulator affecting the USB connected
smsc Ethernet adapter?

Regards,

Tony
