From: joelf@ti.com (Joel Fernandes)
Date: Wed, 31 Jul 2013 20:59:27 -0500
Subject: [PATCH 7/9] ARM: edma: Don't clear EMR of channel in edma_stop
In-Reply-To: <51F8DA5C.9060503@ti.com>
References: <1375104595-16018-1-git-send-email-joelf@ti.com>
 <1375104595-16018-8-git-send-email-joelf@ti.com> <51F77982.7030601@ti.com>
 <51F89B0B.4080803@ti.com> <51F8DA5C.9060503@ti.com>
Message-ID: <51F9C0FF.7030703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2013 04:35 AM, Sekhar Nori wrote:
> On Wednesday 31 July 2013 10:35 AM, Joel Fernandes wrote:
>> On 07/30/2013 03:29 AM, Sekhar Nori wrote:
>>> On Monday 29 July 2013 06:59 PM, Joel Fernandes wrote:
>>>> We certainly don't want error conditions to be cleared anywhere
>>>
>>> 'anywhere' is a really loaded term.
>>>
>>>> as this will make us 'forget' about missed events. We depend on
>>>> knowing which events were missed in order to be able to reissue them.
>>>
>>>> This fixes a race condition where the EMR was being cleared
>>>> by the transfer completion interrupt handler.
>>>>
>>>> Basically, what was happening was:
>>>>
>>>>             Missed event
>>>>              |
>>>>              |
>>>>              V
>>>> SG1-SG2-SG3-Null
>>>>          \
>>>>           \__TC Interrupt (Almost same time as ARM is executing
>>>> TC interrupt handler, an event got missed and also forgotten
>>>> by clearing the EMR).
>>>
>>> Sorry, but I dont see how edma_stop() is coming into picture in the race
>>> you describe?
>>
>> In edma_callback function, for the case of DMA_COMPLETE (Transfer
>> completion interrupt), edma_stop() is called when all sets have been
>> processed. This had the effect of clearing the EMR.
> 
> Ah, thanks. I was missing the fact that the race comes into picture only
> when using the DMA engine driver. I guess that should be mentioned
> somewhere since it is not immediately obvious.
> 
> The patch looks good to me. So if you respin just this one with some
> updated explanation based on what you wrote below, I will take it.

Sure I'll do that. Also the trigger_channel patch, will you be taking
that one too? I can send these 2 in a series as they touch
arch/arm/common/edma.c

Thanks,

-Joel



> 
> Thanks,
> Sekhar
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
