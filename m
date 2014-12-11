From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 11 Dec 2014 01:52:38 +0100
Subject: [RFC/PATCH 5/7] arm: omap: hwmod: allow for registration of
 class-less hwmods
In-Reply-To: <20141210145433.GC4602@saruman>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
 <1418164072-19087-6-git-send-email-balbi@ti.com>
 <54882576.8020609@ti.com> <20141210145433.GC4602@saruman>
Message-ID: <20141211005238.GC5585@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 08:54:33AM -0600, Felipe Balbi wrote:
> Hi,
> 
> (adding linux-omap back to the loop)
> 
> On Wed, Dec 10, 2014 at 04:20:30PM +0530, Lokesh Vutla wrote:
> > Hi Felipe,
> > 
> > On Wednesday 10 December 2014 03:57 AM, Felipe Balbi wrote:
> > > Before this patch, HWMOD requires the existence
> > > of a struct omap_hwmod_class very early.
> > Yes, hwmod code looks for omap_hwmod_class entry before registering any hwmod.
> > 
> > With the patch 4/7 omap_hwmod_class gets populated from dt very late after registration of the hwmod.
> > So all the hwmod which gets class data from dt never gets registered and state is always UNKNOWN.
> > Mostly making it unusable.
> > IMO this patch just masks the problem.
> > 
> > In order to register hwmod we need to populate class data very early.
> > We can populate at the same place as how reg property is being parsed.
> > Call omap_hwmod_init_sysc() in _init() of the particular hwmod:
> > The below diff will help:
> >
> > diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> > index cbb908d..05ecf8a 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod.c
> > @@ -2415,6 +2415,116 @@ static int __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data,
> >  	return 0;
> >  }
> >  
> > +static int omap_hwmod_has_sysc_bindings(struct device_node *node)
> > +{
> > +	char *properties[] = {
> > +		"ti,rev_offs",
> > +		"ti,sysc_offs",
> > +		"ti,syss_offs",
> > +		"ti,sysc_flags",
> > +		"ti,srst_udelay",
> > +		"ti,idlemodes",
> > +		"ti,clockact",
> > +		"ti,sysc_type",
> > +		NULL
> > +	};
> > +	char **tmp = properties;
> > +
> > +	while (*tmp) {
> > +		if (of_property_read_bool(node, *tmp)) {
> > +			return true;
> > +		}
> > +		tmp++;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int omap_hwmod_init_sysc(struct device_node *node,
> > +		struct omap_hwmod *oh, int index)
> > +{
> > +	struct omap_hwmod_class *class = oh->class;
> > +	struct omap_hwmod_class_sysconfig *sysc;
> > +	int ret;
> > +	int i;
> > +	char name[128];
> > +	const char *tmp = oh->name;
> > +	u32 prop;
> > +
> > +	/* if data isn't provided by DT, skip */
> > +	if ((class && class->sysc) || !omap_hwmod_has_sysc_bindings(node))
> > +		return 0;
> > +
> > +	class = kzalloc(sizeof(*class), GFP_KERNEL);
> > +	if (!class)
> > +		return -ENOMEM;
> > +
> > +	i = 0;
> > +	while (*tmp) {
> > +		if (isalpha(*tmp))
> > +			name[i++] = *tmp;
> > +		tmp++;
> > +	}
> > +	name[i] = '\0';
> > +
> > +	class->name = kzalloc(sizeof(name), GFP_KERNEL);
> > +	if (!class->name)
> > +		return -ENOMEM;
> > +	strncpy(class->name, name, sizeof(name) - 1);
> > +
> > +	sysc = kzalloc(sizeof(*sysc), GFP_KERNEL);
> > +	if (!sysc)
> > +		return -ENOMEM;
> > +
> > +	ret = of_property_read_u32_index(node, "ti,rev_offs", index, &prop);
> > +	if (!ret)
> > +		sysc->rev_offs = prop;
> > +
> > +	ret = of_property_read_u32_index(node, "ti,sysc_offs", index, &prop);
> > +	if (!ret)
> > +		sysc->sysc_offs = prop;
> > +
> > +	ret = of_property_read_u32_index(node, "ti,syss_offs", index, &prop);
> > +	if (!ret)
> > +		sysc->syss_offs = prop;
> > +
> > +	ret = of_property_read_u32_index(node, "ti,sysc_flags", index, &prop);
> > +	if (!ret)
> > +		sysc->sysc_flags = prop & 0xffff;
> > +
> > +	ret = of_property_read_u32_index(node, "ti,srst_udelay", index, &prop);
> > +	if (!ret)
> > +		sysc->srst_udelay = prop & 0xff;
> > +
> > +	ret = of_property_read_u32_index(node, "ti,idlemodes", index, &prop);
> > +	if (!ret)
> > +		sysc->idlemodes = prop & 0xff;
> > +
> > +	ret = of_property_read_u32_index(node, "ti,clockact", index, &prop);
> > +	if (!ret)
> > +		sysc->clockact = prop & 0xff;
> > +
> > +	ret = of_property_read_u32_index(node, "ti,sysc_type", index, &prop);
> > +	if (ret)
> > +		prop = 1;
> > +
> > +	switch (prop) {
> > +	case 2:
> > +		sysc->sysc_fields = &omap_hwmod_sysc_type2;
> > +		break;
> > +	case 3:
> > +		sysc->sysc_fields = &omap_hwmod_sysc_type3;
> > +		break;
> > +	case 1:
> > +	default:
> > +		sysc->sysc_fields = &omap_hwmod_sysc_type1;
> > +	}
> > +	class->sysc = sysc;
> > +	oh->class = class;
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * _init - initialize internal data for the hwmod @oh
> >   * @oh: struct omap_hwmod *
> > @@ -2449,6 +2559,12 @@ static int __init _init(struct omap_hwmod *oh, void *data)
> >  		else if (np && index)
> >  			pr_warn("omap_hwmod: %s using broken dt data from %s\n",
> >  				oh->name, np->name);
> > +
> > +		if (np) {
> > +			r = omap_hwmod_init_sysc(np, oh, 0);
> 
> this won't handle any binding which lists more than one hwmod on its
> ti,hwmods property.

I think Tony planned to remove this kind of multi hwmod references.

IMHO instead of DT referencing the hwmod stuff using ti,hwmods the
hwmod database should reference the compatible values. This depends
on omap3 being DT only of course.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141211/0a19b896/attachment.sig>
