From: robherring2@gmail.com (Rob Herring)
Date: Mon, 17 Sep 2012 15:29:14 -0500
Subject: [PATCH v2] ARM: l2x0: make background cache ops optional for
 clean and flush range
In-Reply-To: <20120917194733.GQ12245@n2100.arm.linux.org.uk>
References: <1347306334-781-1-git-send-email-robherring2@gmail.com>
 <1347890398-22088-1-git-send-email-robherring2@gmail.com>
 <20120917194733.GQ12245@n2100.arm.linux.org.uk>
Message-ID: <5057881A.9020604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2012 02:47 PM, Russell King - ARM Linux wrote:
> On Mon, Sep 17, 2012 at 08:59:58AM -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> All but background ops are atomic on the pl310, so a spinlock is not
>> needed for a cache sync if background operations are not used. Using
>> background ops was an optimization for flushing large buffers, but that's
>> not needed for platforms where i/o is coherent and/or that have a larger
>> cache size than likely to flush at once. The cache sync spinlock is
>> taken on every readl/writel and can be a bottleneck for code paths with
>> register accesses.
>>
>> The default behaviour is unchanged. Platforms can enable using atomic
>> cache ops only by adding "arm,use-atomic-ops" to pl310 device-tree
>> node.
>>
>> It is assumed that remaining background ops are only used in non-SMP
>> code paths.
> 
> (a) you're not describing hardware, you're describing a feature of the
>     Linux kernel's implementation - no, you're describing a configuration
>     feature of the kernel.  This should not be in DT.
> (b) you're disabling the optimization to avoid doing a lengthy line-by-line
>     cache operation when the size is larger than the cache size, and trading
>     it for possibly slightly quicker accesses.
> 
> The problem I have with this is it's likely that you've only looked at
> "oh, this makes IO accesses faster" and not the total picture wrt the
> effect on time taken by the DMA API.

No, I'm looking at the system performance and profiling led me here. If
i/o is coherent, then L2 cache operations are never called by the DMA
mapping API. So we have a optimization using background ops that I will
never hit and that optimization gives me a negative performance impact.

I could easily "fix" this in the xgmac driver by using __raw_writel or
writel_relaxed, but that would break non-coherent operation which does
need the L2 cache barriers.

Even with non-coherent i/o, I'm not likely to be doing >4MB at a time
flushes on my system. It is certainly impossible for networking. I'm not
sure about SATA, but I'd guess that size is also unlikely.

> Plus, because there's little justification behind this patch (apart
> from a vague reference to the speed of IO accesses) I'm going to say
> NAK to this until further information is forthcoming justifying this
> change.
> 

30% faster network transmit rate with pktgen on highbank.

> In any case (a) applies whatever.  This is not hardware description,
> this is implementation configuration which has nothing to do with DT.
> Don't use DT as a dumping ground for implementation configuration.

It's not without precedence, but you are right that it is a questionable
use of DT. I'm open to suggestions of how you would expose this
configuration to platforms. We obviously don't want a compile time
option. Some options:

- Add a flags param to l2x0_of_init to configure it
- Add non-background version of functions and override the function ptrs
in platform code.
- Add a new call to configure l2 settings like this.
- Expose the use_background_ops variable directly

Rob
