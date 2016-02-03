From: jaredeh@gmail.com (Jared Hulbert)
Date: Tue, 2 Feb 2016 19:06:06 -0800
Subject: [PATCH] ARM: vmlinux.lds: assert that ROM and RAM don't overlap
 when XIP_KERNEL=y
In-Reply-To: <20160203003158.GZ10826@n2100.arm.linux.org.uk>
References: <1454346154-12931-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160203003158.GZ10826@n2100.arm.linux.org.uk>
Message-ID: <CA+ZsKJ5hCSY39D5UBpie5u7XmrJfb0xXBA11hc3z2t8_niKw9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 2, 2016 at 4:31 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Feb 01, 2016 at 06:02:34PM +0100, Ard Biesheuvel wrote:
>> When building an XIP kernel, the linker produces two disjoint VMA regions,
>> where the first is mapped onto ROM and the second onto RAM. For this reason,
>> the linker output pointer '.' is updated halfway through the linker script,
>> and set to a value that corresponds with the start of the RAM region.
>>
>> However, in some cases, the ROM region exceeds the expected size, and the
>> assignment of the output pointer results in a decrement rather than an
>> increment, causing the virtual addresses of the .data region to clash with
>> the .text region. Such a kernel cannot boot normally, but it also confuses
>> the hell out of kallsyms, since .data symbols may appear inside the
>> [_stext, _etext] or [_sinittext, _einittext] intervals in the first pass,
>> but not in the second (or vice versa), resulting in inconsistent kallsyms
>> data.
>>
>> So let's make sure that the output pointer only advances, and never jumps
>> back into the ROM region.
>
> The long term goal is to move the XIP stuff out of this file, so
> I think it's better to avoid touching this until the split has
> happened.
>
> I'd _much_ rather see the split happen first, and then fixes
> applied, rather than trying to fix the existing unmaintainable
> mess.

Is that split being actively worked on?  If so by whom?
