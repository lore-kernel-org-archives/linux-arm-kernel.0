From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 29 Jul 2016 12:52:12 +0200
Subject: [PATCH] arm64: vmlinux.lds: make __rela_offset and
 __dynsym_offset ABSOLUTE
In-Reply-To: <20160729104947.GE16593@arm.com>
References: <1469715314-23260-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160729090634.GA16593@arm.com>
 <CAKv+Gu-c0sdAb2KgbOv6OwA+PmDJ1biaL592009LXgHgY34X+Q@mail.gmail.com>
 <CAKv+Gu-z7=McQqziGqztjhfhavB5qqBdbGmARA6z10q5h+QXdg@mail.gmail.com>
 <20160729104947.GE16593@arm.com>
Message-ID: <CAKv+Gu-bGGxQoNv3zZQYpPaN2idavFa7V+tkvgO-wfWkN-BKyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 July 2016 at 12:49, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Jul 29, 2016 at 12:46:49PM +0200, Ard Biesheuvel wrote:
>> On 29 July 2016 at 11:30, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> > On 29 July 2016 at 11:06, Will Deacon <will.deacon@arm.com> wrote:
>> >> Hi Ard,
>> >>
>> >> On Thu, Jul 28, 2016 at 04:15:14PM +0200, Ard Biesheuvel wrote:
>> >>> Due to the untyped KIMAGE_VADDR constant, the linker may not notice
>> >>> that the __rela_offset and __dynsym_offset expressions are absolute
>> >>> values (i.e., are not subject to relocation). This does not matter for
>> >>> KASLR, but it does confuse kallsyms in relative mode, since it uses
>> >>> the lowest non-absolute symbol address as the anchor point, and expects
>> >>> all other symbol addresses to be within 4 GB of it.
>> >>>
>> >>> Fix this by qualifying these expressions as ABSOLUTE() explicitly.
>> >>>
>> >>> Fixes: 0cd3defe0af4 ("arm64: kernel: perform relocation processing from ID map")
>> >>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >>> ---
>> >>>  arch/arm64/kernel/vmlinux.lds.S | 4 ++--
>> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> >>>
>> >>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> >>> index 89d6e177ecbd..d49492179967 100644
>> >>> --- a/arch/arm64/kernel/vmlinux.lds.S
>> >>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> >>> @@ -184,9 +184,9 @@ SECTIONS
>> >>>               *(.hash)
>> >>>       }
>> >>>
>> >>> -     __rela_offset   = ADDR(.rela) - KIMAGE_VADDR;
>> >>> +     __rela_offset   = ABSOLUTE(ADDR(.rela) - KIMAGE_VADDR);
>> >>>       __rela_size     = SIZEOF(.rela);
>> >>> -     __dynsym_offset = ADDR(.dynsym) - KIMAGE_VADDR;
>> >>> +     __dynsym_offset = ABSOLUTE(ADDR(.dynsym) - KIMAGE_VADDR);
>> >>
>> >> You removed the __dynsym_offset entry entirely in "arm64: relocatable:
>> >> suppress R_AARCH64_ABS64 relocations in vmlinux", so I'll drop this part
>> >> of the patch and assume you'll do a separate backport for stable. Ok?
>> >>
>> >
>> > If you are ok with fixing up patches manually while applying, could we
>> > just reorder them instead?
>>
>> Actually, this should go into v4.8-late not -stable
>
> Then the fixes tag is pretty confusing, since that's a commit from v4.7.
>

Sorry, my bad. I managed to confuse myself here.
The tag is accurate, I was wrong. This should go into v4.7 as well.

Note that the breakage I experienced was only with an LD built from
binutils-gdb HEAD (2.28), so I guess there is no urgency here.
