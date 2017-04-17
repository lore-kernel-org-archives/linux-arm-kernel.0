From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Mon, 17 Apr 2017 16:08:52 +0530
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <93d2819a-95b1-6606-74d4-0bc0a64db29e@codeaurora.org>
References: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
 <DA22064C-45A7-4F79-A433-84054AF182DF@caviumnetworks.com>
 <20160321171403.GE25466@e104818-lin.cambridge.arm.com>
 <CAPub14-sFgx=oCHzJPb9h9b_V0rbn5UAMDNJ-yTkjhz38JPqMQ@mail.gmail.com>
 <10fef112-37f1-0a1b-b5af-435acd032f01@codeaurora.org>
 <4525901c-45d4-6bd8-eec6-ae92977f16d1@codeaurora.org>
 <20170406155825.GA7705@e104818-lin.cambridge.arm.com>
 <CADAEsF_Hr=mPspvuPsQtKWiSDu6oCjfyy0rGwWrF9EJo-ZO1JA@mail.gmail.com>
 <08fa98de-760b-15bc-5220-fa449b08c118@codeaurora.org>
 <725F073F-025B-48B9-9935-24EFEBF2B7DC@caviumnetworks.com>
 <93d2819a-95b1-6606-74d4-0bc0a64db29e@codeaurora.org>
Message-ID: <CA+sq2CeTZyTrc3kC-kJEyrT5Tt5Wr47F=OVaCHwMRZk96qo4HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>     >> Do you have an explanation on the performance variation when
>>     >> L1_CACHE_BYTES is changed? We'd need to understand how the network stack
>>     >> is affected by L1_CACHE_BYTES, in which context it uses it (is it for
>>     >> non-coherent DMA?).
>>     >
>>     > network stack use SKB_DATA_ALIGN to align.
>>     > ---
>>     > #define SKB_DATA_ALIGN(X) (((X) + (SMP_CACHE_BYTES - 1)) & \
>>     > ~(SMP_CACHE_BYTES - 1))
>>     >
>>     > #define SMP_CACHE_BYTES L1_CACHE_BYTES
>>     > ---
>>     > I think this is the reason of performance regression.
>>     >
>>
>>     Yes this is the reason for performance regression. Due to increases L1 cache alignment the
>>     object is coming from next kmalloc slab and skb->truesize is changing from 2304 bytes to
>>     4352 bytes. This in turn increases sk_wmem_alloc which causes queuing of less send buffers.

With what traffic did you check 'skb->truesize' ?
Increase from 2304 to 4352 bytes doesn't seem to be real. I checked
with ICMP pkts with maximum
size possible with 1500byte MTU and I don't see such a bump. If the
bump is observed with Iperf
sending TCP packets then I suggest to check if TSO is playing a part over here.

And for 'sk_wmem_alloc', I have done Iperf benchmarking on a 40G
interface and I hit linerate irrespective
of cache line size being 64 or 128 bytes. I guess transmit completion
latency on your HW or driver is very
high and that seems to be the real issue for low performance and not
due to cache line size, basically you are
not able to freeup skbs/buffers fast enough so that new ones get queued up.

Doesn't skb_orphan() solve your issue ?
FYI,
https://patchwork.ozlabs.org/patch/455134/
http://lxr.free-electrons.com/source/drivers/net/ethernet/chelsio/cxgb3/sge.c#L1288


>>
>> We tried different benchmarks and found none which really affects with Cache line change. If there is no correctness issue,
>> I think we are fine with reverting the patch.
>>
> So, can we revert the patch that makes L1_CACHE_SHIFT 7 or should the patch suggested by Catalin should be mainlined.

This doesn't seem right, as someone said earlier what if there is
another arm64 platform with 32bytes
cacheline size and wants to reduce this further. Either this should be
made platform dependent or left as is
i.e that is maximum of all.

Thanks,
Sunil.
