From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 05 Mar 2015 22:05:25 -0700
Subject: [PATCH 09/10] ARM: bcm2835: Add the mailbox property channel
 driver.
In-Reply-To: <87vbif6wzi.fsf@eliezer.anholt.net>
References: <1425329684-23968-1-git-send-email-eric@anholt.net>
 <1425329684-23968-10-git-send-email-eric@anholt.net>
 <54F68352.5080108@wwwdotorg.org> <87vbif6wzi.fsf@eliezer.anholt.net>
Message-ID: <54F93595.6050809@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/2015 12:54 PM, Eric Anholt wrote:
> Stephen Warren <swarren@wwwdotorg.org> writes:
> 
>> On 03/02/2015 01:54 PM, Eric Anholt wrote:
>>> Many of the operations with the firmware are done through this
>>> mailbox channel pair with a specific packet format.  Notably,
>>> it's used for clock control, which is apparently not actually
>>> totally possible to do from the ARM side (some regs aren't
>>> addressable).  I need clock control for the VC4 DRM driver, to
>>> turn on the 3D engine.
>> 
>>> diff --git a/drivers/mailbox/bcm2835-mailbox-property.c
>>> b/drivers/mailbox/bcm2835-mailbox-property.c +int
>>> bcm_mbox_property(void *data, size_t tag_size)
>> 
>>> +	buf = dma_alloc_coherent(NULL, PAGE_ALIGN(size), &bus_addr,
>>> GFP_ATOMIC); +	if (!buf) +		return -ENOMEM;
>> 
>> Can't the driver (this one or the client) maintain some
>> persistent buffer rather than allocating/freeing a new one each
>> time. It seems like the alloc/free might introduce quite some
>> overhead?
> 
> The size of the buffer is arbitrary (up to 1MB), the frequency of 
> requessts is low, and the hardware's pretty starved for RAM.
> However, we're probably only ever going to see single page
> allocations, so the RAM cost is probably low and the allocation
> time is probably also correspondingly low (not like when I was
> trying to do 256k allocations in the vc4 driver.  ouch).

OK. Since this is an implementation detail with no effect on DT ABI,
it would be easy to change later if it did turn out to be an issue.

>>> +	writel(size, buf); +	writel(bcm_mbox_status_request, buf +
>>> 4); +	memcpy_toio(buf + 8, data, tag_size); +
>>> writel(bcm_mbox_property_end, buf + size - 4);
>> 
>> Since this is just a regular chunk of RAM, can't the code just
>> use regular memory writes and memcpy()?
> 
> will wmb() guarantee that the compiler won't optimize out my write
> to buf[0] and corresponding read from buf[0]?  I was originally
> treating it as RAM and using volatile, but then reread the old
> "don't use volatile" doc.

Yes, all of the barrier implementations boil down to one of:

#define isb(x) __asm__ __volatile__ ("mcr p15, 0, %0, c7, c5, 4" \
                                    : : "r" (0) : "memory")
#define dsb(x) __asm__ __volatile__ ("mcr p15, 0, %0, c7, c10, 4" \
                                    : : "r" (0) : "memory")
#define dmb(x) __asm__ __volatile__ ("mcr p15, 0, %0, c7, c10, 5" \
                                    : : "r" (0) : "memory")

The final :"memory" tells the compiler that the __asm__ statement may
change memory, so the compiler isn't allowed to "cache" anything over
the statement.
