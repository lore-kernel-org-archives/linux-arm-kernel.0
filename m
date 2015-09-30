From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 30 Sep 2015 11:36:27 -0700
Subject: [PATCH 2/2] mtd: sunxi: nand: refactor
 ->read_page()/->write_page() code
In-Reply-To: <1442389597-30698-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1442389597-30698-1-git-send-email-boris.brezillon@free-electrons.com>
 <1442389597-30698-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150930183627.GH143959@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 09:46:37AM +0200, Boris Brezillon wrote:
> Most of the logic to read/write pages with the HW ECC engine enabled
> is common to the HW_ECC and NAND_ECC_HW_SYNDROME scheme.
> Refactor the code to avoid code duplication.

Hmm, a benign commit description to describe a somewhat complicated
patch. This seems to do several different types of refactoring all at
once, and it makes it a bit hard to review. Can you perhaps refactor
this into 2 or more patches? e.g., I think the NFC_USER_DATA_TO_BUF()
stuff can be orthogonal from the introduction of
sunxi_nfc_hw_ecc_read_chunk() and sunxi_nfc_hw_ecc_read_extra_oob().

> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/mtd/nand/sunxi_nand.c | 404 ++++++++++++++++++++++--------------------
>  1 file changed, 212 insertions(+), 192 deletions(-)
> 
> diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
> index dc44435..640b96c 100644
> --- a/drivers/mtd/nand/sunxi_nand.c
> +++ b/drivers/mtd/nand/sunxi_nand.c
> @@ -159,6 +159,13 @@
>  /* NFC_USER_DATA helper macros */
>  #define NFC_BUF_TO_USER_DATA(buf)	((buf)[0] | ((buf)[1] << 8) | \
>  					((buf)[2] << 16) | ((buf)[3] << 24))
> +#define NFC_USER_DATA_TO_BUF(buf, val)	\
> +	{				\
> +		(buf)[0] = val;		\
> +		(buf)[1] = val >> 8;	\
> +		(buf)[2] = val >> 16;	\
> +		(buf)[3] = val >> 24;	\
> +	}

Two things about this macro:

  1) you should probably wrap 'val' in parentheses

  2) the use of 'val' 4 times in this macro means it will be evaluated 4
  times; this *can* be OK, except the 'val' parameter as used in context
  is actually a register read (readl()). Is this intentional? Anyway,
  such a construct kinda hides the actual behavior, whether or not it's
  intentional.

To kill off all concerns, perhaps this should be a static inline
function instead. And we might do the same with NFC_BUF_TO_USER_DATA()
then, to match.

Brian

>  
>  #define NFC_DEFAULT_TIMEOUT_MS	1000
>  

[snip rest of patch]
