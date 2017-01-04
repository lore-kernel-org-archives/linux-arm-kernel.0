From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 4 Jan 2017 16:49:41 +0000
Subject: [PATCH v6 11/14] msi: platform: make
 platform_msi_create_device_domain() ACPI aware
In-Reply-To: <1483363905-2806-12-git-send-email-hanjun.guo@linaro.org>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-12-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20170104164941.GB8604@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2017 at 09:31:42PM +0800, Hanjun Guo wrote:
> With the platform msi domain created for ITS, irqchip such as
> mbi-gen connecting ITS, which needs ctreate its own irqdomain.

This patch touches generic platform-msi code, there is nothing ITS
and mbi-gen specific that has to be known here.

> Fortunately with the platform msi support upstreamed by Marc,
> we just need to add minor code to make it run properly.

Do you really think that anyone reading this log can easily
make use of this statement ?

> platform_msi_create_device_domain() is almost ready for ACPI use
> except of_node_to_fwnode() is for dt only, make it ACPI aware then
> things will work in both DTS and ACPI.

This commit log is unreadable and the readable bits do not contain
information that can be used for the purpose a commit log is made
for.

Please rewrite it in a way that can be used in the future to understand
what this patch does and why you want it in the kernel, thanks.

Lorenzo

> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Majun <majun258@huawei.com>
> Tested-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/base/platform-msi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
> index be6a599..035ca3b 100644
> --- a/drivers/base/platform-msi.c
> +++ b/drivers/base/platform-msi.c
> @@ -345,8 +345,7 @@ struct irq_domain *
>  
>  	data->host_data = host_data;
>  	domain = irq_domain_create_hierarchy(dev->msi_domain, 0, nvec,
> -					     of_node_to_fwnode(dev->of_node),
> -					     ops, data);
> +					     dev->fwnode, ops, data);
>  	if (!domain)
>  		goto free_priv;
>  
> -- 
> 1.9.1
> 
