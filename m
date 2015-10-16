From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Fri, 16 Oct 2015 13:46:46 +0800
Subject: [PATCH RFC 2/7] platform-msi: Factor out allocation/free of
 private data
In-Reply-To: <1444923568-17413-3-git-send-email-marc.zyngier@arm.com>
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
 <1444923568-17413-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <56208F46.7090402@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/10/15 23:39, Marc Zyngier wrote:
> As we're going to have multiple paths to allocate/free the
> platform-msi private data, factor this out into separate
> utility functions.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/base/platform-msi.c | 84 ++++++++++++++++++++++++++-------------------
>  1 file changed, 48 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
> index 6148c78..92666cd 100644
> --- a/drivers/base/platform-msi.c
> +++ b/drivers/base/platform-msi.c
> @@ -189,21 +189,11 @@ struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
>  	return domain;
>  }
>  
> -/**
> - * platform_msi_domain_alloc_irqs - Allocate MSI interrupts for @dev
> - * @dev:		The device for which to allocate interrupts
> - * @nvec:		The number of interrupts to allocate
> - * @write_msi_msg:	Callback to write an interrupt message for @dev
> - *
> - * Returns:
> - * Zero for success, or an error code in case of failure
> - */
> -int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
> -				   irq_write_msi_msg_t write_msi_msg)
> +static int platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
> +					irq_write_msi_msg_t write_msi_msg,
> +					struct platform_msi_priv_data **data)
How about making platform_msi_alloc_priv_data() return a pointer
instead of an int, that may simplify the code a bit.
