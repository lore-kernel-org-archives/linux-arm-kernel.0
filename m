From: ivan.djelic@parrot.com (Ivan Djelic)
Date: Sat, 1 Dec 2012 22:50:14 +0100
Subject: [PATCH v3 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
In-Reply-To: <518397C60809E147AF5323E0420B992E3E9F25CB@DBDE01.ent.ti.com>
References: <5097B7EE.3000508@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9DC1F1@DBDE01.ent.ti.com>
 <509A2E75.5060307@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9DE420@DBDE01.ent.ti.com>
 <509EA360.2050504@gmail.com> <87mwycjmdn.fsf@dell.be.48ers.dk>
 <50ACA9BB.7090106@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9EEA09@DBDE01.ent.ti.com>
 <50B4C796.4010403@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9F25CB@DBDE01.ent.ti.com>
Message-ID: <20121201215014.GA11236@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 05:01:30AM +0000, Philip, Avinash wrote:
(...)
> 
> Daniel,
> 
> So can you start supporting "bch8-am335xrbl-compatible" and remove usage of
> is_elm_used in dt. This should come in ecc_opt field.
> 
> In omap2 NAND driver, AM335x RBL compatibility is achieved depending on ecc_layout
> and runtime detection of elm module. So options related to can be
> 1. bch8-am335xrbl-compatible is enabled and run time detection of
>    Of elm module passed, RBL compatibility achieved.
> 2. bch8-am335xrbl-compatible is enabled and run time detection of
>    of elm module failed, RBL compatibility sacrificed but continue with
>    software BCH8 error correction. Sacrificing RBL compatibility
>    because of constant polynomial addition and usage of 14 byte instead of 13 byte.
> 
> Ivan,
> Do you have any plan of removing addition of constant polynomial to ecc data
> and go for extra byte checking to find erased pages?
> This way we can start support BCH8 with RBL compatible and kernel
> Didn't put any restriction of the ecc layout.

Hello Avinash,

Sorry about the response delay.
First a short reminder of pros and cons of the "constant polynomial addition"
(let's just call it "CPA") feature:

pros:
- it elegantly solves all problems related to reading an erased page (no clumsy hack needed)
- better performance: when a bitflip appears on an erased page (often this is a "sticky" bitflip),
  there is no need to perform a full scan+cleanup of the page each time it is read

cons:
- the ecc vector is not compatible with RBL

RBL compatibility is not necessary in my case, because I'm using the OMAP MLC ROM boot mode.
Rather than completely removing the CPA feature, I'd like to keep it as an option; it could
even be used with the ELM module.

I'm OK to submit a patch in this direction, but first I'd like to wait for the dust to settle
on arch/arm/mach-omap2 and mtd/nand/omap2.c with Afzal patches and everything; things have become
a bit complicated to follow recently :-)
Also, I think it would be nice to move BCH code out of omap2.c into a separate file.
What do you think ?

BR,
--
Ivan
