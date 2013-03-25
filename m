From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Mar 2013 15:40:50 +0000
Subject: [PATCH 2/3] mfd: db8500-prcmu: Fetch the PRCMU TCDM base address
 from Device Tree
In-Reply-To: <1364223758-17621-2-git-send-email-lee.jones@linaro.org>
References: <1364223758-17621-1-git-send-email-lee.jones@linaro.org>
 <1364223758-17621-2-git-send-email-lee.jones@linaro.org>
Message-ID: <201303251540.51104.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 March 2013, Lee Jones wrote:
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>                                            "prcmu-tcpm");
>         if (!res) {
> -               dev_err(&pdev->dev,
> -                       "Error: no prcmu tcpm memory region provided\n");
> -               return;
> -       }
> -       tcpm_base = ioremap(res->start, resource_size(res));
> +               if (np) {
> +                       tcpm_np = of_find_node_by_name(np->parent,
> +                                                      "prcmu-tcpm-per4");
> +                       if (!tcpm_np) {
> +                               dev_err(&pdev->dev,
> +                                       "no prcmu tcpm mem region provided\n");
> +                               return;
> +                       }
> +                       tcpm_base = of_iomap(tcpm_np, 0);
> +               }
> +       } else
> +               tcpm_base = ioremap(res->start, resource_size(res));
> +

Why don't you just add these extra registers to the prcmu node itself like

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 9de9309..6ee6c31 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -191,8 +191,8 @@
 
 		prcmu: prcmu at 80157000 {
 			compatible = "stericsson,db8500-prcmu";
-			reg = <0x80157000 0x1000>;
-			reg-names = "prcmu";
+			reg = <0x80157000 0x1000>, <0x801b0000 0x1000>, <0x801b8000 0x1000>;
+			reg-names = "prcmu", "prcmu-tcpm", "prcmu-tcdm-per4";
 			interrupts = <0 47 0x4>;
 			#address-cells = <1>;
 			#size-cells = <1>;


and document those in the prcmu binding?

That would keep the code simpler and the same for both cases.

	Arnd
