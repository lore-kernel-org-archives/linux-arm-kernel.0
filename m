From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 16 Mar 2017 10:05:39 +0100
Subject: [PATCH] mtd: nand: orion: fix clk handling
In-Reply-To: <20170312213406.20987-1-gmbnomis@gmail.com>
References: <20170312213406.20987-1-gmbnomis@gmail.com>
Message-ID: <20170316100539.15bb1828@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Sun, 12 Mar 2017 22:34:06 +0100
Simon Baatz <gmbnomis@gmail.com> wrote:

> The clk handling in orion_nand.c had two problems:
> 
> - In the probe function, clk_put() was called for an enabled clock,
>   which violates the API (see documentation for clk_put() in
>   include/linux/clk.h)
> 
> - In the error path of the probe function, clk_put() could be called
>   twice for the same clock.
> 
> In order to clean this up, use the managed function devm_clk_get() and
> store the pointer to the clk in the driver data.
> 
> Fixes: baffab28b13120694fa3ebab08d3e99667a851d2 ('ARM: Orion: fix driver probe error handling with respect to clk')
> Cc: <stable@vger.kernel.org> # v4.5+
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---
>  drivers/mtd/nand/orion_nand.c | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
> index 4a91c5d000be..b355aa738fae 100644
> --- a/drivers/mtd/nand/orion_nand.c
> +++ b/drivers/mtd/nand/orion_nand.c
> @@ -23,6 +23,11 @@
>  #include <asm/sizes.h>
>  #include <linux/platform_data/mtd-orion_nand.h>
>  
> +struct orion_nand_info {
> +	struct nand_chip chip;
> +	struct clk       *clk;

Can we avoid this kind of alignment, which will not be preserved if
someone adds a new field with a type that is longer than "struct
nand_chip "?

Regards,

Boris
