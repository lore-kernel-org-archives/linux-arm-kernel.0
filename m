From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 3 Oct 2016 09:08:52 +0530
Subject: [PATCH V4 04/10] dmaengine: qcom_hidma: configure DMA and MSI
 for OF
In-Reply-To: <da6536a3-353e-1364-7074-9d3dcbcc4171@codeaurora.org>
References: <1475115167-5898-1-git-send-email-okaya@codeaurora.org>
 <1475115167-5898-5-git-send-email-okaya@codeaurora.org>
 <20161001061710.GF2467@localhost>
 <da6536a3-353e-1364-7074-9d3dcbcc4171@codeaurora.org>
Message-ID: <20161003033851.GP2467@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 01, 2016 at 11:15:00AM -0400, Sinan Kaya wrote:
> On 10/1/2016 2:17 AM, Vinod Koul wrote:
> > On Wed, Sep 28, 2016 at 10:12:41PM -0400, Sinan Kaya wrote:
> >> Configure the DMA bindings for the device tree based firmware.
> >>
> >> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> >> ---
> >>  drivers/dma/qcom/hidma_mgmt.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
> >> index 82f36e4..e8f6b84 100644
> >> --- a/drivers/dma/qcom/hidma_mgmt.c
> >> +++ b/drivers/dma/qcom/hidma_mgmt.c
> >> @@ -375,8 +375,11 @@ static int __init hidma_mgmt_of_populate_channels(struct device_node *np)
> >>  			ret = PTR_ERR(new_pdev);
> >>  			goto out;
> >>  		}
> >> +		of_node_get(child);
> >> +		new_pdev->dev.of_node = child;
> >>  		of_dma_configure(&new_pdev->dev, child);
> >> -
> >> +		of_msi_configure(&new_pdev->dev, child);
> >> +		of_node_put(child);
> > 
> > should this be done unconditionally? Dont we needto call this only for
> > platforms with msi?
> 
> I followed the pattern in of_platform_device_create_pdata function. of_msi_configure does
> nothing if MSI is not enabled as irq_find_matching_host returns NULL. It didn't have any
> side effects on my testing either.

yeah later on I did look up the of_msi_configure() and I suspected this. I
think it would be worthwhile to document this assumption here.

Thanks
-- 
~Vinod
