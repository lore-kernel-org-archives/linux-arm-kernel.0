From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 07 Dec 2017 16:51:13 +0100
Subject: [PATCH net-next v2 3/8] net: phy: meson-gxl: add read and write
 helpers for bank registers
In-Reply-To: <20171207154610.GG24750@lunn.ch>
References: <20171207142715.32578-1-jbrunet@baylibre.com>
 <20171207142715.32578-4-jbrunet@baylibre.com>
 <20171207154610.GG24750@lunn.ch>
Message-ID: <1512661873.7042.9.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-12-07 at 16:46 +0100, Andrew Lunn wrote:
> On Thu, Dec 07, 2017 at 03:27:10PM +0100, Jerome Brunet wrote:
> > Add read and write helpers to manipulate banked registers on this PHY
> > This helps clarify the settings applied to these registers in the init
> > function and upcoming changes.
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  drivers/net/phy/meson-gxl.c | 103 ++++++++++++++++++++++++++++-------------
> > ---
> >  1 file changed, 67 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
> > index d82aa8cea401..05054770aefb 100644
> > --- a/drivers/net/phy/meson-gxl.c
> > +++ b/drivers/net/phy/meson-gxl.c
> > @@ -45,11 +45,13 @@
> >  #define FR_PLL_DIV0	0x1c
> >  #define FR_PLL_DIV1	0x1d
> >  
> > -static int meson_gxl_config_init(struct phy_device *phydev)
> > +static int meson_gxl_open_banks(struct phy_device *phydev)
> 
> Hi Jerome
> 
> Does the word bank come from the datasheet? Most of the phy drives use
> page instead.
> 
> Also, we have discovered a race condition which affects drivers using
> pages, which can lead to corruption of registers. At some point, i
> expect we will be adding helpers to access paged registers, which do
> the right thing with respect to locks.
> 
> So it would be nice if you used the work page, not bank.

Banks actually comes from the datasheet, Yes.
I don't mind renaming it but I would be making things up. As you wish ?

Does the usual pages comes with this weird toggle thing to open the access ?
Would we able to use these generic helpers with our this kind of quirks ?

> 
>    Thanks
> 
>       Andrew
