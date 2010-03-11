From: svenkatr@ti.com (Venkatraman S)
Date: Thu, 11 Mar 2010 20:38:02 +0530
Subject: [PATCH 03/03] omap hsmmc: adaptation of sdma descriptor
	autoloading feature
In-Reply-To: <20100310224110.GW2900@atomide.com>
References: <618f0c911003100612l33b1fec9s163720a5a93a1787@mail.gmail.com>
	<20100310224110.GW2900@atomide.com>
Message-ID: <618f0c911003110708s5015f2bftb443b9ea57cb6477@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren wrote:
> * Venkatraman S <svenkatr@ti.com> [100310 06:08]:
>> @@ -1400,14 +1471,23 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host
>> *host, struct mmc_request *req)
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? | (req->data->blocks << 16));
>> ? ? ? set_data_timeout(host, req->data->timeout_ns, req->data->timeout_clks);
>>
>> - ? ? if (host->use_dma) {
>> - ? ? ? ? ? ? ret = omap_hsmmc_start_dma_transfer(host, req);
>> - ? ? ? ? ? ? if (ret != 0) {
>> - ? ? ? ? ? ? ? ? ? ? dev_dbg(mmc_dev(host->mmc), "MMC start dma failure\n");
>> + ? ? if (host->dma_caps & DMA_TYPE_SDMA) {
>> + ? ? ? ? ? ? ret = omap_hsmmc_configure_sdma(host, req);
>> + ? ? ? ? ? ? if (ret)
>> ? ? ? ? ? ? ? ? ? ? ? return ret;
>> - ? ? ? ? ? ? }
>> + ? ? ? ? ? ? host->dma_in_use = DMA_TYPE_SDMA;
>> ? ? ? }
>> - ? ? return 0;
>> + ? ? if ((host->dma_caps & DMA_TYPE_SDMA_DLOAD) &&
>> + ? ? ? ? ? ? host->data->sg_len > 4) {
>> + ? ? ? ? ? ? ret = omap_hsmmc_configure_sdma_sglist(host, req);
>> + ? ? ? ? ? ? if (ret)
>> + ? ? ? ? ? ? ? ? ? ? return ret;
>> + ? ? ? ? ? ? host->dma_in_use = DMA_TYPE_SDMA_DLOAD;
>> +
>> + ? ? }
>> + ? ? ret = omap_hsmmc_start_dma_transfer(host);
>> + ? ? return ret;
>> +
>> ?}
>
> Does the driver still work in PIO mode?
>
> We need to have the drivers capable to fail over to PIO mode
> as the DMA channels can run out.
>

   The driver doesn't have an automatic fallback to PIO,
even without my patch. A error return from omap_request_dma is
propogated all the way back to the transfer request.
  The decision to use_dma (the variable) is unaltered.

   Infact, it would be easier to implement a runtime fallback after
this patch is
merged as I have separated out the capability and runtime selection.
(dma_caps and dma_in_use).

Regards,

Venkat.
