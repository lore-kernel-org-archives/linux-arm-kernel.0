From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 18 Feb 2010 20:39:59 +0800
Subject: NDCBx registers in PXA3XX MTD driver
In-Reply-To: <62fd715d1002180406y1181bbe9y83ba3cd0277989c4@mail.gmail.com>
References: <62fd715d1002180406y1181bbe9y83ba3cd0277989c4@mail.gmail.com>
Message-ID: <f17812d71002180439p1585ea08l37b6d55327c53364@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2010 at 8:06 PM, Romain Bornet <bornet.romain@gmail.com> wrote:
> Hi folks,
>
> I'm rather new in the ARM / Linux world and currently working on a
> PXA168-based board.
>
> I'm trying to understand the implementation of the pxa3xx_nand.c
> driver and came across 3 lines of code I cannot understand.
>
> The 3 lines in question are the one where the NDCB0/1/2 registers are
> written in write_cmd()
> ---
> nand_writel(info, NDCB0, info->ndcb0);
> nand_writel(info, NDCB0, info->ndcb1);
> nand_writel(info, NDCB0, info->ndcb2);
> ---
>
> see here for context...
> http://lxr.linux.no/#linux+v2.6.32/drivers/mtd/nand/pxa3xx_nand.c#L459
>
> Why are all 3 values (ndcb0, ndcb1, ndcb2) written to the same
> register NDCB0 whereas the PXA3xx and PXA168 have different offsets
> (0x48, 0x4C and 0x50) for these 3 registers as documented in
> PXA3xx_DM_Vol_II in chapter "3.8.10 NAND Controller Command Buffers
> (NDCBx)" (available from Marvell @
> http://www.marvell.com/products/processors/applications/pxa_3xx/PXA3xx_Developers_Manual.zip
> )
>
> I first thought about a possible hardware Errata but couldn't find any
> hint in this direction.
>
> I would have expected
>
> nand_writel(info, NDCB0, info->ndcb0);
> nand_writel(info, NDCB1, info->ndcb1);
> nand_writel(info, NDCB2, info->ndcb2);
>

If you read the documentation a little bit more carefully, you'll know why.

Basically, the write is to NDCB0 _only_ and in turn writing to 0, 1, 2
respectively, reading of NDCB1 and NDCB2 is however, doable, which
will show you what you've written.
