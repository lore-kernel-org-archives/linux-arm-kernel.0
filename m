From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Apr 2012 09:12:00 +0000
Subject: [PATCH v4 10/12] ARM: OMAP1: board files: deduplicate and clean
 some NAND-related code
In-Reply-To: <20120411003555.27059.96204.stgit@dusk>
References: <20120411003454.27059.37500.stgit@dusk>
 <20120411003555.27059.96204.stgit@dusk>
Message-ID: <201204110912.01216.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 April 2012, Paul Walmsley wrote:
> +void omap1_nand_cmd_ctl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
> +{
> +       struct nand_chip *this = mtd->priv;
> +       unsigned long mask;
> +
> +       if (cmd == NAND_CMD_NONE)
> +               return;
> +
> +       mask = (ctrl & NAND_CLE) ? 0x02 : 0;
> +       if (ctrl & NAND_ALE)
> +               mask |= 0x04;
> +
> +       mask |= (unsigned long)this->IO_ADDR_W;
> +
> +       writeb(cmd, (void __iomem *)mask);
> +}

IO_ADDR_W is always a page aligned pointer AFAICT, so you can actually
remove both casts and make it more readable at the same time by writing
the last two lines as

	writeb(cmd, this->IO_ADDR_W + mask);


	Arnd
