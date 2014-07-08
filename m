From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 8 Jul 2014 22:59:04 +0200
Subject: [RFC PATCH 2/3] arm64: add C struct definition for Image header
In-Reply-To: <1404848794.26155.31.camel@smoke>
References: <1404823803-7317-1-git-send-email-ard.biesheuvel@linaro.org>
 <1404823803-7317-2-git-send-email-ard.biesheuvel@linaro.org>
 <1404848794.26155.31.camel@smoke>
Message-ID: <CAKv+Gu8Qa86N7OSWXTp7XjJvPVa6_rKE_mnMBLJKWjoaabeH+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 July 2014 21:46, Geoff Levand <geoff@infradead.org> wrote:
> Hi Ard,
>
> On Tue, 2014-07-08 at 14:50 +0200, Ard Biesheuvel wrote:
>> In order to be able to interpret the Image header from C code, we need a
>> struct definition that reflects the specification for Image headers as laid
>> out in Documentation/arm64/booting.txt.
>
> I think the duplication of the structure definition in booting.txt
> and in image_hdr.h will not be maintained, so I recommend we remove
> the definition in booting.txt and replace it with something like:
>
> -The decompressed kernel image contains a 64-byte header as follows:
> ...
> +The decompressed kernel image contains a 64-byte header as described in
> +arch/arm64/include/asm/image_hdr.h.
>
>

I see what you mean, but I will let the maintainers decide on that one.

>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/include/asm/image_hdr.h | 53 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>  create mode 100644 arch/arm64/include/asm/image_hdr.h
>>
>> diff --git a/arch/arm64/include/asm/image_hdr.h b/arch/arm64/include/asm/image_hdr.h
>> new file mode 100644
>> index 000000000000..16d32600fb18
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/image_hdr.h
>> @@ -0,0 +1,53 @@
>> +/*
>> + * image_hdr.h - C struct definition of the Image header format
>> + *
>> + * Copyright (C) 2014 Linaro Ltd  <ard.biesheuvel@linaro.org>
>
> Are you really a copyright holder of this code?
>

I am the author of this file. Will is the author of booting.txt. I am
not a lawyer so whether that makes Linaro a copyright holder, I am not
sure ...
But as I understand it, someone needs to claim copyright in order for
others to be bound to the license.

>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef __ASM_IMAGE_HDR_H
>> +#define __ASM_IMAGE_HDR_H
>> +
>> +#include <linux/bug.h>
>> +#include <linux/byteorder/generic.h>
>> +#include <linux/types.h>
>> +
>> +/*
>> + * As defined in Documentation/arm64/booting.txt
>> + */
>> +#define IMAGE_HDR_SIZE               64
>
> I can't see any use for this IMAGE_HDR_SIZE.  We have the
> structure def, so use sizeof.
>

I am using it in the BUILD_BUG_ON() below. Do you think that is overkill?

>
> Please add a comment here to document this structure and the
> members, not in the structure itself.  Something like:
>
> +/**
> + * struct arm64_image_header - arm64 kernel image header.
> + *
> + * @code0: ...
>

Is this coding style documented somewhere? Documentation/CodingStyle
does not seem to cover it ...

>> +
>> +struct image_hdr {
>
> Since this is a global def, and possibly exported to user space,
> I think arm64_image_hdr would be more appropriate.
>

Agreed.

>> +     u32     code0;          /* Executable code */
>> +     u32     code1;          /* Executable code */
>> +     __le64  text_offset;    /* Image load offset */
>> +     u64     res0;           /* Reserved, must be 0 */
>> +     u64     res1;           /* Reserved, must be 0 */
>> +     u64     res2;           /* Reserved, must be 0 */
>> +     u64     res3;           /* Reserved, must be 0 */
>> +     u64     res4;           /* Reserved, must be 0 */
>> +     __le32  magic;          /* Magic number, little endian, "ARM\x64" */
>> +     __le32  pehdr_offset;   /* PE header offset, only used by EFI */
>> +};
>
> These are kernel types.  If we used standard C types then this header
> could also be exported for user space programs, so replace u32 with
> uint32_t, etc.  We can use helper routines to like image_hdr_text_offset()
> to wrap the little endian members.
>

I see how that would be useful.

> To export it we would need to add this to arch/arm64/include/asm/Kbuild:
>
> +header-y += image_hrd.h
>
>> +
>> +/*
>> + * bool image_hdr_check() - checks the Image header for inconsistencies.
>> + */
>> +static inline bool image_hdr_check(struct image_hdr const *hdr)
>
>> +{
>> +     BUILD_BUG_ON(sizeof(struct image_hdr) != IMAGE_HDR_SIZE);
>> +
>> +     if (hdr->res0 | hdr->res1 | hdr->res2 | hdr->res3 | hdr->res4)
>> +             return false;
>
> I don't think we should check these reserved members, as it will limit
> forward compatibility of this routine.  The magic check should be a
> sufficient check.  If it is not, then we need a better magic value.
>

If exporting to user space, I agree.

>> +     return hdr->magic == cpu_to_le32(0x644d5241);
>> +}

Perhaps I should use a define here ...

>> +
>> +static inline u64 image_hdr_text_offset(struct image_hdr const *hdr)
>> +{
>> +     return le64_to_cpu(hdr->text_offset);
>> +}
>

Thanks Geoff.

-- 
Ard.
