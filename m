From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Apr 2017 15:48:39 +0100
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <CA+sq2CeTZyTrc3kC-kJEyrT5Tt5Wr47F=OVaCHwMRZk96qo4HA@mail.gmail.com>
References: <20160321171403.GE25466@e104818-lin.cambridge.arm.com>
 <CAPub14-sFgx=oCHzJPb9h9b_V0rbn5UAMDNJ-yTkjhz38JPqMQ@mail.gmail.com>
 <10fef112-37f1-0a1b-b5af-435acd032f01@codeaurora.org>
 <4525901c-45d4-6bd8-eec6-ae92977f16d1@codeaurora.org>
 <20170406155825.GA7705@e104818-lin.cambridge.arm.com>
 <CADAEsF_Hr=mPspvuPsQtKWiSDu6oCjfyy0rGwWrF9EJo-ZO1JA@mail.gmail.com>
 <08fa98de-760b-15bc-5220-fa449b08c118@codeaurora.org>
 <725F073F-025B-48B9-9935-24EFEBF2B7DC@caviumnetworks.com>
 <93d2819a-95b1-6606-74d4-0bc0a64db29e@codeaurora.org>
 <CA+sq2CeTZyTrc3kC-kJEyrT5Tt5Wr47F=OVaCHwMRZk96qo4HA@mail.gmail.com>
Message-ID: <20170418144839.GF27592@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 17, 2017 at 04:08:52PM +0530, Sunil Kovvuri wrote:
> >>     >> Do you have an explanation on the performance variation when
> >>     >> L1_CACHE_BYTES is changed? We'd need to understand how the network stack
> >>     >> is affected by L1_CACHE_BYTES, in which context it uses it (is it for
> >>     >> non-coherent DMA?).
> >>     >
> >>     > network stack use SKB_DATA_ALIGN to align.
> >>     > ---
> >>     > #define SKB_DATA_ALIGN(X) (((X) + (SMP_CACHE_BYTES - 1)) & \
> >>     > ~(SMP_CACHE_BYTES - 1))
> >>     >
> >>     > #define SMP_CACHE_BYTES L1_CACHE_BYTES
> >>     > ---
> >>     > I think this is the reason of performance regression.
> >>     >
> >>
> >>     Yes this is the reason for performance regression. Due to increases L1 cache alignment the
> >>     object is coming from next kmalloc slab and skb->truesize is changing from 2304 bytes to
> >>     4352 bytes. This in turn increases sk_wmem_alloc which causes queuing of less send buffers.
> 
> With what traffic did you check 'skb->truesize' ?
> Increase from 2304 to 4352 bytes doesn't seem to be real. I checked
> with ICMP pkts with maximum
> size possible with 1500byte MTU and I don't see such a bump. If the
> bump is observed with Iperf
> sending TCP packets then I suggest to check if TSO is playing a part over here.

I haven't checked truesize but I added some printks to __alloc_skb() (on
a Juno platform) and the size argument to this function is 1720 on many
occasions. With sizeof(struct skb_shared_info) of 320, the actual data
allocation is exactly 2048 when using 64 byte L1_CACHE_SIZE. With a
128 byte cache size, it goes slightly over 2K, hence the 4K slab
allocation. The 1720 figure surprised me a bit as well since I was
expecting something close to 1500.

The thing that worries me is that skb->data may be used as a buffer to
DMA into. If that's the case, skb_shared_info is wrongly aligned based
on SMP_CACHE_BYTES only and can lead to corruption on a non-DMA-coherent
platform. It should really be ARCH_DMA_MINALIGN.

IIUC, the Cavium platform has coherent DMA, so it shouldn't be an issue
if we go back to 64 byte cache lines. However, we don't really have an
easy way to check (maybe taint the kernel if CWG is different from
ARCH_DMA_MINALIGN *and* the non-coherent DMA API is called).

-- 
Catalin
