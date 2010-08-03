From: hemantp@ti.com (Pedanekar, Hemant)
Date: Tue, 3 Aug 2010 23:24:03 +0530
Subject: Memory type used for ioremap
References: <2A3DCF3DA181AD40BDE86A3150B27B6B030E181724@dbde02.ent.ti.com>
	<1278677464.11895.41.camel@e102109-lin.cambridge.arm.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E181CAD@dbde02.ent.ti.com>
	<20100709141416.GI22845@n2100.arm.linux.org.uk>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E5E42A7@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pedanekar, Hemant wrote:
> Russell King - ARM Linux wrote:
>> On Fri, Jul 09, 2010 at 07:32:46PM +0530, Pedanekar, Hemant wrote:
>>> Catalin,
>> 
>> It'd help if I could see more of your mail than just the above when
>> replying to it.  Please wrap your messages rather than typing entire
>> paragraphs on one single line.
>> 
>> <save this message, go back and read your original, re-edit reply>
>> 
> 
> Sorry for that. Here is the earlier reply:
> 
[...]
>> 
>> We have had devices in the past where certain peripherals are only
>> visible via non-shared device mappings.  Could this be one of them?
>> 
> 
> If I wanted to have mapping for "Strongly-ordered" memory type, is there any
> function that I can use from driver? I guess 'ioremap' won't help here?
> Probably I need to use MT_MEMORY_NONCACHED and do a static mapping?
> 
>> Without knowing more about the device you're using, in particular
>> how the bus matrix is setup, there's no way to comment definitively.
>> What does the documentation for your device say about the type of
>> mappings required for this peripheral?
> 
> I will confirm and update but looks like I need to have "Strongly-ordered"
> type. 
> 

Russell,

I have confirmed that with mapping the concerned region as "Strongly Ordered",
the write accesses work fine.

Following are the observations and particulars:

1) The peripheral region has constraint that it requires writes to be
non-posted. Posted writes are not supported.
2) On my system, writes to the region mapped as MT_DEVICE or MT_DEVICE_NONSHARED
are posted and hence do not work in this case.
3) While writes on "Strongly Ordered" region are non-posted and work fine.

Please note that to enable strongly-ordered mapping, I used the patch posted by
Paul Walmsley [1].

Can you please clarify the following?

1) Looks like ioremap() cannot be used for above case. Is there any alternative?
2) If the only way to go is create static mapping, which MT type shall I use? I
don't see anything like STRONGLY_ORDERED in arch/arm/mm/mmu.c
3) Do all ARMv7 have the same behavior regarding non-/posted nature of writes as
per the mapping - or is it implementation dependent?
4) I couldn't find any other mach-* where strongly ordered mapping was used.
Does this mean that strongly ordered access requirement is uncommon?
5) I see that the patch [1] from Paul is not present in arch/arm/mm/mmu.c but
the above mentioned constraint would require something similar (unless there is
better way to achieve this). So can you please suggest how to go about it?

Thanks
-
Hemant

[1] http://www.mail-archive.com/linux-omap at vger.kernel.org/msg02771.html
