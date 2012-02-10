From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Feb 2012 00:03:29 +0000
Subject: [PATCH v6 02/15] ARM: SoC: Add per SoC SMP and CPU hotplug
 operations
In-Reply-To: <20120208234253.GA16313@codeaurora.org>
References: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
 <1328661059-24584-3-git-send-email-marc.zyngier@arm.com>
 <20120208234253.GA16313@codeaurora.org>
Message-ID: <201202100003.29955.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 February 2012, David Brown wrote:
> On Wed, Feb 08, 2012 at 12:30:46AM +0000, Marc Zyngier wrote:
> 
> > +#ifdef CONFIG_SMP
> > +#define soc_smp_init_ops(ops)                .smp_init_ops = &(ops),
> > +#define soc_smp_ops(ops)             .smp_ops = &(ops),
> > +extern void soc_smp_ops_register(struct arm_soc_smp_init_ops *,
> > +                              struct arm_soc_smp_ops *);
> > +#else
> > +#define soc_smp_init_ops(ops)                /* empty */
> > +#define soc_smp_ops(ops)             /* empty */
> > +#define soc_smp_ops_register(a,b)    do {} while(0)
> > +#endif
> 
> I'm not sure if this bothers anyone else, but these macros mess up
> editors that know how to indent C code, since the comma ends up inside
> the macro.  I'm not sure I have a better idea, though.
> 

I would recommend following the pattern from __devexit_p() and make this

#ifdef CONFIG_SMP
#define soc_smp_init_ops(ops)      &(ops)
#else
#define soc_smp_init_ops(ops)      NULL
#endif

	Arnd
