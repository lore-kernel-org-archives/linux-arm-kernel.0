From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 15 Dec 2015 16:05:32 +0200
Subject: [PATCH 2/6] ARM: DTS: da850: Use the new DT bindings for the eDMA3
In-Reply-To: <56701A47.9090105@ti.com>
References: <1449237210-16381-1-git-send-email-peter.ujfalusi@ti.com>
 <1449237210-16381-3-git-send-email-peter.ujfalusi@ti.com>
 <566FDF93.7050005@ti.com> <566FFD1C.4080000@ti.com> <56701A47.9090105@ti.com>
Message-ID: <56701E2C.7060308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2015 03:48 PM, Sekhar Nori wrote:
>>> These correspond to PRU events. It is true that most likely they will
>>> never be used for peripheral DMA and can be dedicated as memcpy
>>> channels. However, since this is being encoded in DT, we need to be sure
>>> that they will never be used for peripheral DMA on this board.
>>>
>>> So, I would prefer if you do not reserve any channels for memcpy until
>>> there is a real need/usecase for them. I know the board file has these
>>> reserved but board file could be updated as you liked. With DT we need
>>> to maintain backward compatibility. So I would rather do it when there
>>> is an actual need for it.
>>
>> If we do not reserve channels for memcpy then you will have no support for
>> memcpy on these boards. Not sure if we use memcpy in any of our drivers in
>> daVinci, so it might be just fine to not have DMA memcpy support at all.
> 
> Not that I know of. No driver uses DMA memcpy
> 
>> But how about using edma1's reserved channels as memcpy (19-23, 30-31)? I
> 
> I think this is much more reasonable.
> 
>> don't know which channels the DSP would use on these boards, so it is never
>> going to be safe from that point.
> 
> Yeah, and thats why I think its better to add it as and when there is a
> real need for it. At least at that point we are sure of the usecase.

OK, I'll disable the memcpy for now.

>>> In future, if/when we gain QDMA support, the QDMA channels could be used
>>> for memcopy.
>>
>> Well, in short there is no way to get the qDMA working in a different way
>> either. qDMA channel is in essence using 'normal' eDMA channel. This means
>> that we still need to reserve the eDMA channel to be used for memcpy, but
>> instead of SW triggering it (as we do it right now), we would need to use the
>> channel as qDMA and set things up accordingly. I don't really see the benefit
>> for qDMA mode to be honest.
> 
> I guess the only advantage is that they will not clash with peripheral
> mode usage. But even then, some sort of reservation is needed. So I
> guess QDMA is no better than the EDMA reserved channels?

It will clash with the peripheral mode use since it needs to take one of the
eDMA channels. qDMA mode is basically differs from the mode we are using by
how the channel is triggered. Currently we start the memcpy with SW trigger.
In qDMA mode we can select a paRAM parameter which if it is updated will do
the triggering. It is useful if you have mostly constant memcpy parameters and
you only need to change one thing in there (reusing the paRAM slot), like you
change the dst address. In this case you just update the dst and the qDMA will
be triggered. I don't think we can take advantage of this feature via dmaengine.

-- 
P?ter
