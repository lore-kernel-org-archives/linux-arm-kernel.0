From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 9 Mar 2012 11:04:35 +0100
Subject: [PATCH 1/1] of: introduce helper to manage boolean
In-Reply-To: <20120309014441.8236B3E0903@localhost>
References: <1328588028-24766-1-git-send-email-plagnioj@jcrosoft.com>
 <20120309014441.8236B3E0903@localhost>
Message-ID: <20120309100435.GN27213@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:44 Thu 08 Mar     , Grant Likely wrote:
> On Tue,  7 Feb 2012 05:13:48 +0100, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> > of_property_read_bool
> > 
> > Search for a property in a device node and read a 32-bit value from
> > it. Returns 0 if <0> or if the property does not exist, 1 if <1> or none.
> > 
> > this will allow to disable a boolean
> > 
> > is-ok;          => true
> > is-ok = <1>;    => true
> > is-ok = <0>;    => false
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: devicetree-discuss at lists.ozlabs.org
> > ---
> > Hi,
> > 
> > 	if this is ok I'll rebase my mtd and i2c patch to use it
> > 
> > Best Regards,
> > J.
> >  drivers/of/base.c  |   30 ++++++++++++++++++++++++++++++
> >  include/linux/of.h |    8 ++++++++
> >  2 files changed, 38 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index 133908a..a0eaf08 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -686,6 +686,36 @@ int of_property_read_u64(const struct device_node *np, const char *propname,
> >  EXPORT_SYMBOL_GPL(of_property_read_u64);
> >  
> >  /**
> > + * of_property_read_bool - Find and read a boolean from a property
> > + * @np:		device node from which the property value is to be read.
> > + * @propname:	name of the property to be searched.
> > + *
> > + * Search for a property in a device node and read a 32-bit value from
> > + * it. Returns 0 if <0> or if the property does not exist, 1 if <1> or none.
> > + *
> > + * is-ok;	=> true
> > + * is-ok = <1>;	=> true
> > + * is-ok = <0>;	=> false
> > + */
> > +int of_property_read_bool(const struct device_node *np, const char *propname)
> > +{
> > +	u32 reg;
> > +	int ret = of_property_read_u32(np, propname, &reg);
> > +
> > +	switch (ret) {
> > +	case -EINVAL:
> > +		return false;
> > +	case -ENODATA:
> > +		return true;
> > +	case 0:
> > +		return reg == 1;
> 
> Ugh.  so any value other than 1 returns false?  I think that will surprise
> most people.
> 
> I don't like this api or binding.  If it is a bool property, then why isn't
> simply testing for the property existance sufficient?
no if you want to disable it

if a bool is define in the dtsi and want to disable it int the dts

if you we can do the the invert

if !0 => true

is-ok;			=> true
is-ok = <val != 0>;	=> true
is-ok = <0>;		=> false

Best Regards,
J.
