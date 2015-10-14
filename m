From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 14 Oct 2015 14:29:16 +0100
Subject: [PATCH v2 2/4] dmaengine: Add STM32 DMA driver
In-Reply-To: <CAOAejn2pcFSn3Hf=j6zgg6Ui6GjJZrtRch6ywByHaVLsTLMk6A@mail.gmail.com>
References: <1444745127-1105-1-git-send-email-cedric.madianga@gmail.com>
 <1444745127-1105-3-git-send-email-cedric.madianga@gmail.com>
 <561D1689.90703@linaro.org>
 <CAOAejn1N=dFZ3nQ_hNznJQX1-fkP3r=vdYuWY4OMH65PrW3xVg@mail.gmail.com>
 <CAOAejn2pcFSn3Hf=j6zgg6Ui6GjJZrtRch6ywByHaVLsTLMk6A@mail.gmail.com>
Message-ID: <561E58AC.80207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/15 14:17, M'boumba Cedric Madianga wrote:
> Hi Daniel,
>
>>>> +
>>>> +static int stm32_dma_remove(struct platform_device *pdev)
>>>> +{
>>>> +       struct stm32_dma_device *dmadev = platform_get_drvdata(pdev);
>>>> +
>>>> +       of_dma_controller_free(pdev->dev.of_node);
>>>> +
>>>> +       dma_async_device_unregister(&dmadev->ddev);
>>>> +
>>>> +       clk_disable_unprepare(dmadev->clk);
>>>
>>>
>>> What is the purpose of disabling/unpreparing the clock here?
>>> stm32_dma_alloc_chan_resources() and stm32_dma_free_chan_resources() should
>>> pair up and the clock should already be stopped.
>
> stm32_dma_remove() could be called during an on-going transfer during
> module unload.
> So in that case, it seems that disabling/unpreparing the clock is needed.

Really?

I think we need to be sure any on-going transfers are stopped.

There are multiple reasons for this, not least the risk of executing a 
callback that has been freed, but the one related to my point is that a 
single clk_disable_unprepare() will remain broken because if you don't 
know that the transfers have stopped then you don't know how many 
on-going transfers there are.


Daniel.
