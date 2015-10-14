From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 14 Oct 2015 09:52:58 +0100
Subject: [PATCH v2 2/4] dmaengine: Add STM32 DMA driver
In-Reply-To: <CAOAejn1N=dFZ3nQ_hNznJQX1-fkP3r=vdYuWY4OMH65PrW3xVg@mail.gmail.com>
References: <1444745127-1105-1-git-send-email-cedric.madianga@gmail.com>
 <1444745127-1105-3-git-send-email-cedric.madianga@gmail.com>
 <561D1689.90703@linaro.org>
 <CAOAejn1N=dFZ3nQ_hNznJQX1-fkP3r=vdYuWY4OMH65PrW3xVg@mail.gmail.com>
Message-ID: <561E17EA.6000900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/15 08:54, M'boumba Cedric Madianga wrote:
>>> +static int stm32_dma_alloc_chan_resources(struct dma_chan *c)
>>> +{
>>> +       struct stm32_dma_chan *chan = to_stm32_dma_chan(c);
>>> +       struct stm32_dma_device *dmadev = stm32_dma_chan_get_dev(chan);
>>> +       int ret;
>>> +
>>> +       chan->config_init = false;
>>> +       ret = clk_prepare_enable(dmadev->clk);
>>> +       if (ret < 0) {
>>> +               dev_err(chan2dev(chan), "clk_prepare_enable failed: %d\n",
>>> ret);
>>> +               return ret;
>>> +       }
>>> +
>>> +       ret = stm32_dma_disable_chan(chan);
>>> +
>>> +       return ret;
>>> +}
>>
>>
>> The error path here looks like it will leak clock references.
>
> Sorry I didn't catch it. What does it mean ?

If stm32_dma_disable_chan() returns an error then we will not restore 
the original the clock counts causing them to "leak".


Daniel.
