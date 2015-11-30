From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Nov 2015 13:33:01 +0100
Subject: [PATCH] phy: sun9i-usb: add USB dependency
In-Reply-To: <CAGb2v67aC4VtKKMa6ORbokVBRDMOeymeWasrvoiStao44Si8YA@mail.gmail.com>
References: <2655929.DjdP30bhQY@wuerfel>
 <CAGb2v67aC4VtKKMa6ORbokVBRDMOeymeWasrvoiStao44Si8YA@mail.gmail.com>
Message-ID: <14088458.Tx1bFTs7bY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 November 2015 20:27:04 Chen-Yu Tsai wrote:
> On Mon, Nov 30, 2015 at 7:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > The sun9i usb phy driver calls of_usb_get_phy_mode(), which is not
> > available if USB is disabled:
> >
> > drivers/built-in.o: In function `sun9i_usb_phy_probe':
> > :(.text+0x7fb0): undefined reference to `of_usb_get_phy_mode'
> >
> > This adds a dependency to avoid the randconfig build errors.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Fixes: 9c3b44302636 ("phy: Add driver to support individual USB PHYs on sun9i")
> >
> > diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> > index 7eb5859dd035..03cb3ea2d2c0 100644
> > --- a/drivers/phy/Kconfig
> > +++ b/drivers/phy/Kconfig
> > @@ -233,6 +233,7 @@ config PHY_SUN9I_USB
> >         tristate "Allwinner sun9i SoC USB PHY driver"
> >         depends on ARCH_SUNXI && HAS_IOMEM && OF
> >         depends on RESET_CONTROLLER
> > +       depends on USB_COMMON
> 
> USB_SUPPORT seems like the one to use. Some other phy drivers depend on this,
> and so does drivers/usb/phy/of.c, which is where of_usb_get_phy_mode()
> is located.

USB_SUPPORT is the user-selectable option that enables USB and USB_GADGET
to be selected, while USB_COMMON is automatically enabled if one of those
two is.

If you have USB_SUPPORT=y but both USB and USB_GADGET disabled, then
Kbuild does not enter the drivers/usb/phy directory and you still
get the build failure.

	Arnd
