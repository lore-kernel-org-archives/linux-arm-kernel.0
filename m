From: p.osciak@samsung.com (Pawel Osciak)
Date: Thu, 26 Aug 2010 10:38:16 +0900
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <20100825173125.0855a6b0@bike.lwn.net>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<1282310110.2605.976.camel@laptop>
	<20100825155814.25c783c7.akpm@linux-foundation.org>
	<20100825173125.0855a6b0@bike.lwn.net>
Message-ID: <4C75C588.7010707@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/2010 08:31 AM, Jonathan Corbet wrote:
> On Wed, 25 Aug 2010 15:58:14 -0700
> Andrew Morton<akpm@linux-foundation.org>  wrote:
>
>    
>>> If you want guarantees you can free stuff, why not add constraints to
>>> the page allocation type and only allow MIGRATE_MOVABLE pages inside a
>>> certain region, those pages are easily freed/moved aside to satisfy
>>> large contiguous allocations.
>>>        
>> That would be good.  Although I expect that the allocation would need
>> to be 100% rock-solid reliable, otherwise the end user has a
>> non-functioning device.  Could generic core VM provide the required level
>> of service?
>>      
> The original OLPC has a camera controller which requires three contiguous,
> image-sized buffers in memory.  That system is a little memory constrained
> (OK, it's desperately short of memory), so, in the past, the chances of
> being able to allocate those buffers anytime some kid decides to start
> taking pictures was poor.  Thus, cafe_ccic.c has an option to snag the
> memory at initialization time and never let go even if you threaten its
> family.  Hell hath no fury like a little kid whose new toy^W educational
> tool stops taking pictures.
>
> That, of course, is not a hugely efficient use of memory on a
> memory-constrained system.  If the VM could reliably satisfy those
> allocation requestss, life would be wonderful.  Seems difficult.  But it
> would be a nicer solution than CMA, which, to a great extent, is really
> just a standardized mechanism for grabbing memory and never letting go.
>    

The main problem is of course fragmentation, for this there is no 
solution in CMA. It has a feature intended to at least reduce memory 
usage though, if only a little bit. It is region sharing. It allows 
platform architects to define regions shared by more than one driver, as 
explained by Michal in the RFC. So we can at least try to reuse each 
chunk of memory as much as possible and not hold separate regions for 
each driver when they are not intended to work simultaneously. Not a 
silver bullet, but is there any though?

>> It would help (a lot) if we could get more attention and buyin and
>> fedback from the potential clients of this code.  rmk's feedback is
>> valuable.  Have we heard from the linux-media people?  What other
>> subsystems might use it?  ieee1394 perhaps?  Please help identify
>> specific subsystems and I can perhaps help to wake people up.
>>      
> If this code had been present when I did the Cafe driver, I would have used
> it.  I think it could be made useful to a number of low-end camera drivers
> if the videobuf layer were made to talk to it in a way which Just Works.
>    

I am working on new videobuf which will (hopefully) Just Work. CMA is 
intended to be pluggable into it, as should be any other allocator for 
that matter.

-- 

Best regards,
Pawel Osciak
Linux Platform Group
Samsung Poland R&D Center
