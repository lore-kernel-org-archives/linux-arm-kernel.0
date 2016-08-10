From: keescook@chromium.org (Kees Cook)
Date: Wed, 10 Aug 2016 11:38:57 -0700
Subject: [PATCH 0/3] arm64: put objects into proper sections
In-Reply-To: <20160810180532.30156168@xhacker>
References: <1470813559-2917-1-git-send-email-jszhang@marvell.com>
 <20160810180532.30156168@xhacker>
Message-ID: <CAGXu5jJQEyyQaM+0XddfXNGipOhkPQOXuKnDo6=k0qr+jhg2kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 3:05 AM, Jisheng Zhang <jszhang@marvell.com> wrote:
> + Kees,
>
> On Wed, 10 Aug 2016 15:19:16 +0800 Jisheng Zhang wrote:
>
>> This series tries to put objects into proper sections to avoid
>> pontential unnecessary DDR traffics:
>>
>> patch1 puts alloc_vectors_page() into .init section. This is a clean up
>> patch.
>>
>> patch2 puts vdso_pages, vdso_spec and vectors_page into read_mostly
>> section, since they are read mostly in hot path.
>>
>> patch3 puts cpu_ops into read_mostly section, since it's read mostly
>> int hot path such as arm_cpuidle_suspend().
>
> Is it better to mark them as __ro_after_init, suggestions are appreciated.

If something is actually never updated after __init, yes, please use
__ro_after_init.

-Kees

>
> Thanks,
> Jisheng
>
>>
>>
>> Before this series:
>>
>> ffff000008d660f0 b undef_lock
>> ffff000008d660f8 b vectors_page
>> ffff000008d66100 b vdso_pages
>> ffff000008d66108 b vdso_spec
>> ffff000008d66148 B cpu_ops
>> ffff000008d66348 b patch_lock
>>
>> After this series:
>>
>> ffff000008ca5b08 D static_key_initialized
>> ffff000008ca5b10 d vectors_page
>> ffff000008ca5b18 d vdso_pages
>> ffff000008ca5b20 d vdso_spec
>> ffff000008ca5b60 D cpu_ops
>> ffff000008ca5d60 D elf_hwcap
>> ffff000008ca5d68 D compat_elf_hwcap
>> ffff000008ca5d6c D compat_elf_hwcap2
>>
>> Although there's no obvious issue with current code, because undef_lock and
>> patch_lock is rarely used, but the situation may change in the future, so
>> let's move them into proper sections now.
>>
>> Jisheng Zhang (3):
>>   arm64: vdso: add __init section marker to alloc_vectors_page
>>   arm64: vdso: put read only/mostly objects into proper sections
>>   arm64: kernel: declare cpu_ops __read_mostly
>>
>>  arch/arm64/kernel/cpu_ops.c |  2 +-
>>  arch/arm64/kernel/vdso.c    | 31 +++++++++++++++----------------
>>  2 files changed, 16 insertions(+), 17 deletions(-)
>>
>



-- 
Kees Cook
Nexus Security
