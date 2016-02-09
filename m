From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 09 Feb 2016 21:22:08 +0100
Subject: [PATCH] dmaengine: pxa_dma: fix the maximum requestor line
In-Reply-To: <20160209152007.GQ19598@localhost> (Vinod Koul's message of "Tue,
 9 Feb 2016 20:50:07 +0530")
References: <1454941131-12308-1-git-send-email-robert.jarzmik@free.fr>
 <20160209033646.GK19598@localhost> <878u2u2vve.fsf@belgarion.home>
 <20160209152007.GQ19598@localhost>
Message-ID: <874mdh3a8f.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

> On Tue, Feb 09, 2016 at 08:20:05AM +0100, Robert Jarzmik wrote:
>> Vinod Koul <vinod.koul@intel.com> writes:
>> 
>> > On Mon, Feb 08, 2016 at 03:18:51PM +0100, Robert Jarzmik wrote:
>> >> The current number of requestor lines is limited to 31. This was an
>> >> error of a previous commit, as this number is platform dependent, and is
>> >> actually :
>> >>  - for pxa25x: 40 requestor lines
>> >>  - for pxa27x: 74 requestor lines
>> >>  - for pxa3xx: 100 requestor lines
>> >> 
>> >> As the driver doesn't need to know the exact number, but only an
>> >
>> > and why would that be a good assumption?
>> Well, the driver doesn't use the exact value. Would that be 128, 1000 or 10000,
>> it wouldn't change its behavior. The clients either pass -1UL (ie. no flow
>> control) or a requestor line number.
>
> Somehow that does not sound right to me. You seem to have no way of knowing
> what is the actual max request line for a platforms. What if on pxa25x user
> requests more than 40 lines?
>
>> > Btw shouldn't this data come from DT?
>> It can if you wish, but in this case I must amend the platform data case too, ie
>> mmp_dma_platdata. And this has an impact on MMP architecture. I'd rather have
>> the simpler approach unless you really want the exact number of requestor lines
>> to be passed in platform_data+DT.
>
> The information that you have X lines on a platform needs to be described
> and queried. I see current approach error prone

Actually I have thought over your point, and you're quite right (this is your
case of more than 40 lines).

The exception I have found is :
 - a device driver is wrongly written
 - it requests the requestor line 0x1000 (below 0x8000)
 - pxa_dma computes the register in pxad_drcmr(0x1000)
   => this gives : base + 0x1000 + 4 * 0x1000 = base + 0x5000
   => this is a not existing iomapped register

So yes, I will respin the patchset, with :
 - one patch adding the number of requestors in mmp_dma.h
 - one patch adding the number of requestors in devicetree description
 - one patch adding the number of requestors in arch/arm/mach-pxa (my tree)
 - one patch adding the use of number of requestors in pxa_dma.c

Cheers.

-- 
Robert
