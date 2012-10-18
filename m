From: shijie8@gmail.com (Huang Shijie)
Date: Thu, 18 Oct 2012 11:18:53 -0400
Subject: [PATCH] dma: add new DMA control commands
In-Reply-To: <CAJe_ZhfarH-HpJkEOpH=jY1Gc-UPEyuA4bJ4LSQES7Uyea2BQw@mail.gmail.com>
References: <1350538335-29026-1-git-send-email-b32955@freescale.com>
 <1350541111.5263.3.camel@vkoul-udesk3>
 <507FA595.4020507@freescale.com>
 <CAJe_ZhfarH-HpJkEOpH=jY1Gc-UPEyuA4bJ4LSQES7Uyea2BQw@mail.gmail.com>
Message-ID: <CAMiH66H=VMEgHFMdEhCTqA5AtVw6iN97-cbwUd86Ghd77OLcWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2012 at 5:29 AM, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> On 18 October 2012 12:15, Huang Shijie <b32955@freescale.com> wrote:
>> ? 2012?10?18? 14:18, Vinod Koul ??:
>>
>>> Why cant you do start (prepare clock etc) when you submit the descriptor
>>> to dmaengine. Can be done in tx_submit callback.
>>> Similarly remove the clock when dma transaction gets completed.
>>
>> I ever thought this method too.
>>
>> But it will become low efficient in the following case:
>>
>>   Assuming the gpmi-nand driver has to read out 1024 pages in one _SINGLE_
>> read operation.
>> The gpmi-nand will submit the descriptor to dmaengine per page. So with your
>> method,
>> the system will repeat the enable/disable dma clock 1024 time. At every
>> enable/disable dma clock,
>> the system has to enable the clock chain and it's parents ...
>>
>> But with this patch, we only need to enable/disable dma clock one time, just
>> at we select the nand chip.
>>
> If the clock is the dmac's property (not channels'), the toggling
> seems too aggressive.
> You could try using runtime_suspend/resume for clock
> disabling/enabling. How about employing autosuspend with a few ms
> delay?

Yes, employing the autosuspend is workable method too.o
But it's a little more complicated then this patch. You have to create
a thread or workqueue to
do the job.

What's more, I think other DMA engine may also meets the same issue as
the mxs-dma, such as the imx-sdma.
It's somehow a common issue to disable the clocks when no one use the
DMA engine.
Do you also suggest employing the autosuspend? Why not use a simple
way to handle this issue?
When the dma device want to use a DMA engine, it just needs to issue a
DMA_START command.

thanks
Huang Shijie
Huang Shijie
