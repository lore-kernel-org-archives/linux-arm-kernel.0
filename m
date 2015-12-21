From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 21 Dec 2015 13:58:30 +0100
Subject: [PATCH] ARM64: Fix compiling with GCC 6 and Atomics enabled
In-Reply-To: <20151221125130.GO23092@arm.com>
References: <1450498655-3820-1-git-send-email-apinski@cavium.com>
 <20151221123843.GM23092@arm.com>
 <CAKv+Gu_aUvckKpwWw+Xo5VkFEA8-uT9xU0-m5NgAzAc1d53uhQ@mail.gmail.com>
 <20151221125130.GO23092@arm.com>
Message-ID: <CAKv+Gu99J8CXxqqtZqRa0Wzbf+-7=EDOnmYadLOj-rtVFPTScQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 December 2015 at 13:51, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Dec 21, 2015 at 01:46:22PM +0100, Ard Biesheuvel wrote:
>> On 21 December 2015 at 13:38, Will Deacon <will.deacon@arm.com> wrote:
>> > On Fri, Dec 18, 2015 at 08:17:35PM -0800, Andrew Pinski wrote:
>> >> The problem here is that GCC 6 and above emits .arch now
>> >> for each function so now the global .arch_extension has
>> >> no effect.  This fixes the problem by putting
>> >> .arch_extension inside ARM64_LSE_ATOMIC_INSN so
>> >> it is enabled for each place where LSE is used.
>> >
>> > Hmm, this is going to affect arch/arm/ much more heavily than arch/arm64.
>> > .arch_extension is used for virt, mp and sec over there, and it may be
>> > tricky to isolate the actual instruction usage (at least, virt looks
>> > lost in kvm/arm.c).
>> >
>> > Why can't gas have an option to accept all instruction encodings that it
>> > knows about, inspite of any .arch directives?
>> >
>>
>> Modern GAS supports things like -march=armv7-a+mp+sec+virt, so it
>> probably makes sense to pass that on the command line when building
>> for v7 (or +sec only for v6) if the assembler is found to support it
>> at build time.
>
> Does that override a more restrictive .arch directive emitted by the
> compiler?
>

It seems to be additive: -march=armv7-a+mp+sec allows a .S file
containing a virt arch_extension + both hvc and smc instructions to be
assembled.
