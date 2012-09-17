From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 Sep 2012 21:45:52 +0100
Subject: [PATCH v2] ARM: l2x0: make background cache ops optional for
 clean and flush range
In-Reply-To: <5057881A.9020604@gmail.com>
References: <1347306334-781-1-git-send-email-robherring2@gmail.com>
 <1347890398-22088-1-git-send-email-robherring2@gmail.com>
 <20120917194733.GQ12245@n2100.arm.linux.org.uk>
 <5057881A.9020604@gmail.com>
Message-ID: <CAHkRjk5XOB+5xPfqL4fBdmO+ZGXMkcYDk76mFotfeUqyPEPEhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 September 2012 21:29, Rob Herring <robherring2@gmail.com> wrote:
> On 09/17/2012 02:47 PM, Russell King - ARM Linux wrote:
>> On Mon, Sep 17, 2012 at 08:59:58AM -0500, Rob Herring wrote:
>>> From: Rob Herring <rob.herring@calxeda.com>
>>>
>>> All but background ops are atomic on the pl310, so a spinlock is not
>>> needed for a cache sync if background operations are not used. Using
>>> background ops was an optimization for flushing large buffers, but that's
>>> not needed for platforms where i/o is coherent and/or that have a larger
>>> cache size than likely to flush at once. The cache sync spinlock is
>>> taken on every readl/writel and can be a bottleneck for code paths with
>>> register accesses.
>>>
>>> The default behaviour is unchanged. Platforms can enable using atomic
>>> cache ops only by adding "arm,use-atomic-ops" to pl310 device-tree
>>> node.
>>>
>>> It is assumed that remaining background ops are only used in non-SMP
>>> code paths.
>>
>> (a) you're not describing hardware, you're describing a feature of the
>>     Linux kernel's implementation - no, you're describing a configuration
>>     feature of the kernel.  This should not be in DT.
>> (b) you're disabling the optimization to avoid doing a lengthy line-by-line
>>     cache operation when the size is larger than the cache size, and trading
>>     it for possibly slightly quicker accesses.
>>
>> The problem I have with this is it's likely that you've only looked at
>> "oh, this makes IO accesses faster" and not the total picture wrt the
>> effect on time taken by the DMA API.
>
> No, I'm looking at the system performance and profiling led me here. If
> i/o is coherent, then L2 cache operations are never called by the DMA
> mapping API. So we have a optimization using background ops that I will
> never hit and that optimization gives me a negative performance impact.
>
> I could easily "fix" this in the xgmac driver by using __raw_writel or
> writel_relaxed, but that would break non-coherent operation which does
> need the L2 cache barriers.

I haven't looked at the xgmac driver but you can use the relaxed
accessors entirely in this file with explicit mb() where the barrier
is needed. It may give you some improvement, though you still issue an
L2 sync as part of mb(). The only issue is that the relaxed accessors
are not defined on all architectures, nor the semantics are clear
between those that define it.

BTW, if you use the streaming DMA API, the barrier should be (or can
be added) part of the API implementation. For the coherent API,
ideally we should implement the ordering between I/O and DMA
operations as part of the API but there isn't such functionality
provided (nor driver writers willing to do this explicitly), so we
overload the mb() and I/O accessors.

-- 
Catalin
