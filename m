From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 11 May 2011 01:40:33 +0200
Subject: [PATCH 5/9] at91: use structure to store the current soc
In-Reply-To: <4DC9B422.6070205@bluewatersys.com>
References: <20110510162730.GA18929@game.jcrosoft.org>
	<1305045259-23066-5-git-send-email-plagnioj@jcrosoft.com>
	<4DC9B422.6070205@bluewatersys.com>
Message-ID: <20110510234033.GB18929@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> > +
> > +static void soc_detect(u32 dbgu_base)
> > +{
> 
> This looks far better than your previous patch, and is how I suggested
> it should have been done :-).
> 
> I think possibly that this function should return an boolean indicating
> whether or not it was able to detect the cpu, rather than the calling
> function checking the internals of the at91_soc_data structure.
no need as at91_soc_data.type is init to SOC_AT91_NONE first
this ways we use less code
> 
> > +	u32 cidr, socid;
> > +
> > +	cidr = __raw_readl(AT91_IO_P2V(dbgu_base) + AT91_DBGU_CIDR);
> > +	socid = cidr & ~AT91_CIDR_VERSION;
> >
> > +	switch (socid) {
> > +	case ARCH_ID_AT572D940HF:
> > +		at91_soc_data.type = SOC_572D940HF;
> > +		set_at91_boot_soc(at572d940hf_soc);
> > +		break;
> > +
> > +	case ARCH_ID_AT91CAP9: {
> > +#ifdef CONFIG_AT91_PMC_UNIT
> > +		u32 pmc_ver = at91_sys_read(AT91_PMC_VER);
> > +
> > +		if (pmc_ver == ARCH_REVISION_CAP9_B)
> > +			at91_soc_data.subtype = SOC_CAP9_REV_B;
> > +		else if (pmc_ver == ARCH_REVISION_CAP9_C)
> > +			at91_soc_data.subtype = SOC_CAP9_REV_C;
> > +#endif
> > +		at91_soc_data.type = SOC_CAP9;
> > +		set_at91_boot_soc(at91cap9_soc);
> > +		break;
> > +	}
> > +
> > +	case ARCH_ID_AT91RM9200:
> > +		at91_soc_data.type = SOC_RM9200;
> > +		set_at91_boot_soc(at91rm9200_soc);
> > +		break;
> > +
> > +	case ARCH_ID_AT91SAM9260:
> > +		at91_soc_data.type = SOC_SAM9260;
> > +		set_at91_boot_soc(at91sam9260_soc);
> > +		break;
> > +
> > +	case ARCH_ID_AT91SAM9261:
> > +		at91_soc_data.type = SOC_SAM9261;
> > +		set_at91_boot_soc(at91sam9261_soc);
 > +
> > +	if (at91_soc_data.type == SOC_AT91_NONE)
> > +		return;
> > +
> > +	at91_soc_data.cidr = cidr;
> 
> Why not directly assign this to at91_soc_data.cidr above and remove the
> cidr local variable?
because I prefer to udpate the global struct only if we detect the soc
> 
> > +
> > +	/* sub version of soc */
> > +	at91_soc_data.exid = __raw_readl(AT91_IO_P2V(dbgu_base) + AT91_DBGU_EXID);
> > +

> > +		case ARCH_EXID_AT91SAM9M11:
> > +			at91_soc_data.subtype = SOC_SAM9M11;
> > +			break;
> > +		}
> 
> If we reused the ARCH_EXID_ defines, then the above could become:
> 
> 	at91_soc_data.subtype = at91_soc_data.exid;
as sais in the commint comment to have a uniq subtype accross soc as example
g35 and 9m11 have the same exid
> 

> > +
> > +const char *get_at91_soc_type(struct at91_socinfo *c)
> > +{
> 
> Should probably be called at91_get_soc_type_name. Get get_type implies
> it will return the enum type value. I think the at91 prefix belongs at
> the start also.
> 
> Also, since at91_boot_soc is __initdata, the soc_name array should also
> be __initdata and this function should be __init.
no this data will be use for sysfs export later
and at91_soc_data is not __initdata
> 
> > +
> > +	if (at91_soc_data.type == SOC_AT91_NONE)
> > +		panic("AT91: Impossible to detect the SOC type");
> > +
> > +	pr_info("AT91: Detected soc type: %s\n", get_at91_soc_type(&at91_soc_data));
> > +	pr_info("AT91: Detected soc subtype: %s\n", get_at91_soc_subtype(&at91_soc_data));
> > +
> > +	if (!at91_boot_soc.init)
> > +		panic("AT91: Soc not enabled");
> 
> I would still like to see if it is possible to reorder these patches so
> that this intermediate rewrite is not needed.
there is none intermedaite write
> 
> >  
> >  	if (at91_boot_soc.map_io)
> >  		at91_boot_soc.map_io();
> > diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
> > index d847565..1125671 100644
> > --- a/arch/arm/mach-at91/soc.h
> > +++ b/arch/arm/mach-at91/soc.h
> > @@ -20,3 +20,41 @@ extern struct at91_soc at91sam9263_soc;
> >  extern struct at91_soc at91sam9g45_soc;
> >  extern struct at91_soc at91sam9rl_soc;
> >  extern struct at91_soc at91sam9x5_soc;
> > +
> > +#define set_at91_boot_soc(c) do { at91_boot_soc = c; } while(0)
> 
> Should be a static inline function.
a macro is fine here
> 
> > +
> > +#if !defined(CONFIG_ARCH_AT572D940HF)
> > +#define at572d940hf_soc	at91_boot_soc
> > +#endif
> 
> Possibly this needs to be reworked a little so that the user gets an
> informative if the soc type is detected correctly, but support for the
> soc is not included in the kernel?
it's already the case

Best Regards,
J.
