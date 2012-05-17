From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Thu, 17 May 2012 09:35:39 +0530
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <4FB43F69.1070608@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FB3D294.4020505@wwwdotorg.org>
 <CAJe_Zhe6uT7u-+0VEx2XCieuynmK5nOO=4DSpDDS_Q=N8-QtPA@mail.gmail.com>
 <201205161942.20296.arnd@arndb.de> <4FB43F69.1070608@wwwdotorg.org>
Message-ID: <CAJe_ZheKUoM+UjagtfmqLha-vwQr4J+CdEjvtR8t0cmdOQJPyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 May 2012 05:29, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>
>>> Generic binding to provide a way to provide the client-channel map and
>>> other dmac specific parameters to the dma controller driver
>>>
>>> DMA Model:-
>>> ? Only the most common characteristics of a dma setup are assumed
>>> in this binding.
>>> Client: Some h/w controller that could request a DMA controller in
>>> the system to perform data transfer on its behalf. Example SPI, MMC,
>>> I2S etc.
>>> DMAC: A DMA Controller instance. Example, PL330, PL08X, SDMA etc.
>>>
>>> ?The assumed model of the DMAC, in this binding, has P peripheral
>>> interfaces (P request signals) that could request a data transfer
>>> and C physical channels that actually do the data transfers, hence,
>>> at most C out of P peripherals could be served by the DMAC at any
>>> point of time. Usually C := P, but not always. Usually, any of the
>>> physical channels could be employed by the DMAC driver to serve any
>>> client.
>>> ?The DMAC driver identifies a client by its i/f number, 'peri_id'
>>> on the given DMAC. For example, TX for SPI has 7th while RX_TX
>>> (half-duplex) for MMC has 10th peripheral interface (request-signal)
>>> on a given DMAC. Usually, any of the physical channels could be
>>> employed by the DMAC driver to serve a client.
>>
>> I'm still anything but convinced by this model. Basically it's the
>> exact opposite of what we do for every other subsystem (irq, pinctrl,
>> regulator, gpio, ...), where the device using some infrastructure
>> contains the information about who provides it, whereas here you
>> move all the information into the device that provides the functionality,
>> and have no handle in the device using it by which the driver can
>> identify it.
>
> Yes, I guess this is backwards. But, the HW is a little different too;
> GPIOs (and probably interrupts) don't have multiple places they could
> come from.
>
> The problem is that if we did something like this in the DMA client:
>
> dma-reqs = <&dmac1 DMAC1_DMA_REQ_6 &dmac1 DMAC1_DMA_REQ_8>;
>
> how do we know if the client is emitting 2 DMA request signals that get
> routed to two different inputs on the DMA controller, or whether this is
> two alternatives for the same signal.
>
FWIW, I wouldn't lose sleep over the possibility of redundancy on same DMAC.
If a client's request signal is routed to 2 inputs, they are usually
on different DMACs.
