From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Aug 2016 17:25:30 +0200
Subject: [PATCH v2 1/4] net: dt-bindings: Document the new Meson8b and
 GXBB DWMAC bindings
In-Reply-To: <CAFBinCA0HWHR3UbVX-_wU14W0-KOr-BAf5Nyn1ocZdnYxojn2Q@mail.gmail.com>
References: <20160815164100.27766-1-martin.blumenstingl@googlemail.com>
 <7308700.atIMKyMFZU@wuerfel>
 <CAFBinCA0HWHR3UbVX-_wU14W0-KOr-BAf5Nyn1ocZdnYxojn2Q@mail.gmail.com>
Message-ID: <4041259.IszN4229Cj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 22, 2016 2:04:49 PM CEST Martin Blumenstingl wrote:
> On Mon, Aug 22, 2016 at 1:55 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Saturday, August 20, 2016 11:35:35 AM CEST Martin Blumenstingl wrote:
> >> +- reg: The first register range should be the one of the DWMAC
> >> +       controller. The second range is is for the Amlogic specific
> >> +       configuration (for example the PRG_ETHERNET register range
> >> +       on Meson8b and newer)
> >>
> > ...
> >
> >> +Example for GXBB:
> >> +       ethmac: ethernet at c9410000 {
> >> +               compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac";
> >> +               reg = <0x0 0xc9410000 0x0 0x10000>,
> >> +                       <0x0 0xc8834540 0x0 0x8>;
> >>
> >
> > The address "0xc8834540" suggests that this is part of a larger register
> > range that is used for various things, i.e. a "syscon" type of device.
> You are right, these are part of the cbus range (which is already
> defined in meson-gxbb.dtsi)
> 
> > How about making this a syscon reference rather than a "reg" address?
> The first version of my patch ([0]) used
> syscon_regmap_lookup_by_phandle. Maybe I did it wrong (and I should
> have passed the cbus syscon-node instead of defining a new one just
> for the 2x32bit PRG_ETHERNET registers).
> I am perfectly fine with either way - however it seems that some other
> dwmac glue implementations are also using a second set of resources
> (that doesn't automatically make it "correct" though).

It really depends on the kind of SoC. Some may have a suboptimal
binding, on some others there may be a distinct register area that
just contains a few additional registers for the dwmac.

	Arnd
