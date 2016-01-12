From: labbott@redhat.com (Laura Abbott)
Date: Mon, 11 Jan 2016 16:47:27 -0800
Subject: [PATCHv2 0/2] Support for set_memory_* outside of module space
In-Reply-To: <20151125120511.GB27359@arm.com>
References: <1447207057-11323-1-git-send-email-labbott@fedoraproject.org>
 <5654F544.1060208@redhat.com> <20151125120511.GB27359@arm.com>
Message-ID: <56944D1F.6000404@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2015 04:05 AM, Will Deacon wrote:
> On Tue, Nov 24, 2015 at 03:39:48PM -0800, Laura Abbott wrote:
>> On 11/10/2015 05:57 PM, Laura Abbott wrote:
>>> Hi,
>>>
>>> This is v2 of the series to allow set_memory_* to work on kernel memory
>>> for security and other use cases. Should have addressed most comments
>>> although another look might be necessary for the contiguous bit.
>>>
>>> Thanks,
>>> Laura
>>>
>>> Laura Abbott (2):
>>>    arm64: Get existing page protections in split_pmd
>>>    arm64: Allow changing of attributes outside of modules
>>>
>>>   arch/arm64/Kconfig       |  12 ++++
>>>   arch/arm64/mm/mm.h       |   3 +
>>>   arch/arm64/mm/mmu.c      |  12 ++--
>>>   arch/arm64/mm/pageattr.c | 174 +++++++++++++++++++++++++++++++++++++++++------
>>>   4 files changed, 174 insertions(+), 27 deletions(-)
>>>
>>
>> Given what seems to have popped up via
>> https://lkml.kernel.org/r/<1448387338-27851-1-git-send-email-catalin.marinas@arm.com>
>> I'm going to hold off on this until the issues there are worked out.
>> Once that is fixed up this work can be picked up again.
>
> Thanks, Laura, and sorry for the disruption.
>
> Will
>

Closing the loop once more, it turns out that splitting the larger block sizes
is very difficult to do correctly. As of right now, the recommendation is to
either use vmalloc since that is mapped with pages or create a separate region
which can be placed in an appropriate section.

Theoretically, if something like DEBUG_PAGEALLOC were to be setup for arm64
set_memory_* could be used everywhere since that would have to force all
memory to be mapped with pages. DEBUG_PAGEALLOC should be fairly easy
to do on top of Mark Rutland's recent re-working of pagetable creation
and it's on my TODO list sometime.

I'll submit a patch allowing set_memory_* to use vmalloc and a comment
explaining why this is disallowed on most kernel memory.

Thanks,
Laura
