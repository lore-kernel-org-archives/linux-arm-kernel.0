From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 7 Jul 2014 16:52:22 -0700
Subject: [PATCH] mtd: nand: stm_nand_bch: add new driver
In-Reply-To: <20140703100522.756f9715@bbrezillon>
References: <1401268805-26043-1-git-send-email-lee.jones@linaro.org>
 <20140703002237.GM3599@ld-irv-0074>
 <20140703100522.756f9715@bbrezillon>
Message-ID: <20140707235222.GC7537@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Thu, Jul 03, 2014 at 10:05:22AM +0200, Boris BREZILLON wrote:
> On Wed, 2 Jul 2014 17:22:37 -0700 Brian Norris <computersforpeace@gmail.com> wrote:
> > On Wed, May 28, 2014 at 10:20:05AM +0100, Lee Jones wrote:
> > > +
> > > +	nand_timing0: nand-timing {
> > > +		sig-setup	= <10>;
> > > +		sig-hold	= <10>;
> > > +		CE-deassert	= <0>;
> > > +		WE-to-RBn	= <100>;
> > > +		wr-on		= <10>;
> > > +		wr-off		= <30>;
> > > +		rd-on		= <10>;
> > > +		rd-off		= <30>;
> > > +		chip-delay	= <30>;		/* delay in us */
> > > +	};
> > 
> > You didn't document any of this node. And I don't think we want to
> > specify every single timing parameter in DT; it may make sense to use
> > Boris Brezillon's approach (I note this further down, in the driver
> > code) for mapping non-ONFI NAND timings into a compatible ONFI timing
> > mode. This will greatly simplify the bindings needed, since it's
> > standardized and auto-detectable in many cases.
> 
> 
> AFAIR, the NAND timing representation for non-ONFI chips question was
> left unanswered:
> 
> https://lkml.org/lkml/2014/5/20/581
> 
> I can definitely respin my NAND timings series, but I'd like to be sure
> this is how you want it done before doing so.

Can we start by supporting ONFI-only (or ONFI-only, plus entries in
nand_flash_ids[]), and have nand_base provide the translation so drivers
can retrieve the info? Then we can begin supporting new drivers like
Lee's, and worry about the DT question separately.

BTW, Lee: you're completely missing the definitions for
'struct nand_sdr_timings' in this patch, so it doesn't compile.

> Just as a reminder, you and Jason thought NAND timings for non-ONFI
> chips could be auto detected thanks to READID informations (by storing
> some sort of "NANDID <-> timings" association table).

Yes, thanks for the reminder. I knew there was more than one reason I
was wary of Lee's patch (first, that it was duplication of another patch
set; and second, than I'm not sure it belongs in DT at all).

I think we should attempt to solve this without any need for DT
bindings, as most other parameters are auto-detectable in some sense
(even if we have to store some NANDID <-> timings tables). I think going
forward, we can expect that new NAND will use a JEDEC or ONFI spec, and
that we shouldn't have to scale nand_flash_ids[] to include too many
flash chip timings.

Brian
