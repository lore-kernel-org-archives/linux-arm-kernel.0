From: marex@denx.de (Marek Vasut)
Date: Fri, 10 Aug 2012 17:04:44 +0200
Subject: [PATCH] mtd: gpmi: add NAND write verify support
In-Reply-To: <CAMiH66FAVVPLZ9hCyRcNCm1Le2JrCc+55CUw7UCtPjw+31w5gw@mail.gmail.com>
References: <1344568737-902-1-git-send-email-b32955@freescale.com>
 <201208101325.23075.marex@denx.de>
 <CAMiH66FAVVPLZ9hCyRcNCm1Le2JrCc+55CUw7UCtPjw+31w5gw@mail.gmail.com>
Message-ID: <201208101704.44984.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Huang Shijie,

> On Fri, Aug 10, 2012 at 7:25 AM, Marek Vasut <marex@denx.de> wrote:
> > Dear Huang Shijie,
> > 
> >> Add NAND write verify support in gpmi-nand driver.
> >> 
> >> Signed-off-by: Huang Shijie <b32955@freescale.com>
> >> ---
> >> 
> >>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c |   17 +++++++++++++++++
> >>  1 files changed, 17 insertions(+), 0 deletions(-)
> >> 
> >> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> >> b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c index 8c0d2f0..6394483 100644
> >> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> >> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> >> @@ -1488,6 +1488,22 @@ static int gpmi_set_geometry(struct
> >> gpmi_nand_data *this) return gpmi_alloc_dma_buffer(this);
> >> 
> >>  }
> >> 
> >> +#define MAX_PAGESIZE 8192
> > 
> > Use NAND_MAX_PAGESIZE, see include/linux/mtd/nand.h .
> > 
> >> +static uint8_t verify_buf[MAX_PAGESIZE];
> 
> ok, thanks.
> 
> > What will happen when you have two NANDs attached to GPMI controller and
> > they hit this place both at once? Race condition, causing this function
> > to fail for both?
> 
> Even there are two nand chips, there is only one gpmi controller.

For now ... yes.

> And the current gpmi-nand does not support two nands now.
> does the race occur with only one nand chip?

With one chip and one GPMI controller, no ... but that's no reason to introduce 
crappy and error prone code!

> > Possibly devm_kmalloc() such buffer per-controller?
> > 
> >> +static int gpmi_verify_buf(struct mtd_info *mtd, const uint8_t *buf,
> >> int len) +{
> >> +     struct nand_chip *nand = mtd->priv;
> >> +     int ret;
> >> +
> >> +     ret = gpmi_ecc_read_page(mtd, nand, verify_buf, 0, 0);
> > 
> > mtd->chip.ecc.read_page() ?
> 
> In actually, they are the same.

They are, but if you rename the function, this is one less place to care for.

> 
> Best Regards
> Huang Shijie

Best regards,
Marek Vasut
