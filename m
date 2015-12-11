From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 11 Dec 2015 11:38:20 +0900
Subject: [PATCH v4 38/58] mtd: nand: s3c2410: use the mtd instance embedded
 in struct nand_chip
In-Reply-To: <1449734442-18672-39-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
 <1449734442-18672-39-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <566A371C.7030507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.12.2015 17:00, Boris Brezillon wrote:
> struct nand_chip now embeds an mtd device. Make use of this mtd instance.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> Changes generated with the following coccinelle script
> 
> --->8---
> virtual patch
> 
> @fix1@
> identifier __chipfield, __mtdfield;
> type __type;
> @@
> (
> 	__type {
> 		...
> 		struct nand_chip __chipfield;
> 		...
> -		struct mtd_info __mtdfield;
> 		...
> 	};
> |
> 	__type {
> 		...
> -		struct mtd_info __mtdfield;
> 		...
> 		struct nand_chip __chipfield;
> 		...
> 	};
> )
> 
> @fix2 depends on fix1@
> identifier fix1.__chipfield, fix1.__mtdfield;
> identifier __subfield;
> type fix1.__type;
> __type *__priv;
> @@
> (
> -	__priv->__mtdfield.__subfield
> +	nand_to_mtd(&__priv->__chipfield)->__subfield
> |
> -	&(__priv->__mtdfield)
> +	nand_to_mtd(&__priv->__chipfield)
> )
> --->8---
> ---
>  drivers/mtd/nand/s3c2410.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 

Looks correct:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
