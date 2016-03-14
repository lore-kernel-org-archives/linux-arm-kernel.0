From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 14 Mar 2016 09:44:35 +0100
Subject: [PATCH v6 net-next 01/10] misc: sram: add optional ioremap
 without write combining
In-Reply-To: <1457944745-7634-2-git-send-email-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Mon, 14 Mar 2016 09:38:56 +0100")
References: <1457944745-7634-1-git-send-email-gregory.clement@free-electrons.com>
 <1457944745-7634-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <87fuvt1ma4.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

I forgot to add you in CC for this patch.
What is your opinion about it?

Gregory
 
 On lun., mars 14 2016, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> From: Marcin Wojtas <mw@semihalf.com>
>
> Some SRAM users may require non-bufferable access to the memory, which is
> impossible, because devm_ioremap_wc() is used for setting sram->virt_base.
>
> This commit adds optional flag 'no-memory-wc', which allow to choose remap
> method, using DT property. Documentation is updated accordingly.
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---
>  Documentation/devicetree/bindings/sram/sram.txt | 5 +++++
>  drivers/misc/sram.c                             | 5 ++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/sram/sram.txt b/Documentation/devicetree/bindings/sram/sram.txt
> index 42ee9438b771..227e3a341af1 100644
> --- a/Documentation/devicetree/bindings/sram/sram.txt
> +++ b/Documentation/devicetree/bindings/sram/sram.txt
> @@ -25,6 +25,11 @@ Required properties in the sram node:
>  - ranges : standard definition, should translate from local addresses
>             within the sram to bus addresses
>  
> +Optional properties in the sram node:
> +
> +- no-memory-wc : the flag indicating, that SRAM memory region has not to
> +                 be remapped as write combining. WC is used by default.
> +
>  Required properties in the area nodes:
>  
>  - reg : iomem address range, relative to the SRAM range
> diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
> index 736dae715dbf..69cdabea9c03 100644
> --- a/drivers/misc/sram.c
> +++ b/drivers/misc/sram.c
> @@ -360,7 +360,10 @@ static int sram_probe(struct platform_device *pdev)
>  		return -EBUSY;
>  	}
>  
> -	sram->virt_base = devm_ioremap_wc(sram->dev, res->start, size);
> +	if (of_property_read_bool(pdev->dev.of_node, "no-memory-wc"))
> +		sram->virt_base = devm_ioremap(sram->dev, res->start, size);
> +	else
> +		sram->virt_base = devm_ioremap_wc(sram->dev, res->start, size);
>  	if (IS_ERR(sram->virt_base))
>  		return PTR_ERR(sram->virt_base);
>  
> -- 
> 2.5.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
