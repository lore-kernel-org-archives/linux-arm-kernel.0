From: jeyu@redhat.com (Jessica Yu)
Date: Mon, 16 Jan 2017 19:22:39 -0500
Subject: arm: Add livepatch arch specific code
In-Reply-To: <alpine.LSU.2.20.1701161733531.17768@pobox.suse.cz>
References: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
 <1481043967-15602-2-git-send-email-abelvesa@linux.com>
 <alpine.LSU.2.20.1701161733531.17768@pobox.suse.cz>
Message-ID: <20170117002239.GF9045@packer-debian-8-amd64.digitalocean.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+++ Miroslav Benes [16/01/17 17:47 +0100]:
>On Tue, 6 Dec 2016, Abel Vesa wrote:
>
>> klp_get_ftrace_location is used by ftrace to get the entry for a
>> specific function from the mcount list. klp_arch_set_pc is used
>> to set the pc from the regs passed as an argument to the
>> ftrace_ops_no_ops function to the starting address of the patched
>> function. klp_write_module_reloc is not doing anything at this
>> moment.
>>
>> Signed-off-by: Abel Vesa <abelvesa@linux.com>
>> ---
>>  MAINTAINERS                      |  3 +++
>>  arch/arm/include/asm/livepatch.h | 46 ++++++++++++++++++++++++++++++++++++++++
>>  arch/arm/kernel/livepatch.c      | 43 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 92 insertions(+)
>>  create mode 100644 arch/arm/include/asm/livepatch.h
>>  create mode 100644 arch/arm/kernel/livepatch.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index bd182a1..d43b790 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7466,12 +7466,15 @@ M:	Josh Poimboeuf <jpoimboe@redhat.com>
>>  M:	Jessica Yu <jeyu@redhat.com>
>>  M:	Jiri Kosina <jikos@kernel.org>
>>  M:	Miroslav Benes <mbenes@suse.cz>
>> +M:	Abel Vesa <abelvesa@linux.com>
>>  R:	Petr Mladek <pmladek@suse.com>
>>  S:	Maintained
>>  F:	kernel/livepatch/
>>  F:	include/linux/livepatch.h
>>  F:	arch/x86/include/asm/livepatch.h
>>  F:	arch/x86/kernel/livepatch.c
>> +F:	arch/arm/include/asm/livepatch.h
>> +F:	arch/arm/kernel/livepatch.c
>>  F:	Documentation/livepatch/
>>  F:	Documentation/ABI/testing/sysfs-kernel-livepatch
>>  F:	samples/livepatch/
>
>Thanks for the offer but I think we manage quite well ;)
>
>> diff --git a/arch/arm/include/asm/livepatch.h b/arch/arm/include/asm/livepatch.h
>> new file mode 100644
>> index 0000000..d4e3ff0
>> --- /dev/null
>> +++ b/arch/arm/include/asm/livepatch.h
>> @@ -0,0 +1,46 @@
>> +/*
>> + * livepatch.h - arm specific Kernel Live Patching Core
>> + *
>> + * Copyright (C) 2016 Abel Vesa <abelvesa@linux.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version 2
>> + * of the License, or (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef _ASM_ARM_LIVEPATCH_H
>> +#define _ASM_ARM_LIVEPATCH_H
>> +
>> +#include <asm/setup.h>
>> +#include <linux/module.h>
>> +#include <linux/ftrace.h>
>> +
>> +static inline int klp_check_compiler_support(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +int klp_write_module_reloc(struct module *mod, unsigned long type,
>> +			   unsigned long loc, unsigned long value);
>
>This is not needed. See below.
>
>> +
>> +static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
>> +{
>> +	regs->uregs[15] = ip;
>> +}
>> +
>> +#define klp_get_ftrace_location klp_get_ftrace_location
>> +static inline unsigned long klp_get_ftrace_location(unsigned long faddr)
>> +{
>> +	return ftrace_location_range(faddr, faddr + 24);
>
>Comment here about +24 would be great. See similar in powerpc header file.
>
>> +}
>> +
>> +#endif /* _ASM_ARM_LIVEPATCH_H */
>> diff --git a/arch/arm/kernel/livepatch.c b/arch/arm/kernel/livepatch.c
>> new file mode 100644
>> index 0000000..0656cd6
>> --- /dev/null
>> +++ b/arch/arm/kernel/livepatch.c
>> @@ -0,0 +1,43 @@
>> +/*
>> + * livepatch.c - arm specific Kernel Live Patching Core
>> + *
>> + * Copyright (C) 2016 Abel Vesa <abelvesa@linux.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version 2
>> + * of the License, or (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/ftrace.h>
>> +#include <asm/elf.h>
>> +#include <asm/livepatch.h>
>> +#include <asm/insn.h>
>> +#include <asm/ftrace.h>
>> +
>> +/**
>> + * klp_write_module_reloc() - write a relocation in a module
>> + * @mod:	module in which the section to be modified is found
>> + * @type:	ELF relocation type (see asm/elf.h)
>> + * @loc:	address that the relocation should be written to
>> + * @value:	relocation value (sym address + addend)
>> + *
>> + * This function writes a relocation to the specified location for
>> + * a particular module.
>> + */
>> +int klp_write_module_reloc(struct module *mod, unsigned long type,
>> +			   unsigned long loc, unsigned long value)
>> +{
>> +	/* Not implemented yet */
>> +	return 0;
>> +}
>
>This whole file is not needed. Livepatching uses kernel's internal
>apply_relocate_add() for dealing with relocations. The only thing you need
>to do is to make sure that all needed arch-specific info is preserved
>during a module loading. Specifically mod_arch_specific structure needs to
>be examined in this respect.

Yup. Since we rely on apply_relocate_add() to apply relocations, just
make sure that you preserve anything (e.g., plt tables) you need to
make that call post-module init. In the case of s390, we needed to
make sure we kept mod->arch.syminfo, so that the call to
apply_relocate_add() would succeed.

>But apply_relocate_add() is not implemented on arm yet. I guess it would
>nice to have it... otherwise we could get to an unpleasant situation.
>Livepatch module can rely on its livepatching relocations (that is, there
>are some). apply_relocate_add() returns 0 on arm, so everything seems to
>be nice and then boom some time later.

Doesn't it return -ENOEXEC? MODULES_USE_ELF_RELA is not defined
on arm, I think (see moduleloader.h).

>The question is what happens with normal modules. There are no SHT_RELA
>records probably.

For arm, I think there are only SHT_REL relocation sections
(MODULES_USE_ELF_REL is set instead of MODULES_USE_ELF_RELA), so
during apply_relocations() in load_module(), only apply_relocate()
should be called, and not apply_relocate_add().

Hm, I guess that means if we want livepatch support for the
architectures that don't support RELA relocations, we would have to
check if the section is SHT_REL or SHT_RELA before calling the right
apply_relocate* function.

Jessica
