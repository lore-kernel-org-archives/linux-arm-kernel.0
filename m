From: ray.jui@broadcom.com (Ray Jui)
Date: Tue, 22 Nov 2016 09:45:24 -0800
Subject: [PATCH 2/2] PCI: iproc: avoid maybe-uninitialized warning
In-Reply-To: <20161122141844.1655574-2-arnd@arndb.de>
References: <20161122141844.1655574-1-arnd@arndb.de>
 <20161122141844.1655574-2-arnd@arndb.de>
Message-ID: <31c4c52b-3de5-2277-7a44-2a4231531074@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 11/22/2016 6:17 AM, Arnd Bergmann wrote:
> gcc notices that calling iproc_pcie_setup_ib with ib->nr_regions==0
> would result in an uninitialized return value:
> 
> drivers/pci/host/pcie-iproc.c: In function 'iproc_pcie_setup_ib':
> drivers/pci/host/pcie-iproc.c:894:6: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This can't really happen, but the correct behavior of the function
> is probably to return -EINVAL if it ever did.
> 
> Fixes: 4213e15c364e ("PCI: iproc: Make outbound mapping code more generic")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pci/host/pcie-iproc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index 857ff5198317..0359569c8d78 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -936,6 +936,7 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
>  
>  		}
>  	}
> +	ret = -EINVAL;
>  err_ib:
>  	dev_err(dev, "unable to configure inbound mapping\n");
>  	dev_err(dev, "axi %pap, pci %pap, res size %pap\n",
> 

This change is good, but in my opinion, a further improvement for
clarity would be to initialize 'ret' to -EINVAL in the beginning of this
function when 'ret' is declared. What do you think?

Thanks,

Ray
