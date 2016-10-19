From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 19 Oct 2016 18:56:22 +0530
Subject: [PATCH] dmaengine: qcom_hidma: cleanup sysfs entries during remove
In-Reply-To: <1475796189-26553-1-git-send-email-okaya@codeaurora.org>
References: <1475796189-26553-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20161019132622.GN2467@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06, 2016 at 07:23:09PM -0400, Sinan Kaya wrote:
> The 4.8-rc8 kernel is printing duplicate file entry warnings while removing
> the HIDMA object. This is caused by stale sysfs entries remaining from the
> previous execution.
> 
> _sysfs_warn_dup+0x5c/0x78
>  sysfs_add_file_mode_ns+0x13c/0x1c0
>  sysfs_create_file_ns+0x2c/0x40
>  device_create_file+0x54/0xa0
>  hidma_probe+0x7c8/0x808
> 
> Create hidma_sysfs_init and hidma_sysfs_uninit functions and call them from
> the probe and remove path. To do proper clean up, adding the attrs object
> to the device data structure to keep it around until remove call is made.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/dma/qcom/hidma.c | 31 +++++++++++++++++++++++++------
>  drivers/dma/qcom/hidma.h |  3 +++
>  2 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
> index f4fe4ee..414ea12 100644
> --- a/drivers/dma/qcom/hidma.c
> +++ b/drivers/dma/qcom/hidma.c
> @@ -578,8 +578,17 @@ static ssize_t hidma_show_values(struct device *dev,
>  	return strlen(buf);
>  }
>  
> -static int hidma_create_sysfs_entry(struct hidma_dev *dev, char *name,
> -				    int mode)
> +static int hidma_sysfs_uninit(struct hidma_dev *dev)
> +{
> +	if (!dev->chid_attrs)
> +		return -ENOMEM;

why is this check required? Probe would fail in init case right.
Second returning error doesnt help as you are calling this from remove and
return is not checked so redundant!

-- 
~Vinod
