From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 10 Jul 2014 07:49:45 +0200
Subject: [PATCH resend] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <20140708093024.GE8235@arm.com>
References: <1404297277-28295-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu9QuHcV4+8Sx--HEXOCfFDqZw0JWvJJjHYAHS6Y1xF9qg@mail.gmail.com>
 <20140708091513.GC8235@arm.com>
 <CAKv+Gu_n7QV+_nUpeV8LH-i4eSGTHbaxU4OLwWuyaTHAGXqOjA@mail.gmail.com>
 <20140708093024.GE8235@arm.com>
Message-ID: <CAKv+Gu9ekidKA76HP5MS9MTDG3Dsz6Lxav1qz=sq7N1-V6pc7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 July 2014 11:30, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jul 08, 2014 at 10:27:06AM +0100, Ard Biesheuvel wrote:
>> On 8 July 2014 11:15, Will Deacon <will.deacon@arm.com> wrote:
>> > On Tue, Jul 08, 2014 at 09:55:53AM +0100, Ard Biesheuvel wrote:
>> >> > +#include <linux/slab.h>
>> >> > +#include <linux/efi.h>
>> >> > +
>> >> > +/* Use efi mappings for DMI */
>> >> > +#define dmi_early_remap(x, l)          efi_lookup_mapped_addr(x)
>> >
>> > Throwing away the length doesn't feel right, especially since the efi map
>> > *does* have a size field.
>> >
>>
>> The thing to realize here is that, instead of doing actual ioremap()
>> or early_ioremap() calls, we just reuse an existing EFI mapping here.
>> (On x86, DMI/SMBIOS and EFI are not as tightly coupled, whereas on
>> arm64, the former implies the latter). So would you prefer some kind
>> of test against the size of the mapping before doing that?
>
> Yeah, might not be a bad idea. Even if the thing happens to work by
> construction, we still have an API that takes a size, so checking it's what
> we have mapped sounds sensible.
>

So unless anyone objects, I am going to take a shortcut here and just
check whether

efi_lookup_mapped_addr(phys) + len -1 == efi_lookup_mapped_addr(phys + len -1)

This doesn't check whether there are holes in the mapping, but
anything more would imply creating a new function like
efi_lookup_mapped_addr() that does take a size and iterates over all
mappings in between.

-- 
Ard.
