From: labbott@redhat.com (Laura Abbott)
Date: Wed, 4 Nov 2015 10:51:55 -0800
Subject: [PATCH 0/2] Support for set_memory_* outside of module space
In-Reply-To: <CAGXu5j+cr9VizRHgatJURHpE3ZF-YaC0mvtzqfYnOc8TC55A_g@mail.gmail.com>
References: <1446587315-18145-1-git-send-email-labbott@fedoraproject.org>
 <CAGXu5j+cr9VizRHgatJURHpE3ZF-YaC0mvtzqfYnOc8TC55A_g@mail.gmail.com>
Message-ID: <563A53CB.8000103@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2015 03:42 PM, Kees Cook wrote:
> On Tue, Nov 3, 2015 at 1:48 PM, Laura Abbott <labbott@fedoraproject.org> wrote:
>>
>> Hi,
>>
>> Based on a recent discussion[1] there is interest in having set_memory_* work
>> on kernel memory for security and other use cases. This patch adds the
>> ability for that to happen behind a kernel option. If this is welcome enough,
>> the Kconfig can be dropped. This has been briefly tested but not stress tested.
>>
>> Thanks,
>> Laura
>>
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/382079.html
>>
>> Laura Abbott (2):
>>    arm64: Get existing page protections in split_pmd
>>    arm64: Allow changing of attributes outside of modules
>>
>>   arch/arm64/Kconfig.debug | 11 +++++++
>>   arch/arm64/mm/mm.h       |  3 ++
>>   arch/arm64/mm/mmu.c      | 11 ++++---
>>   arch/arm64/mm/pageattr.c | 74 ++++++++++++++++++++++++++++++++++++++++++++----
>>   4 files changed, 88 insertions(+), 11 deletions(-)
>
> This seems like the right thing to have. What's arm64 doing for the
> equivalent of x86 and arm's set_kernel_text_* functions? x86 and arm
> call their set_memory_* functions, for example. A quick examination
> shows mm/mmu.c is just doing it "by hand" in fixup_executable and
> mark_rodata_ro? Could those functions use the new set_memory_* ones?
>

It looks like mark_rodata_ro could probably use the set_memory_ro. I'll
have to test it out. Longer term, the page table setup code should
probably just be pulled out into a common file.

Do you know the code path in ftrace which would trigger the set_kernel_text_*
If not, I'll go  see if I can figure out if it's implemented yet on arm64.

> -Kees
>

Thanks,
Laura
