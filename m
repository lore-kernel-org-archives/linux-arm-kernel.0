From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 30 Jul 2015 09:50:51 +0200
Subject: [RFC PATCH 2/2] dt: spi: s3c64xx: add compatible to
 controller-data
In-Reply-To: <557c1962448393b2a8736f26bfa2a3a5ba4aeb7a.1438170519.git.hramrach@gmail.com>
References: <cover.1438170519.git.hramrach@gmail.com>
 <557c1962448393b2a8736f26bfa2a3a5ba4aeb7a.1438170519.git.hramrach@gmail.com>
Message-ID: <20150730095051.06eff8b1@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On Wed, 29 Jul 2015 12:19:57 +0200
Michal Suchanek <hramrach@gmail.com> wrote:

> The controller-data subnode has no compatible. This can lead to other
> drivers getting confused by it. Add a compatible to make devicetreee
> unambiguous.
> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-samsung.txt | 3 +++
>  drivers/spi/spi-s3c64xx.c                             | 4 ++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
> index 6dbdeb3..b1e98d1 100644
> --- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
> @@ -92,16 +92,19 @@ Example:
>  			spi-max-frequency = <10000>;
>  
>  			controller-data {
> +				compatible = "samsung,s3c-controller-data";

AFAIK compatible should (as much as possible :-)) only be used to encode
HW type, and here you're using it to expose what you want to do with
your data in Linux.

>  				samsung,spi-feedback-delay = <0>;
>  			};
>  
>  			partition at 0 {
> +				compatible = "linux,ofpart-partition";

Ditto.

Since you have to patch your DTs anyway, how about putting your
partitions in a subnode and patch the ofpart code to parse this subnode
if it is present (see the following patch).

Best Regards,

Boris

--- >8 ---

>From e342860932bda3a6354a0a6e17540db5c85a14e0 Mon Sep 17 00:00:00 2001
From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Thu, 30 Jul 2015 09:44:07 +0200
Subject: [PATCH] mtd: ofpart: search for a partitions node

The DT partition parser currently assumes the parition definitions are
directly stored in the MTD device node, but sometime this device node
contains other child nodes used to store device specific information.

Search for a partitions subnode containing the partition definitions,
if it is not there, parse the definitions in the device node.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/ofpart.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ofpart.c b/drivers/mtd/ofpart.c
index 8a06cfb..ba52b88 100644
--- a/drivers/mtd/ofpart.c
+++ b/drivers/mtd/ofpart.c
@@ -38,7 +38,10 @@ static int parse_ofpart_partitions(struct mtd_info *master,
 	if (!data)
 		return 0;
 
-	node = data->of_node;
+	node = of_get_child_by_name(data->of_node, "partitions");
+	if (!node)
+		node = data->of_node;
+
 	if (!node)
 		return 0;
 
-- 
1.9.1
