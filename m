From: jwerner@google.com (Julius Werner)
Date: Wed, 10 Sep 2014 13:22:44 -0700
Subject: [PATCH v6 4/4] phy: exynos5-usbdrd: Calibrate LOS levels for
 exynos5420/5800
In-Reply-To: <CAFp+6iErXKpXgE0tRPB=tEqXxcXgQAeFJP1TpSwRN6fNu9a-qw@mail.gmail.com>
References: <CAFp+6iEyqmbwMLFrBKD7NVLDAC=b+h1hPKFS=BG4k9D69hn_dg@mail.gmail.com>
 <20140903144225.GD31855@saruman.home>
 <CAFp+6iETPJCWMMkjHrpDcdCv=K0PbefYLa4eBOwN=aUY2=EHLA@mail.gmail.com>
 <20140905175651.GK24449@saruman.home>
 <CAFp+6iGU86yL8Ry3ArJJjBy2Cs0Em2B49yssH3BK5fJwyaZbtA@mail.gmail.com>
 <20140908134454.GK22409@saruman.home>
 <CAFp+6iG+gmD_JseytYuVQcRK9ErOqQrUEWJoU1KUU7PqMd=aRw@mail.gmail.com>
 <20140909144225.GF6151@saruman.home>
 <CAFp+6iHJKmeothDM67WW60Sqqj8BQroBCzZ8zecKwM_GcYL8HA@mail.gmail.com>
 <CAFp+6iHRJ5oAA+K1Y0Y2uadPhsR6wmrd13DM39dqiL4jj+swHg@mail.gmail.com>
 <20140910045328.GA32475@saruman.home>
 <CAFp+6iHMhbi4V4LAkNsgzDc192ihT2a1mZHgLbia=K2U8+x=2w@mail.gmail.com>
 <CAFp+6iErXKpXgE0tRPB=tEqXxcXgQAeFJP1TpSwRN6fNu9a-qw@mail.gmail.com>
Message-ID: <CAODwPW9QOD-7Wyc1Bh8QKfArSmsdqzYTOx6-gc8V5ace9-oPFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> right, use that to call phy_init() at the right time, then you need to
>> add a new ->calibrate() method which, likely, will only be used by you
>> ;-)

> so you mean, the xhci should itself call phy_init() at a time suitable,
> so that ->calibrate() is not required at all ?

I'm not sure if that's a good idea because it would require phy_init()
and calibrate() to always mean the same thing. The calibrate() for
Exynos5420 needs to be called both during boot and after system
resume, but there might be other platforms that don't want to
completely shutdown and reinit their PHYs during suspend/resume with
the same functions used for boot. For example, Tegra5 (proposed driver
at http://www.spinics.net/lists/linux-usb/msg113093.html) can
power-gate the PHY during suspend, but that's not running the same
code as in the phy_init()/phy_shutdown() methods (the posted patch
doesn't contain all power-gating code yet, but you can get an idea
about how it has to work from
https://chromium.googlesource.com/chromiumos/third_party/kernel-next/+/chromeos-3.10/drivers/usb/host/xhci-tegra.c).
It would also mean that the initial phy_init() call must always come
after the XHCI reset, and I am not sure if that would fit nicely with
all platforms.

> right, and what's more generic than adding the support for PHYs straight into xHCI ?

Well, if we are going to have a calibrate() method (as in "stuff the
PHY does after every controller reset if it needs to"), we have to add
it either to the XHCI stack or the USB core. I thought the USB core
would be more generic, because in theory it's possible that e.g. an
EHCI controller might have a similar requirement. (Also, we have the
gen_phy pointer in a USB core structure (struct usb_hcd), so I thought
making this feature generic to the USB core and thus available to all
kinds of host controllers would be more natural.)
