From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Wed, 25 Jul 2018 11:51:16 +0200
Subject: [PATCH v4 04/35] mtd: rawnand: denali: convert to nand_scan()
In-Reply-To: <CAK7LNASmJRWM7Gj9qqqZqwenPkoRFeA8tupx+3PKPXC6OxD_eA@mail.gmail.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-5-miquel.raynal@bootlin.com>
 <CAK7LNASmJRWM7Gj9qqqZqwenPkoRFeA8tupx+3PKPXC6OxD_eA@mail.gmail.com>
Message-ID: <20180725115116.1fb38fe3@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Jul 2018 18:42:44 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> 
> You need to remove kfree(denali->buf)
> from denali_remove(), right?

Absolutely.

> 
> void denali_remove(struct denali_nand_info *denali)
> {
>         struct mtd_info *mtd = nand_to_mtd(&denali->nand);
> 
>         nand_release(mtd);
>         kfree(denali->buf);       <---- REMOVE !!
>         denali_disable_irq(denali);
> }
> 
> 
> Otherwise, denali_remove() will free denali->buf twice
> because kfree(denali->buf) is called from denali_detach_chip().
