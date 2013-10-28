From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 28 Oct 2013 16:58:41 +0800
Subject: [alsa-devel] [PATCH v2 2/6] ASoC: sirf: add I2S CPU DAI driver
In-Reply-To: <526E24EE.70402@metafoo.de>
References: <1382913424-28626-1-git-send-email-Baohua.Song@csr.com>
 <526E08D1.4040009@metafoo.de>
 <CAGsJ_4xHHD9XqLMdepUgRL7_X5Xg3_AQ2K83pbCxiFhV8cX4zg@mail.gmail.com>
 <526E24EE.70402@metafoo.de>
Message-ID: <CAGsJ_4wzFeDB=9GX4ZcV=cZ5Oo4GDPtVu_bQ2os8OY-UwqDxxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/10/28 Lars-Peter Clausen <lars@metafoo.de>:
> On 10/28/2013 09:32 AM, Barry Song wrote:
>> 2013/10/28 Lars-Peter Clausen <lars@metafoo.de>:
>>> On 10/27/2013 11:37 PM, Barry Song wrote:
>>>> +struct snd_soc_dai_ops sirfsoc_i2s_dai_ops = {
>>>
>>> static const
>>>
>>> Building your driver with sparse (`make C=2 ...`) will tell you these things.
>>>
>>>> +     .startup        = sirf_i2s_startup,
>>>> +     .shutdown       = sirf_i2s_shutdown,
>>>> +     .trigger        = sirf_i2s_trigger,
>>>> +     .hw_params      = sirf_i2s_hw_params,
>>>> +     .set_fmt        = sirf_i2s_set_dai_fmt,
>>>> +     .set_clkdiv     = sirf_i2s_set_clkdiv,
>>>> +};
>>>> +
>>> [...]
>>>> +
>>>> +static int sirf_i2s_probe(struct platform_device *pdev)
>>>> +{
>>>> +     struct sirf_i2s *si2s;
>>>> +     u32 rx_dma_ch, tx_dma_ch;
>>>> +     int ret;
>>>> +     struct resource mem_res;
>>>> +
>>>> +     si2s = devm_kzalloc(&pdev->dev, sizeof(struct sirf_i2s),
>>>> +                     GFP_KERNEL);
>>>> +     if (!si2s)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     si2s->sirf_pcm_pdev = platform_device_register_simple("sirf-pcm-audio",
>>>> +                     0, NULL, 0);
>>>> +     if (IS_ERR(si2s->sirf_pcm_pdev))
>>>> +             return PTR_ERR(si2s->sirf_pcm_pdev);
>>>> +
>>>> +     platform_set_drvdata(pdev, si2s);
>>>> +
>>>> +     spin_lock_init(&si2s->lock);
>>>> +
>>>> +     ret = of_property_read_u32(pdev->dev.of_node,
>>>> +                     "sirf,i2s-dma-rx-channel", &rx_dma_ch);
>>>> +     if (ret < 0) {
>>>> +             dev_err(&pdev->dev, "Unable to USP0 rx dma channel\n");
>>>> +             return ret;
>>>> +     }
>>>> +     ret = of_property_read_u32(pdev->dev.of_node,
>>>> +                     "sirf,i2s-dma-tx-channel", &tx_dma_ch);
>>>> +     if (ret < 0) {
>>>> +             dev_err(&pdev->dev, "Unable to USP0 tx dma channel\n");
>>>> +             return ret;
>>>> +     }
>>>> +
>>>> +     dma_data[0].filter_data = (void *)tx_dma_ch;
>>>> +     dma_data[1].filter_data = (void *)rx_dma_ch;
>>>
>>> This should be using the standard DMA OF bindings. This combind with the
>>> recent changes to the generic dmaengine PCM driver, which added support for
>>> querying certain parameters (like max period length) from the dmaengine
>>> driver, will allow you to completely remove your custom PCM code. You'd
>>> basically just need to call "snd_dmaengine_pcm_register(&pdev->dev, NULL)"
>>> here in the I2S driver.
>>>
>>> This will require some changes to your dmaengine driver though. You need to
>>> implement the of_xlate callback for the generic DMA bindings and the
>>> device_slave_caps API for being able to query the capabilities from the driver.
>>
>> i am really happy to have that as for clock, gpio, pinctrl, all of
>> them we have the binding.
>> here the problem is we can't implement this in this driver as there
>> are still many drivers depending on the sirf-dma changes.
>>
>> so our point is keeping the things as is here. and we have another
>> patchset of dt binding for sirf-dma and all drivers depending sirf-dma
>> driver.
>
> I don't think this is a good idea. Adding of_xlate support to the DMA driver
> is a 10 line patch at most. And there is no compile time dependency between
> the DMA driver changes and using the generic DMA bindings in this driver, so
> this driver does not have to wait for the changes to the DMA driver to be
> merged first.

if we don't wait dma driver and other drivers using sirf-dma to be
merged before merging sound, it is ok to me to have of_xlate support
at first.

>
> I'm fine with having the device_slave_caps stuff added in a later patch, but
> adding custom DMA bindings at this point is in my opinion a no-go.
> Especially if you consider that DT bindings are considered ABI by some people.
>
> Btw. the DT bindings documentation for this driver seems to be missing.

fine. take it into v3 then.

>
> - Lars
>

-barry
