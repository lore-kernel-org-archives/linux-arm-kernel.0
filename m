From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 5 Oct 2018 19:11:49 +0200
Subject: [RFC PATCH 1/9] kernel: add support for patchable function
 pointers
In-Reply-To: <CALCETrWaewXsdJsf3SocgZ0ggnvZk86L+5-LWPRbjdnG2mB7jw@mail.gmail.com>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org>
 <20181005141433.GS19272@hirez.programming.kicks-ass.net>
 <9E0E08C8-0DFC-4E50-A4FA-73208835EF9E@amacapital.net>
 <CAKv+Gu9z503ZJXcsG+9Ys240BZiB-+GB=kNY4VGWpjvdzN4JtA@mail.gmail.com>
 <CALCETrWaewXsdJsf3SocgZ0ggnvZk86L+5-LWPRbjdnG2mB7jw@mail.gmail.com>
Message-ID: <CAKv+Gu-oHBtgGbWXJu6+z4+BNhBZyY5VvF_v6cJJUGk_5YX1eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 October 2018 at 18:58, Andy Lutomirski <luto@kernel.org> wrote:
> On Fri, Oct 5, 2018 at 8:24 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>
>> On 5 October 2018 at 17:08, Andy Lutomirski <luto@amacapital.net> wrote:
>> >
>> >
>> >> On Oct 5, 2018, at 7:14 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> >>
>> >>> On Fri, Oct 05, 2018 at 10:13:25AM +0200, Ard Biesheuvel wrote:
>> >>> diff --git a/include/linux/ffp.h b/include/linux/ffp.h
>> >>> new file mode 100644
>> >>> index 000000000000..8fc3b4c9b38f
>> >>> --- /dev/null
>> >>> +++ b/include/linux/ffp.h
>> >>> @@ -0,0 +1,43 @@
>> >>> +/* SPDX-License-Identifier: GPL-2.0 */
>> >>> +
>> >>> +#ifndef __LINUX_FFP_H
>> >>> +#define __LINUX_FFP_H
>> >>> +
>> >>> +#include <linux/types.h>
>> >>> +#include <linux/compiler.h>
>> >>> +
>> >>> +#ifdef CONFIG_HAVE_ARCH_FFP
>> >>> +#include <asm/ffp.h>
>> >>> +#else
>> >>> +
>> >>> +struct ffp {
>> >>> +    void    (**fn)(void);
>> >>> +    void    (*default_fn)(void);
>> >>> +};
>> >>> +
>> >>> +#define DECLARE_FFP(_fn, _def)                        \
>> >>> +    extern typeof(_def) *_fn;                    \
>> >>> +    extern struct ffp const __ffp_ ## _fn
>> >>> +
>> >>> +#define DEFINE_FFP(_fn, _def)                        \
>> >>> +    typeof(_def) *_fn = &_def;                    \
>> >>> +    struct ffp const __ffp_ ## _fn                    \
>> >>> +        = { (void(**)(void))&_fn, (void(*)(void))&_def };    \
>> >>> +    EXPORT_SYMBOL(__ffp_ ## _fn)
>> >>> +
>> >>> +static inline void ffp_set_target(const struct ffp *m, void *new_fn)
>> >>> +{
>> >>> +    WRITE_ONCE(*m->fn, new_fn);
>> >>> +}
>> >>> +
>> >>> +static inline void ffp_reset_target(const struct ffp *m)
>> >>> +{
>> >>> +    WRITE_ONCE(*m->fn, m->default_fn);
>> >>> +}
>> >>> +
>> >>> +#endif
>> >>> +
>> >>> +#define SET_FFP(_fn, _new)    ffp_set_target(&__ffp_ ## _fn, _new)
>> >>> +#define RESET_FFP(_fn)        ffp_reset_target(&__ffp_ ## _fn)
>> >>> +
>> >>> +#endif
>> >>
>> >> I don't understand this interface. There is no wrapper for the call
>> >> site, so how are we going to patch all call-sites when you update the
>> >> target?
>> >
>> > I?m also confused.
>> >
>> > Anyway, we have patchable functions on x86. They?re called PVOPs, and they?re way overcomplicated.
>> >
>> > I?ve proposed a better way that should generate better code, be more portable, and be more maintainable.  It goes like this.
>> >
>> > To call the function, you literally just call  the default implementation.  It *might* be necessary to call a nonexistent wrapper to avoid annoying optimizations. At build time, the kernel is built with relocations, so the object files contain relocation entries for the call. We collect these entries into a table. If we?re using the ?nonexistent wrapper? approach, we can link in a .S or linker script to alias them to the default implementation.
>> >
>> > To patch them, we just patch them. It can?t necessarily be done concurrently because nothing forces the right alignment. But we can do it at boot time and module load time. (Maybe we can patch at runtime on architectures with appropriate instruction alignment.  Or we ask gcc for an extension to align calls to a function.)
>> >
>> > Most of the machinery already exists: this is roughly how the module loader resolves calls outside of a module.
>>
>> Yeah nothing is ever simple on x86 :-(
>>
>> So are you saying the approach i use in patch #2 (which would
>> translate to emitting a jmpq instruction pointing to the default
>> implementation, and patching it at runtime to point elsewhere) would
>> not fly on x86?
>
> After getting some more sleep, I'm obviously wrong.  The
> text_poke_bp() mechanism will work.  It's just really slow.
>

OK

> Let me try to summarize some of the issues.  First, when emitting
> jumps and calls from inline asm on x86, there are a few considerations
> that are annoying:
>
> 1. Following the x86_64 ABI calling conventions is basically
> impossible.  x86_64 requires a 128-byte redzone and 16-byte stack
> alignment.  After much discussion a while back, we decided that it was
> flat-out impossible on current gcc to get the stack pointer aligned in
> a known manner in an inline asm statement.  Instead, if we actually
> need alignment, we need to align manually.  Fortunately, the kernel is
> built with an override that forces only 8-byte alignment (on *most*
> GCC versions).  But for crypto in particular, it sucks extra, since
> the crypto code is basically the only thing in the kernel that
> actually wants 16-byte alignment.  I don't think this is a huge
> problem in practice, but it's annoying.  And the kernel is built
> without a redzone.
>
> 2. On x86_64, depending on config, we either need frame pointers or
> ORC.  ORC is no big deal -- it Just Works (tm).  Frame pointers need
> extra asm hackery.  It's doable, but it's still annoying.
>
> 3. Actually getting the asm constraints right to do what a C
> programmer expects is distinctly nontrivial.  I just fixed an
> extremely longstanding bug in the vDSO code in which the asm
> constraints for the syscall fallback were wrong in such a way that GCC
> didn't notice that the fallback wrote to its output parameter.
> Whoops.
>

OK, so the thing I am missing is why this all matters.

Note that the compiler should take care of all of this. It emits a
call a function with external linkage having prototype X, and all the
inline asm does is emit a jmp to some function having that same
prototype, either the default one or the one we patched in.

Apologies if I am missing something obvious here: as you know, x86 is
not my focus in general.

So in the arm64 case, we have

    " .globl " #_fn " \n" \
    #_fn " : \n" \
    " b " #_def " \n" \
    " nop \n" \
    " nop \n" \
    " nop \n" \
    " nop \n" \

and all the patching does is replace the target of that branch (the
NOPs are there for jumps that are more then 128 MB away, which require
a indirect jump on arm64)

> And having all this asm hackery per architecture is ugly and annoying.
>

True. But note that only the architectures that cannot tolerate the
default instantiation using function pointers will require a special
implementation.

> So my suggestion is to do it like a regular relocation.  Call a
> function the normal way (make it literally be a C function and call
> it), and rig up the noinline and noclone attributes and whatever else
> is needed to make sure that it's a *relocatable* call.  Then the
> toolchain emits ELF relocations saying exactly what part of the text
> needs patching, and we can patch it at runtime.  On x86, this is a bit
> extra annoying because we can't fully reliably parse backwards to find
> the beginning of the instruction, but objtool could doit.
>
> And then we get something that is mostly arch-neutral!  Because surely
> ARM can also use a relocation-based mechanism.
>

Not really. We don't have any build time tooling for this, and
CONFIG_RELOCATABLE only produces R_AARCH64_RELATIVE relocations for
absolute quantities.

So it would mean we'd have to start building vmlinux with
--emit-relocs, add tooling to parse all of that etc etc.

> I will generally object to x86 containing more than one
> inline-asm-hackery-based patchable call mechanism, which your series
> will add.  I would *love* to see a non-inline-asm one, and then we
> could move most of the x86 paravirt crap over to use it for a big win
> in readability and maintainability.
>

Fair enough.
