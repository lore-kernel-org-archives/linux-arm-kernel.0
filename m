From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 5 Feb 2016 10:05:57 +0100
Subject: [PATCH] ARM: remove duplicate definitions of __vectors_start and
 __stubs_start
In-Reply-To: <alpine.LFD.2.20.1602041148050.17825@knanqh.ubzr>
References: <1454574705-15109-1-git-send-email-ard.biesheuvel@linaro.org>
 <alpine.LFD.2.20.1602041148050.17825@knanqh.ubzr>
Message-ID: <CAKv+Gu9tbU2wuuxzA=Na1SGH-Au+_Fz+zfu0oTYhWWVsd6=qpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 February 2016 at 17:49, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Thu, 4 Feb 2016, Ard Biesheuvel wrote:
>
>> Commit b9b32bf70f2f ("ARM: use linker magic for vectors and vector stubs")
>> introduced new global definitions of __vectors_start and __stubs_start,
>> and changed the existing ones to have internal linkage only. However, these
>> symbols are still visible to kallsyms, and due to the way the .vectors and
>> .stubs sections are emitted at the base of the VMA space, these duplicate
>> definitions have conflicting values.
>>
>>   $ nm -n vmlinux |grep -E __vectors\|__stubs
>>   00000000 t __vectors_start
>>   00001000 t __stubs_start
>>   c0e77000 T __vectors_start
>>   c0e77020 T __stubs_start
>>
>> This is completely harmless by itself, since the wrong values are local
>> symbols that cannot be referenced by other object files directly. However,
>> since these symbols are also listed in the kallsyms symbol table in some
>> cases (i.e., CONFIG_KALLSYMS_ALL=y and CONFIG_XIP_KERNEL=y), having these
>> conflicting values can be confusing. So either remove them, or make them
>> strictly local.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Acked-by: Nicolas Pitre <nico@linaro.org>
>

Thanks. Submitted as  8514/1
