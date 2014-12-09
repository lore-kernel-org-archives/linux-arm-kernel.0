From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 9 Dec 2014 15:38:09 -0700
Subject: [PATCH] PCI: keystone: fix error handling of irq_of_parse_and_map
In-Reply-To: <20141114221903.GA38539@dtor-ws>
References: <20141114221903.GA38539@dtor-ws>
Message-ID: <20141209223809.GB6692@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 02:19:03PM -0800, Dmitry Torokhov wrote:
> Return value of irq_of_parse_and_map() is unsigned int, with 0
> indicating failure, so testing for negative result never works.
> 
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>

Applied with Murali's ack to next-pci/host-keystone for v3.19.  This
branch will be rebased to v3.19-rc1.

> ---
> 
> Not tested, found by casual code inspection.
> 
>  drivers/pci/host/pci-keystone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
> index 8a27078..f2bd48d 100644
> --- a/drivers/pci/host/pci-keystone.c
> +++ b/drivers/pci/host/pci-keystone.c
> @@ -197,7 +197,7 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
>  	 */
>  	for (temp = 0; temp < max_host_irqs; temp++) {
>  		host_irqs[temp] = irq_of_parse_and_map(*np_temp, temp);
> -		if (host_irqs[temp] < 0)
> +		if (!host_irqs[temp])
>  			break;
>  	}
>  	if (temp) {
> -- 
> 2.1.0.rc2.206.gedb03e5
> 
> 
> -- 
> Dmitry
