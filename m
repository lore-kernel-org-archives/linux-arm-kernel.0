From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 17 Jul 2014 12:04:26 -0400
Subject: [PATCH 0/3] ARM: mvebu: disable I/O coherency on !SMP
In-Reply-To: <5105942.b7kcvNdlC8@wuerfel>
References: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <10673994.kkICTRHJxL@wuerfel> <20140717153401.GX21766@n2100.arm.linux.org.uk>
 <5105942.b7kcvNdlC8@wuerfel>
Message-ID: <53C7F40A.800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 July 2014 11:53 AM, Arnd Bergmann wrote:
> On Thursday 17 July 2014 16:34:01 Russell King - ARM Linux wrote:
>> On Thu, Jul 17, 2014 at 04:40:21PM +0200, Arnd Bergmann wrote:
>>> On Thursday 17 July 2014 15:27:20 Will Deacon wrote:
>>>> Just an FYI, but I've had to check internally to clarify the behaviour
>>>> around TLB conflict aborts. We're changing live page tables here, but the
>>>> *only* thing to differ is the output address, which I would hope is ok but
>>>> need to check to be sure.
>>>
>>> The two cases are slightly different:
>>>
>>> - The existing keystone code changes the output address but not the flags
>>> - The hypothetical mvebu code needs to change the flags but not the address.
>>
>> Don't base too much confidence in the keystone code:
> 
> What I meant was that verifying the correctness of one of the two above
> with the architecture team doesn't mean that the other one is okay too.
> 
>>         map_start = init_mm.start_code;
>>         map_end   = init_mm.brk;
>>
>>         phys = __pa(map_start) & PMD_MASK;
>>         do {
>> ...
>>                 phys += PMD_SIZE;
>>         } while (phys < map_end);
>>
>> Consider what happens when map_end is not PMD aligned - it misses the
>> PMD covering the end of the kernel BSS, which will be quite a common
>> case.  Obviously something that needs fixing...
> 
> Ouch.
> 
Thanks for spotting it RMK. Will have a loot at it.

regards,
Santosh
