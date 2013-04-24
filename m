From: pekon@ti.com (Gupta, Pekon)
Date: Wed, 24 Apr 2013 05:34:21 +0000
Subject: [PATCH 21/21] mtd: omap2: allow bulding as a module
In-Reply-To: <20130423180320.GJ10155@atomide.com>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
 <1366734653-488286-22-git-send-email-arnd@arndb.de>
 <20130423180320.GJ10155@atomide.com>
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9BCFAE@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> * Arnd Bergmann <arnd@arndb.de> [130423 09:37]:
> > The omap2 nand device driver calls into the the elm code, which can
> > be a loadable module, and in that case it cannot be built-in itself.
> > I can see no reason why the omap2 driver cannot also be a module,
> > so let's make the option "tristate" in Kconfig to fix this allmodconfig
> > build error:
> >
> > ERROR: "elm_config" [drivers/mtd/nand/omap2.ko] undefined!
> > ERROR: "elm_decode_bch_error_page" [drivers/mtd/nand/omap2.ko]
> undefined!
> >
[Pekon]: 
ELM module is required in for Hardware based ECC correction for 
NAND devices. And this driver has a very small foot-print.

The only cases this drives would _not_ be used are:
(a) Using S/W based ECC scheme, which have vey high CPU utilization
(b) Using single bit ECC scheme, which are becoming obsolete due to
 increasing NAND densities.
For most of the cases ELM module will be used with nand-driver. So
there should be no harm in having this module as built-in, if not used
in 10% of the use-cases.

Thus I think it's better to keep this module tied to GPMC module, 
rather than independent control via KConfig.
And user should just selects which ECC scheme he would like to
use via DT, without worrying about KConfig options.

I'm working in cleaning up omap2-nand driver to remove some 
redundancies. So would like to know your feedback on same..


with regards, pekon
