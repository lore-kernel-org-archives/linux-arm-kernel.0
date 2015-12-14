From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 14 Dec 2015 16:26:48 +0000
Subject: [PATCH] arm64: Add missing linux/bug.h include in asm/pgtable.h
In-Reply-To: <20151214162242.GA27918@e104818-lin.cambridge.arm.com>
References: <1450109244-20122-1-git-send-email-julien.grall@citrix.com>
 <20151214162242.GA27918@e104818-lin.cambridge.arm.com>
Message-ID: <566EEDC8.1050501@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 14/12/15 16:22, Catalin Marinas wrote:
> On Mon, Dec 14, 2015 at 04:07:24PM +0000, Julien Grall wrote:
>> Linux 4.4-rc5 doesn't build for arm64 with CONFIG_XEN=y enabled:
>>
>> In file included from linux/arch/arm64/include/asm/pgtable.h:60:0,
>>                  from linux/arch/arm64/include/../../arm/include/asm/xen/page.h:5,
>>                  from linux/arch/arm64/include/asm/xen/page.h:1,
>>                  from linux/include/xen/page.h:28,
>>                  from linux/arch/arm64/xen/../../arm/xen/grant-table.c:33:
>> linux/arch/arm64/include/asm/pgtable.h: In function 'set_pte_at':
>> linux/include/linux/mmdebug.h:49:39: error: implicit declaration of function 'BUILD_BUG_ON_INVALID' [-Werror=implicit-function-declaration]
>>  #define VM_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
>>                                        ^
>> linux/arch/arm64/include/asm/pgtable.h:281:3: note: in expansion of macro 'VM_WARN_ONCE'
>>    VM_WARN_ONCE(!pte_young(pte),
>>    ^
>>
>> This has been introduced by commit 82d340081b6f71237373d1452e3573a5a122794c
>> "arm64: Improve error reporting on set_pte_at() checks". This is because
>> mmdebug.h relies on the includer to properly include the dependencies.
>>
>> Signed-off-by: Julien Grall <julien.grall@citrix.com>
>>
>> ---
>> Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>>
>>     I was tempted to add the missing include in linux/mmdebug.h but I'm
>>     not sure about the policy for headers inclusion in Linux.
> 
> Normally, I would say that mmdebug.h should include whichever headers it
> needs but for a quicker fix, I'm fine with including linux/bug.h (and
> probably removing the asm/bug.h include in asm/pgtable.h).

The linux/bug.h will only be included when __ASSEMBLY__ is not defined
which asm/bug.h is included even for assembly file.

Note that it's not possible to include linux/bug.h for assembly file
because the headers is not correctly protected.

As I don't know if asm/bug.h is useful in pgtable.h, I've decided to
keep it.

Regards,

-- 
Julien Grall
