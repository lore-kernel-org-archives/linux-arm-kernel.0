From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 1 Dec 2017 11:39:57 +0900
Subject: [PATCH 3/5] mtd: nand: force drivers to explicitly send READ/PROG
 commands
In-Reply-To: <20171130170132.27522-4-miquel.raynal@free-electrons.com>
References: <20171130170132.27522-1-miquel.raynal@free-electrons.com>
 <20171130170132.27522-4-miquel.raynal@free-electrons.com>
Message-ID: <CAK7LNAQQVEoVXDC6+=O1fDBMouYDjVyTo3ARV_itT69_xtFj+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-12-01 2:01 GMT+09:00 Miquel Raynal <miquel.raynal@free-electrons.com>:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
>
> The core currently send the READ0 and SEQIN+PAGEPROG commands in
> nand_do_read/write_ops(). This is inconsistent with
> ->read/write_oob[_raw]() hooks behavior which are expected to send
> these commands.
>
> There's already a flag (NAND_ECC_CUSTOM_PAGE_ACCESS) to inform the core
> that a specific controller wants to send the READ/SEQIN+PAGEPROG
> commands on its own, but it's an opt-in flag, and existing drivers are
> unlikely to be updated to pass it.
>
> Moreover, some controllers cannot dissociate the READ/PAGEPROG commands
> from the associated data transfer and ECC engine activation, and
> developers have to hack things in their ->cmdfunc() implementation to
> handle such complex cases, or have to accept the perf penalty of sending
> twice the same command.
> To address this problem we are planning on adding a new interface which
> is passed all information about a NAND operation (including the amount
> of data to transfer) and replacing all calls to ->cmdfunc() to calls to
> this new ->exec_op() hook. But, in order to do that, we need to have all
> ->cmdfunc() calls placed near their associated ->read/write_buf/byte()
> calls.
>
> Modify the core and relevant drivers to make NAND_ECC_CUSTOM_PAGE_ACCESS
> the default case, and remove this flag.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> [miquel.raynal at free-electrons.com: tested, fixed and rebased on nand/next]
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> ---
>  drivers/mtd/nand/atmel/nand-controller.c      |  7 ++-
>  drivers/mtd/nand/bf5xx_nand.c                 |  6 +-
>  drivers/mtd/nand/brcmnand/brcmnand.c          | 13 +++-
>  drivers/mtd/nand/cafe_nand.c                  |  6 +-
>  drivers/mtd/nand/denali.c                     |  1 -

For denali.c

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


-- 
Best Regards
Masahiro Yamada
