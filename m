From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Wed, 14 Oct 2015 15:17:14 +0200
Subject: [PATCH v2 2/4] dmaengine: Add STM32 DMA driver
In-Reply-To: <CAOAejn1N=dFZ3nQ_hNznJQX1-fkP3r=vdYuWY4OMH65PrW3xVg@mail.gmail.com>
References: <1444745127-1105-1-git-send-email-cedric.madianga@gmail.com>
 <1444745127-1105-3-git-send-email-cedric.madianga@gmail.com>
 <561D1689.90703@linaro.org>
 <CAOAejn1N=dFZ3nQ_hNznJQX1-fkP3r=vdYuWY4OMH65PrW3xVg@mail.gmail.com>
Message-ID: <CAOAejn2pcFSn3Hf=j6zgg6Ui6GjJZrtRch6ywByHaVLsTLMk6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

>>> +
>>> +static int stm32_dma_remove(struct platform_device *pdev)
>>> +{
>>> +       struct stm32_dma_device *dmadev = platform_get_drvdata(pdev);
>>> +
>>> +       of_dma_controller_free(pdev->dev.of_node);
>>> +
>>> +       dma_async_device_unregister(&dmadev->ddev);
>>> +
>>> +       clk_disable_unprepare(dmadev->clk);
>>
>>
>> What is the purpose of disabling/unpreparing the clock here?
>> stm32_dma_alloc_chan_resources() and stm32_dma_free_chan_resources() should
>> pair up and the clock should already be stopped.

stm32_dma_remove() could be called during an on-going transfer during
module unload.
So in that case, it seems that disabling/unpreparing the clock is needed.

BR,
Cedric
