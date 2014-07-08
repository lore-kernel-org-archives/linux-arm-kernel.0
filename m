From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 8 Jul 2014 11:27:06 +0200
Subject: [PATCH resend] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <20140708091513.GC8235@arm.com>
References: <1404297277-28295-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu9QuHcV4+8Sx--HEXOCfFDqZw0JWvJJjHYAHS6Y1xF9qg@mail.gmail.com>
 <20140708091513.GC8235@arm.com>
Message-ID: <CAKv+Gu_n7QV+_nUpeV8LH-i4eSGTHbaxU4OLwWuyaTHAGXqOjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 July 2014 11:15, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jul 08, 2014 at 09:55:53AM +0100, Ard Biesheuvel wrote:
>> On 2 July 2014 12:34, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> > From: Yi Li <yi.li@linaro.org>
>> >
>> > SMbios is important for server hardware vendors. It implements a spec for
>> > providing descriptive information about the platform. Things like serial
>> > numbers, physical layout of the ports, build configuration data, and the like.
>> >
>> > This has been tested by dmidecode and lshw tools.
>> >
>> > Signed-off-by: Yi Li <yi.li@linaro.org>
>> > [ardb: whitespace, commit log tweaks]
>> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> > ---
>> >
>> > Resending on behalf of Yi.
>> > Please consider for 3.17.
>> >
>>
>> Ping?
>
> Not sure what this does, but I can review it on a superficial level :)
>

Thanks.

>> > diff --git a/arch/arm64/include/asm/dmi.h b/arch/arm64/include/asm/dmi.h
>> > new file mode 100644
>> > index 000000000000..b8758f46fb42
>> > --- /dev/null
>> > +++ b/arch/arm64/include/asm/dmi.h
>> > @@ -0,0 +1,28 @@
>> > +/*
>> > + * arch/arm64/include/asm/dmi.h
>> > + *
>> > + * Copyright (C) 2013 Linaro Limited.
>> > + * Written by: Yi Li (yi.li at linaro.org)
>> > + *
>> > + * based on arch/ia64/include/asm/dmi.h
>> > + *
>> > + * This file is subject to the terms and conditions of the GNU General Public
>> > + * License.  See the file "COPYING" in the main directory of this archive
>> > + * for more details.
>> > + */
>> > +
>> > +
>> > +#ifndef _ASM_DMI_H
>> > +#define _ASM_DMI_H 1
>
> You don't need the 1 here (copied from ia64?). Also, please try to follow
> the existing style for arm64 and use __ASM_DMI_H.
>

Yes, copy/paste from ia64. Will fix it up.

>> > +#include <linux/slab.h>
>> > +#include <linux/efi.h>
>> > +
>> > +/* Use efi mappings for DMI */
>> > +#define dmi_early_remap(x, l)          efi_lookup_mapped_addr(x)
>
> Throwing away the length doesn't feel right, especially since the efi map
> *does* have a size field.
>

The thing to realize here is that, instead of doing actual ioremap()
or early_ioremap() calls, we just reuse an existing EFI mapping here.
(On x86, DMI/SMBIOS and EFI are not as tightly coupled, whereas on
arm64, the former implies the latter). So would you prefer some kind
of test against the size of the mapping before doing that?

>> > +#define dmi_early_unmap(x, l)
>> > +#define dmi_remap(x, l)                        efi_lookup_mapped_addr(x)
>
> How do we guarantee that we don't call these after efi_free_boot_services?
> (it would be good to enforce that somehow).
>

That is also an x86-ism, unfortunately. In our case,
efi_lookup_mapped_addr() can be called at any time. The comment next
to the definition of efi_lookup_mapped_addr() is in shared code, and
should probably be updated to reflect this.

>> > +#define dmi_unmap(x)
>> > +#define dmi_alloc(l)                   kzalloc(l, GFP_ATOMIC)
>
> Why does this have to be atomic?
>

Also copy/paste from ia64. GFP_KERNEL should be fine here

-- 
Ard.
