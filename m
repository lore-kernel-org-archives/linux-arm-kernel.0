From: sergio.prado@e-labworks.com (Sergio Prado)
Date: Mon, 19 Sep 2016 23:24:46 -0300
Subject: [PATCH] mtd: s3c2410: add device tree support
In-Reply-To: <20160919091155.GB11118@leverpostej>
References: <1474125760-28168-1-git-send-email-sergio.prado@e-labworks.com>
 <20160919091155.GB11118@leverpostej>
Message-ID: <20160920022446.GB11294@n1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 10:11:55AM +0100, Mark Rutland wrote:
> On Sat, Sep 17, 2016 at 12:22:40PM -0300, Sergio Prado wrote:
> > Tested on FriendlyARM Mini2440
> > 
> > Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> > ---
> >  .../devicetree/bindings/mtd/samsung-s3c2410.txt    |  70 +++++++++++
> >  drivers/mtd/nand/s3c2410.c                         | 129 ++++++++++++++++++++-
> >  include/linux/platform_data/mtd-nand-s3c2410.h     |   1 +
> >  3 files changed, 195 insertions(+), 5 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt b/Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt
> > new file mode 100644
> > index 000000000000..1c39f6cf483b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt
> > @@ -0,0 +1,70 @@
> > +* Samsung S3C2410 and compatible NAND flash controller
> > +
> > +Required properties:
> > +- compatible : The possible values are:
> > +	"samsung,s3c2410-nand"
> > +	"samsung,s3c2412-nand"
> > +	"samsung,s3c2440-nand"
> > +	"samsung,s3c6400-nand"
> > +- reg : register's location and length.
> > +- #address-cells, #size-cells : see nand.txt
> > +- clocks : phandle to the nand controller clock
> > +- clock-names : must contain "nand"
> 
> Is there only one clock feeding into the NAND block? Is it actually
> called "nand", or does the datasheet not give the input a nme?

Yes, there is only one clock associated with the NAND controller. The
clock is called "NAND Flash Controller" clock by the datasheet.

> 
> > +
> > +Optional properties:
> > +- samsung,tacls : time for active CLE/ALE to nWE/nOE
> > +- samsung,twrph0 : active time for nWE/nOE
> > +- samsung,twrph1 : time for release CLE/ALE from nWE/nOE inactive
> 
> If these are necessary, what units are these in?

They are probably not necessary and will be removed as suggested by
Boris Brezillon.

> 
> > +- samsung,ignore_unset_ecc : boolean to ignore error when we have
> > +                             0xff,0xff,0xff read ECC, on the
> > +                             assumption that it is an un-eccd page
> 
> s/_/-/ in property names, please.

OK. If I keep this property, I will change it to
samsung,ignore-unset-ecc.

> 
> That said, this name reads like policy rather than a HW description.
> Why/when is this necessary to set?

I'll evaluate if this property is really necessary, as suggested by
Boris Brezillon.

> 
> [...]
> 
> > +	of_property_read_u32(np, "samsung,tacls",  &pdata->tacls);
> > +	of_property_read_u32(np, "samsung,twrph0", &pdata->twrph0);
> > +	of_property_read_u32(np, "samsung,twrph1", &pdata->twrph1);
> 
> Are all values in the range [0, 0xffffffff] valid for these? If not, it
> would be a good idea to sanity-check the values.

OK.

> 
> > +	if (of_get_property(np, "samsung,ignore_unset_ecc", NULL))
> > +		pdata->ignore_unset_ecc = 1;
> 
> Use of_property_read_bool();

Right.

> 
> [...]
> 
> > +	for_each_available_child_of_node(np, child) {
> > +
> > +		sets->name = (char *)child->name;
> > +		sets->of_node = child;
> 
> Strictly speaking, you should increment the child node refcount here, as
> you maintain a reference to it and its name field.

OK.

> 
> > +		sets->nr_chips = 1;
> > +
> > +		if (!of_property_match_string(child, "nand-ecc-mode", "none"))
> > +			sets->disable_ecc = 1;
> > +
> > +		if (of_get_property(child, "nand-on-flash-bbt", NULL))
> > +			sets->flash_bbt = 1;
> 
> Use of_property_read_bool().

OK.

> 
> Thanks,
> Mark.

-- 
Sergio Prado
Embedded Labworks
Office: +55 11 2628-3461
Mobile: +55 11 97123-3420
