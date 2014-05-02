From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 2 May 2014 12:41:01 +0100
Subject: [PATCH v12 11/31] documentation: iommu: add binding document of
 Exynos System MMU
In-Reply-To: <53628751.9000609@wwwdotorg.org>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
 <20140429181601.GE3582@e103592.cambridge.arm.com>
 <CANEJEGs6TXNzE8cWYgEKfFSsD2w5XiYvwSbhQ_+gtfzfs+6udA@mail.gmail.com>
 <7044616.kdaKNu3Qet@wuerfel> <53628751.9000609@wwwdotorg.org>
Message-ID: <20140502114054.GA3805@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 01, 2014 at 06:41:37PM +0100, Stephen Warren wrote:
> On 04/29/2014 03:00 PM, Arnd Bergmann wrote:
> ...
> > Yes. It's very complicated unfortunately, because we have to be
> > able to deal with arbitrary combinations of a lot of oddball cases
> > that can show up in random SoCs:
> ...
> > - a device may have DMA access to a bus that is invisible to the CPU
> 
> The issue is slightly more general than that. It's more that the bus
> structure "seen" by a device is simply /different/ than that seen by the
> CPU. I don't think it's a requirement that there be CPU-invisible buses
> for that to be true.
> 
> For example, I could conceive of a HW setup like:
> 
> primary CPU bus ----------------------> other devices
>    |    \_________________      /
>    |                      \    |
>    v                      v    ^
> device registers ----> some secondary bus
>                           |
>                           v
>                        memory
> 
> Here, all the buses are visible to the CPU, yet the path that
> transactions take between the buses is simply different to the CPU. More
> complex situations than the above, while still maintaining that
> description, are certainly possible.
> 

I tend to think in terms of links rather than buses.  A link is
effectively a 1:1 point-to-point bus that passes all transactions with
no modification.

So, although "some secondary bus" is visible to the CPUs, crucially the
link "some secondary bus" to "other devices" is not visible -- in the
sense that transactions issued by the CPUs never flow down that link.
Thus, if the link actually has remappings associated with it, then
devices mastering onto "some secondary bus" will observe those mappings
but the CPUs won't.  That's precisely what we need to know about when
configuring DMA buffers.

"invisible bus" situations are therefore a subset of "invisible link"
situations, and it is the latter which are the source of the complexity.

However, if the extra link(s) don't have any special characteristics, it
may be software-transparent with no need for description, because we
can pretend for logical purposes that there is a single bus in that case.
Effectively that what we've relied on for simpler systems up to now.

I'm assming in your example that the direct link between "primary CPU
bus" and "other devices" is always used by preference, instead of CPUs'
transactions toward "other devices" being sent to "some secondary bus"
first.

Cheers
---Dave
