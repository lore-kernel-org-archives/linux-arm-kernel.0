From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sun, 17 Mar 2013 23:37:02 +0100
Subject: [PATCH v3 5/6] irqchip: s3c24xx: add devicetree support
In-Reply-To: <201303171407.59128.heiko@sntech.de>
References: <201303171404.06146.heiko@sntech.de>
 <201303171407.59128.heiko@sntech.de>
Message-ID: <201303172337.02642.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 17. M?rz 2013, 14:07:58 schrieb Heiko St?bner:
> Add the necessary code to initialize the interrupt controller
> thru devicetree data using the irqchip infrastructure.
> 
> On dt machines the eint-type interrupts in the main interrupt controller
> get mapped as regular edge-types, as their wakeup and interrupt type
> properties will be handled by the upcoming pinctrl driver.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../interrupt-controller/samsung,s3c24xx-irq.txt   |   54 +++++
>  drivers/irqchip/irq-s3c24xx.c                      |  222
> ++++++++++++++++++++ 2 files changed, 276 insertions(+), 0 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq
> .txt
> 
> diff --git
> a/Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-i
> rq.txt
> b/Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-i
> rq.txt new file mode 100644
> index 0000000..be5dead
> --- /dev/null
> +++
> b/Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-i
> rq.txt @@ -0,0 +1,54 @@
> +Samsung S3C24XX Interrupt Controllers
> +
> +The S3C24XX SoCs contain a custom set of interrupt controllers providing a
> +varying number of interrupt sources. The set consists of a main- and sub-
> +controller and on newer SoCs even a second main controller.
> +
> +Required properties:
> +- compatible: Compatible property value should be one of
> "samsung,s3c2410-irq", +  "samsung,s3c2412-irq", "samsung,s3c2416-irq",
> "samsung,s3c2440-irq", +  "samsung,s3c2442-irq", "samsung,s3c2443-irq"
> depending on the SoC variant. +
> +- reg: Physical base address of the controller and length of memory mapped
> +  region.
> +
> +- interrupt-controller : Identifies the node as an interrupt controller
> +
> +Sub-controllers as child nodes:
> +  The interrupt controllers that should be referenced by device nodes are
> +  represented by child nodes. Valid names are intc, subintc and intc2.
> +  The interrupt values in device nodes are then mapped directly to the
> +  bit-numbers of the pending register of the named interrupt controller.
> +
> +Required properties:
> +- interrupt-controller : Identifies the node as an interrupt controller
> +
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value shall be 2.

just noticed, that with the eint handling moving to the pinctrl driver, there 
are no interrupt trigger settings to be made here anymore, so this can 
probably move to xlate_onecell and #interrupt-cells to <1>.
