From: b.brezillon@overkiz.com (boris brezillon)
Date: Wed, 12 Jun 2013 14:08:43 +0200
Subject: [RFC PATCH 27/50] at_hdmac: prepare clk before calling enable
In-Reply-To: <20130612090520.GN4107@intel.com>
References: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
 <1370622358-19575-1-git-send-email-b.brezillon@overkiz.com>
 <20130612090520.GN4107@intel.com>
Message-ID: <51B864CB.8000100@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2013 11:05, Vinod Koul wrote:
> On Fri, Jun 07, 2013 at 06:25:57PM +0200, Boris BREZILLON wrote:
>> Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
>> avoid common clk framework warnings.
>>
>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>> ---
>>   drivers/dma/at_hdmac.c |   12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
>> index e923cda..4772036 100644
>> --- a/drivers/dma/at_hdmac.c
>> +++ b/drivers/dma/at_hdmac.c
>> @@ -1374,7 +1374,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
>>   		err = PTR_ERR(atdma->clk);
>>   		goto err_clk;
>>   	}
>> -	clk_enable(atdma->clk);
>> +	clk_prepare_enable(atdma->clk);
> Can you add checks for return value in the driver as well
Sure. I'll add it in the next version.
>>   
>>   	/* force dma off, just in case */
>>   	at_dma_off(atdma);
>> @@ -1475,7 +1475,7 @@ err_pool_create:
>>   	platform_set_drvdata(pdev, NULL);
>>   	free_irq(platform_get_irq(pdev, 0), atdma);
>>   err_irq:
>> -	clk_disable(atdma->clk);
>> +	clk_disable_unprepare(atdma->clk);
>>   	clk_put(atdma->clk);
>>   err_clk:
>>   	iounmap(atdma->regs);
>> @@ -1512,7 +1512,7 @@ static int at_dma_remove(struct platform_device *pdev)
>>   		list_del(&chan->device_node);
>>   	}
>>   
>> -	clk_disable(atdma->clk);
>> +	clk_disable_unprepare(atdma->clk);
>>   	clk_put(atdma->clk);
>>   
>>   	iounmap(atdma->regs);
>> @@ -1531,7 +1531,7 @@ static void at_dma_shutdown(struct platform_device *pdev)
>>   	struct at_dma	*atdma = platform_get_drvdata(pdev);
>>   
>>   	at_dma_off(platform_get_drvdata(pdev));
>> -	clk_disable(atdma->clk);
>> +	clk_disable_unprepare(atdma->clk);
>>   }
>>   
>>   static int at_dma_prepare(struct device *dev)
>> @@ -1588,7 +1588,7 @@ static int at_dma_suspend_noirq(struct device *dev)
>>   
>>   	/* disable DMA controller */
>>   	at_dma_off(atdma);
>> -	clk_disable(atdma->clk);
>> +	clk_disable_unprepare(atdma->clk);
>>   	return 0;
>>   }
>>   
>> @@ -1618,7 +1618,7 @@ static int at_dma_resume_noirq(struct device *dev)
>>   	struct dma_chan *chan, *_chan;
>>   
>>   	/* bring back DMA controller */
>> -	clk_enable(atdma->clk);
>> +	clk_prepare_enable(atdma->clk);
>>   	dma_writel(atdma, EN, AT_DMA_ENABLE);
>>   
>>   	/* clear any pending interrupt */
> --
> ~Vinod
