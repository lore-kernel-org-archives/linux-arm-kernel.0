From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 04 Dec 2013 10:27:02 -0700
Subject: [PATCH V3] dma: tegra: register as an OF DMA controller
In-Reply-To: <201312040234.09708.arnd@arndb.de>
References: <1386102787-21839-1-git-send-email-swarren@wwwdotorg.org>
 <201312040234.09708.arnd@arndb.de>
Message-ID: <529F65E6.9050606@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2013 06:34 PM, Arnd Bergmann wrote:
> On Tuesday 03 December 2013, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Call of_dma_controller_register() so that DMA clients can look up the
>> Tegra DMA controller using standard APIs. This requires the of_xlate()
>> function to save off the DMA slave ID, and for tegra_dma_slave_config()
>> not to over-write this information; once DMA client drivers are converted
>> to dma_request_slave_channel() and DT-based lookups, they won't set this
>> field of struct dma_slave_config anymore.
...
> Also, one (long-running, not just for this driver) comment I have is
> about this snippet:
> 
>> @@ -340,6 +342,8 @@ static int tegra_dma_slave_config(struct dma_chan *dc,
>>         }
>>  
>>         memcpy(&tdc->dma_sconfig, sconfig, sizeof(*sconfig));
>> +       if (!tdc->slave_id)
>> +               tdc->slave_id = sconfig->slave_id;
>>         tdc->config_init = true;
>>         return 0;
>>  }
> 
> We really need to be better at having a common set of rules regarding what
> it actually means to set the slave_id through dma_slave_config(). IMHO
> we should just treat it as a bug for any dmaengine driver that is configured
> through DT, or we should get rid of this entirely.

By the end of this series (for the Tegra driver) I can remove those "+"
lines you quoted above; the slave ID will only come from DT through
of_xlate, and any slave ID in the slave_config will simply be ignored.
