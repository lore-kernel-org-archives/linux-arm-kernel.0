From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue, 1 Sep 2015 08:16:05 +0800
Subject: [PATCH v2 0/5] Fix broken DMAFLUSHP on Rockchips platform
In-Reply-To: <CAPz6YkXmGkQsB4WbQ5VbBAPRCTQFYCUR=Nf6G+syhbXSPA2DeQ@mail.gmail.com>
References: <1440722176-31588-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPz6YkXmGkQsB4WbQ5VbBAPRCTQFYCUR=Nf6G+syhbXSPA2DeQ@mail.gmail.com>
Message-ID: <55E4EE45.5020002@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2015/9/1 5:40, Sonny Rao ??:
> On Thu, Aug 27, 2015 at 5:36 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> The purpose of the DMAFLUSHP instruction:
>> - Tell the peripheral to clear its status and control registers.
>> - Send a message to the peripheral to resend its level status.
>>
>> There are 3 timings described in PL330 Technical Reference Manual:
>> - Timing 1: Burst request, can work well without DMAFLUSHP.
>> - Timing 2: Single and burst request, DMAC will ignore the single
>>              transfer request. This timing happens if there are single
>>              and burst request.
>> - Timing 3: Single transfers for a burst request, DMAC should signals
>>              datype to request the peripheral to flush the contents of
>>              any control registers. This timing happens if there is
>>              not enough MFIFO to places the burst data.
>>
>> A peripheral may signal a DMA request during the execution of
>> DMAFLUSHP instruction, that cause DMA request being ignored by DMAC.
>>
>> But DMAC and all peripherals on RK3X SoCs DO NOT support DMAFLUSHP.
>> It can't send a message to the peripheral to resend DMA request,
>> and the peripheral can't acknowledge a flush request from DMAC.
>> So all DMA requests should NOT be ignored by DMAC, and DMAC will not
>> notify the peripheral to flush.
>>
>> To fix this problem, we need:
>> - Do NOT execute DMAFLUSHP instruction.
>> - Timing 2 and timing 3 should not happen.
>>
>> Because on RK3X SoCs, there are 6 or below  channels and 32 MFIFO depth
>> for DMAC_BUS, and 8 channels and 64 MFIFO depth for DMAC_PERI, it is
>> impossible to hit the timing 3 if burst length is equal or less than 4.
>
> Fixing this issue also requires changes to drivers, so it would be
> nice if you put those changes into the same patchset.
> Otherwise someone may apply this series and expect things to work but
> they will still be broken. Specifically the peripherals should be
> setting their burst sizes for their DMA requests low enough to avoid
> needing the working DMAFLUSHP instruction.
>
> Also, I remember we ran into an issue when we tried using burst length
> of 4 with the i2s device on RK3288 because we could get requests that
> either weren't aligned or a multiple of 4 sizes and some transfers
> would just fail, so we ended up using a burst size of 1.  I recommend
> if we aren't sure about size or alignment for a particular peripheral,
> a burst size of 1 is safest.  For something like a block device, I
> think we can use the larger size bursts.  That's another reason to

Agreed. Those changes will be added in v3.

Thanks, Sunny.

> include the driver fixes in the series, just so we get it right,
> thanks.
>
>>
>> Since the request type signal by the peripheral can only be set by
>> software. We can set Rockchip Soc's GRF_PERIDMAC_CON0[2:1] to select single
>> or burst request, if it is set b01,  all of the peripharals will signal a brust
>> request. So the timing 2 will not happen, too.
>>
>> So DMAC on RK3X can support single or burst transfer, but can't support
>> mixed transfer.
>>
>> Because burst transfer is more efficient than single transfer, this is
>> confirmed by our ASIC team, who strongly suggest to use burst transfer.
>> And this is confirmed by Addy's test on RK3288-Pink2 board, the speed of
>> spi flash burst transfer will increase about two times than single transfer.
>> Also, I have tested dw_mmc with pl330 on RK3188 platform to double confirm
>> the result. That means burst transfer is reansonable.
>>
>> So we need a quirk not to execute DMAFLUSHP instruction and to use burst
>> transfer.
>>
>> Note:
>> - The Rockchip Soc default value of GRF_PERIDMAC_CON0[2:1] is b01. To
>>    support brust transfer, these bits should not be changed in bootloader.
>>
>>
>> Changes in v2:
>> - amend the author
>> - reorder the patches suggested by Doug
>> - add Reviewed-by: Doug Anderson <dianders@chromium.org> for
>>    rk3288.dtsi patch and arm-pl330.txt patch
>> - amend Olof's mail address
>>
>> Changes in v1:
>> - rename broken-no-flushp to "arm,pl330-broken-no-flushp" suggested
>>    by Krzysztof.
>> - add From original author.
>> - remove Sunny's tag
>>
>> Addy Ke (2):
>>    DMA: pl330: add quirk for broken no flushp
>>    ARM: dts: Add arm,pl330-broken-no-flushp quirk for rk3288 platform
>>
>> Boojin Kim (1):
>>    DMA: pl330: support burst mode for dev-to-mem and mem-to-dev transmit
>>
>> Shawn Lin (2):
>>    Documentation: arm-pl330: add description of
>>      arm,pl330-broken-no-flushp
>>    ARM: dts: Add arm,pl330-broken-no-flushp quirk for rk3xxx platform
>>
>>   .../devicetree/bindings/dma/arm-pl330.txt          |   1 +
>>   arch/arm/boot/dts/rk3288.dtsi                      |   3 +
>>   arch/arm/boot/dts/rk3xxx.dtsi                      |   3 +
>>   drivers/dma/pl330.c                                | 101 +++++++++++++++------
>>   4 files changed, 79 insertions(+), 29 deletions(-)
>>
>> --
>> 2.3.7
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>


-- 
Best Regards
Shawn Lin
