From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 21 Feb 2017 12:06:48 +0100
Subject: [RESEND PATCH 1/3] mtd: nand: Pass the CS line to
 ->setup_data_interface()
In-Reply-To: <a5a9d822-a73c-4fd1-201c-7a17d9517f24@sigmadesigns.com>
References: <1487625149-7234-1-git-send-email-boris.brezillon@free-electrons.com>
 <1487625149-7234-2-git-send-email-boris.brezillon@free-electrons.com>
 <a5a9d822-a73c-4fd1-201c-7a17d9517f24@sigmadesigns.com>
Message-ID: <20170221120648.19e0d32c@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Feb 2017 11:57:23 +0100
Marc Gonzalez <marc_gonzalez@sigmadesigns.com> wrote:

> On 20/02/2017 22:12, Boris Brezillon wrote:
> 
> > Some NAND controllers can assign different NAND timings to different
> > CS lines. Pass the CS line information to ->setup_data_interface() so
> > that the NAND controller driver knows which CS line is concerned by
> > the setup_data_interface() request.  
> 
> I'm confused, because I thought I was already doing that.
> On my platform, I have different timings for each chip.
> (thus, for each CS, right?)
> 
> In chip->select_chip, I program the appropriate timings
> which the controller will be using.
> 
> What am I missing?

Maybe you don't have multi-dies chips, which is the case I'm fixing
here. If you have 2 separate chips, the existing hook should work just
fine.

> 
> > diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
> > index c8894f31392e..d62a1c7c5c5c 100644
> > --- a/drivers/mtd/nand/nand_base.c
> > +++ b/drivers/mtd/nand/nand_base.c
> > @@ -1100,8 +1102,10 @@ static int nand_init_data_interface(struct nand_chip *chip)
> >  		if (ret)
> >  			continue;
> >  
> > -		ret = chip->setup_data_interface(mtd, chip->data_interface,
> > -						 true);
> > +		/* Pass -1 to only */  
> 
> "Pass -1 to only" what?
> 
> I suppose -1 means NAND_DATA_IFACE_CHECK_ONLY since
> #define NAND_DATA_IFACE_CHECK_ONLY -1
> 
> Maybe you meant "Pass -1 to check only" here?
> The comment may need a slight rework.

Yep, didn't finish my sentence.
Since I decided to define a macro with a self-descriptive name, I
don't think I need this comment anymore.

> 
> > +		ret = chip->setup_data_interface(mtd,
> > +						 NAND_DATA_IFACE_CHECK_ONLY,
> > +						 chip->data_interface);
> >  		if (!ret) {
> >  			chip->onfi_timing_mode_default = mode;
> >  			break;  
