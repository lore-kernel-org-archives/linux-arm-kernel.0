From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jul 2011 18:10:20 +0100
Subject: [PATCH] mtd: s3c2410 nand: Remove uncessary null check
In-Reply-To: <4E27CD14.4090702@nvidia.com>
References: <1311230038-6111-1-git-send-email-jhbird.choi@samsung.com>
	<4E27CD14.4090702@nvidia.com>
Message-ID: <20110721171020.GE20310@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 12:24:12PM +0530, Varun Wadekar wrote:
> On Thursday 21 July 2011 12:03 PM, jhbird.choi at samsung.com wrote:
> > From: Jonghwan Choi <jhbird.choi@samsung.com>
> >
> > clk_get() return a pointer to the struct clk or an ERR_PTR().
> >
> > Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
> > ---
> >  drivers/mtd/nand/s3c2410.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
> > index 4405468..18ff2f5 100644
> > --- a/drivers/mtd/nand/s3c2410.c
> > +++ b/drivers/mtd/nand/s3c2410.c
> > @@ -723,7 +723,7 @@ static int s3c24xx_nand_remove(struct platform_device *pdev)
> >  
> >  	/* free the common resources */
> >  
> > -	if (info->clk != NULL && !IS_ERR(info->clk)) {
> > +	if (!IS_ERR(info->clk)) {
> 
> I think you should use IS_ERR_OR_NULL instead.

No.  Jonghwan Choi's patch is correct.

As per the patch description, the only error value which a driver can
attribute any problem with is something which passes IS_ERR().  Everything
else the driver must treat as a _valid_ struct clk - and the clk API
implementation must accept non-IS_ERR() clk_get() values.
