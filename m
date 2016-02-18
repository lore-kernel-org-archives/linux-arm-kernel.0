From: james.morse@arm.com (James Morse)
Date: Thu, 18 Feb 2016 12:00:00 +0000
Subject: [PATCH v5 15/15] arm64: hibernate: Prevent resume from a different
 kernel version
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE640286C4F3C@shsmsx102.ccr.corp.intel.com>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
 <1455637767-31561-16-git-send-email-james.morse@arm.com>
 <20160216201557.GA6526@amd>
 <36DF59CE26D8EE47B0655C516E9CE640286C4F3C@shsmsx102.ccr.corp.intel.com>
Message-ID: <56C5B240.40400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/02/16 02:20, Chen, Yu C wrote:
>> On Tue 2016-02-16 15:49:27, James Morse wrote:
>>> Resuming using a different kernel version is fragile, while there are
>>> sufficient details in the hibernate arch-header to perform the
>>> restore, changes in the boot process can have a long-lasting impact on the
>> system.
>>> In particular, if the EFI stub causes more memory to be allocated, the
>>> amount of memory left for linux is reduced. If we are lucky, this will
>>> cause restore to fail with the message:
>>
>> Well, this does not close the door completely. 4.6-rc0 is going to be very
>> different from 4.6-rc1. Better solution would be to increase version every
>> time EFI stub changes, or maybe record ammount of memory reserved for
>> EFI.

I hadn't even considered rcs. Maybe this should be changed to UTS_VERSION.
(There isn't enough space for the struct new_utsname)


> This reminds me a similar problem I once encountered on x86 : - )
> The efi memory layout should be strictly the same before/after hibernation, right?

The kernel hopes it is the same, as the page-tables it uses for runtime services
calls are restored along with the rest of memory, but there is the risk
that these don't match the EFI memory map any more.

Even if the amount of memory is the same, the layout might be different. (Core
hibernate code already has a counter of the number of physical pages.)

I'm still digging through the efi code (and spec), but it is fairly easy to
cause the memory map to change before entry to linux. This doesn't seem to be a
problem, as linux happily overwrites most of the allocated areas, so it may not
be as fragile as I thought.

I received the above 'memory size' error when rebasing between v4.4 and
v4.5-rc1, (Ard's KASLR patches may have been involved too).


Thanks,

James
