From: jeyu@kernel.org (Jessica Yu)
Date: Mon, 9 Jul 2018 20:34:09 +0200
Subject: [PATCH] ARM: module: fix modsign build error
In-Reply-To: <20180706130055.GY17271@n2100.armlinux.org.uk>
References: <20180706124900.3294525-1-arnd@arndb.de>
 <20180706130055.GY17271@n2100.armlinux.org.uk>
Message-ID: <20180709183409.34ir5xkulil7drn2@redbean>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+++ Russell King - ARM Linux [06/07/18 14:00 +0100]:
>On Fri, Jul 06, 2018 at 02:48:47PM +0200, Arnd Bergmann wrote:
>> The asm/module.h header file can not be included standalone, which
>> breaks the module signing code after a recent change:
>>
>> In file included from kernel/module-internal.h:13,
>>                  from kernel/module_signing.c:17:
>> arch/arm/include/asm/module.h:37:27: error: 'struct module' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>>  u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val);
>>
>> This adds a forward declaration of struct module to make it all work.
>>
>> Fixes: f314dfea16a0 ("modsign: log module name in the event of an error")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
>We used to have a general rule that where an asm/foo.h header and
>linux/foo.h header exists, and the linux/foo.h includes the asm/foo.h,
>then the linux/foo.h header will be used for including in .c files
>rather than the asm/ version of the same.  Is there a reason why
>that can't be done here?

Generally yes, it's just that in this case module_signing.c neither
needs nor includes linux/module.h. The needed load_info struct
definition just requires definitions for Elf_[SPE]hdr, Elf_Addr,
Elf_Sym, etc. and those are all defined in asm/module.h.

>That said, adding this is no bad thing.
>
>Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
>
>Thanks.

Thanks! Queued in modules-next.

Jessica
