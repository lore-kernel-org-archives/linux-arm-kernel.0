From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 30 Oct 2017 14:11:35 +0000
Subject: [PATCH v3] arm64: prevent regressions in compressed kernel image
 size when upgrading to binutils 2.27
In-Reply-To: <20171030140818.GN4404@arm.com>
References: <CAKv+Gu8wqH5fyievpcFi0P+JxEkA38cROzptN3zdCD0zCPcppg@mail.gmail.com>
 <20171027163341.57550-1-ndesaulniers@google.com>
 <20171030130834.GK4404@arm.com>
 <CAKv+Gu8dWLPDSbWXFFG2WVCXtxuG8VT-CyBHJG9=rt9SugpviQ@mail.gmail.com>
 <20171030131251.GM4404@arm.com>
 <CAKv+Gu8s7Q-xBWvTgpvQh4NpiW89=W+0meknVX+w3MaZvsyrrQ@mail.gmail.com>
 <20171030140818.GN4404@arm.com>
Message-ID: <CAKv+Gu8E3LOLLYWdaaJ9RDih5yQ7YURWW+33_1Eh5+7eS8P=7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 October 2017 at 14:08, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Oct 30, 2017 at 01:35:49PM +0000, Ard Biesheuvel wrote:
>> On 30 October 2017 at 13:12, Will Deacon <will.deacon@arm.com> wrote:
>> > On Mon, Oct 30, 2017 at 01:11:23PM +0000, Ard Biesheuvel wrote:
>> >> On 30 October 2017 at 13:08, Will Deacon <will.deacon@arm.com> wrote:
>> >> > On Fri, Oct 27, 2017 at 09:33:41AM -0700, Nick Desaulniers wrote:
>> >> >> Upon upgrading to binutils 2.27, we found that our lz4 and gzip
>> >> >> compressed kernel images were significantly larger, resulting is 10ms
>> >> >> boot time regressions.
>> >> >>
>> >> >> As noted by Rahul:
>> >> >> "aarch64 binaries uses RELA relocations, where each relocation entry
>> >> >> includes an addend value. This is similar to x86_64.  On x86_64, the
>> >> >> addend values are also stored at the relocation offset for relative
>> >> >> relocations. This is an optimization: in the case where code does not
>> >> >> need to be relocated, the loader can simply skip processing relative
>> >> >> relocations.  In binutils-2.25, both bfd and gold linkers did this for
>> >> >> x86_64, but only the gold linker did this for aarch64.  The kernel build
>> >> >> here is using the bfd linker, which stored zeroes at the relocation
>> >> >> offsets for relative relocations.  Since a set of zeroes compresses
>> >> >> better than a set of non-zero addend values, this behavior was resulting
>> >> >> in much better lz4 compression.
>> >> >>
>> >> >> The bfd linker in binutils-2.27 is now storing the actual addend values
>> >> >> at the relocation offsets. The behavior is now consistent with what it
>> >> >> does for x86_64 and what gold linker does for both architectures.  The
>> >> >> change happened in this upstream commit:
>> >> >> https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=1f56df9d0d5ad89806c24e71f296576d82344613
>> >> >> Since a bunch of zeroes got replaced by non-zero addend values, we see
>> >> >> the side effect of lz4 compressed image being a bit bigger.
>> >> >>
>> >> >> To get the old behavior from the bfd linker, "--no-apply-dynamic-relocs"
>> >> >> flag can be used:
>> >> >> $ LDFLAGS="--no-apply-dynamic-relocs" make
>> >> >> With this flag, the compressed image size is back to what it was with
>> >> >> binutils-2.25.
>> >> >>
>> >> >> If the kernel is using ASLR, there aren't additional runtime costs to
>> >> >> --no-apply-dynamic-relocs, as the relocations will need to be applied
>> >> >> again anyway after the kernel is relocated to a random address.
>> >> >>
>> >> >> If the kernel is not using ASLR, then presumably the current default
>> >> >> behavior of the linker is better. Since the static linker performed the
>> >> >> dynamic relocs, and the kernel is not moved to a different address at
>> >> >> load time, it can skip applying the relocations all over again."
>> >> >
>> >> > Do you have any numbers booting an uncompressed kernel Image without ASLR
>> >> > to see if skipping the relocs makes a measurable difference there?
>> >> >
>> >>
>> >> Do you mean built with ASLR support but executing at the offset it was
>> >> linked at?
>> >
>> > Yeah, sorry for being vague. Basically, the case where the relocs have all
>> > been resolved statically. In other words: what do we lose by disabling this
>> > optimisation?
>> >
>>
>> The code does not deal with that at all, currently: given that this is
>> new behavior in 2.27, the relocs are processed unconditionally,
>> regardless of whether the image is loaded at its default base or not.
>
> Ah yeah, of course. Doesn't that make it impossible to exploit this
> optimisation unless you can somehow guarantee that binutils has done
> the relocs at link time? I guess you could check for non-zero entries at
> the relocation offsets, but you still end up iterating.
>
> Anyway, I'll take the patch but I don't understand how the binutils change
> is intended to be used.
>

This seems to be a 'parity with x86 for the sake of it' thing. I see
how not having to process relocations can be an advantage in some
cases, but it does duplicate information (as this patch proves), and
the cat's already out of the bag anyway.
