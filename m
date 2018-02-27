From: keescook@chromium.org (Kees Cook)
Date: Tue, 27 Feb 2018 07:46:15 -0800
Subject: [PATCH 2/2] lkdtm: fix irq handler entry for arm64
In-Reply-To: <20180227072011.GG6019@linaro.org>
References: <20180201093459.20477-1-takahiro.akashi@linaro.org>
 <20180201093459.20477-3-takahiro.akashi@linaro.org>
 <CAGXu5j+FZ4085UkjPQXnmTDhFMSdmZ7Rk5YXZ+p4OkyEfCOB1w@mail.gmail.com>
 <20180227072011.GG6019@linaro.org>
Message-ID: <CAGXu5jKbGw++rsn5PbxcVE2Z62tbOxtgCvMYK7RLxWhXG2Yj+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 11:20 PM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> Hi Kees,
>
> On Mon, Feb 26, 2018 at 07:57:10PM -0800, Kees Cook wrote:
>> On Thu, Feb 1, 2018 at 1:34 AM, AKASHI Takahiro
>> <takahiro.akashi@linaro.org> wrote:
>> > Arm64 doesn't have "do_IRQ" function, instead *handle_arch_irq, which is
>> > initialized by irq chip (gic), is called from exception entry.
>> > This patch fixes this problem.
>>
>> As in, this symbol is not known a lkdtm setup time? Hm, seems like
>> we'd want a more generalized approach here.
>
> Hmm. See my comments below.
>
>> >
>> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> > ---
>> >  drivers/misc/lkdtm_core.c | 20 ++++++++++++++++++--
>> >  1 file changed, 18 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/misc/lkdtm_core.c b/drivers/misc/lkdtm_core.c
>> > index ba92291508dc..e20343543053 100644
>> > --- a/drivers/misc/lkdtm_core.c
>> > +++ b/drivers/misc/lkdtm_core.c
>> > @@ -249,13 +249,29 @@ static int lkdtm_register_cpoint(struct crashpoint *crashpoint,
>> >         if (lkdtm_kprobe != NULL)
>> >                 unregister_kprobe(lkdtm_kprobe);
>> >
>> > +       if (IS_ENABLED(CONFIG_ARM64) &&
>> > +                       !strcmp(crashpoint->name, "INT_HARDWARE_ENTRY")) {
>> > +               extern void (*handle_arch_irq)(struct pt_regs *regs);
>>
>> I don't like this extern -- can handle_arch_irq be properly exported somewhere?
>
> Define a weak function, get_handle_irq(), in linux/irq.h and
> a real one in arch code. Then
>
>         if (!kallsyms_lookup_name(crashpoint->symbol_name)) {
>                 if (!strcmp(crashpoint->name, "INT_HARDWARE_ENTRY")) {
>                         func = get_handle_irq();
>                         if (func) {
>                                 crashpoint->kprobe.addr = func;
>                                 crashpoint->kprobe.symbol_name = NULL;
>                         } else {
>                                 /* error */
>                         }
>                 } /* anything else? */
>         }
>
> Do you like this code better?

Yeah, this is more generalized; thanks! If we end up with other
late-defined functions we can further generalize this, but this is
fine for our one case. :)

>
>>
>> > +               crashpoint->kprobe.addr = (kprobe_opcode_t *)*handle_arch_irq;
>>
>> I don't think the * is needed here: it's already a function pointer.
>
> Will check.
>
>> > +               /*
>> > +                * Instantiating kprobe.symbol_name here, say
>> > +                * with lookup_symbol_name(*handle_arch_irq),
>> > +                * would cause register_kprobe() to fail.
>> > +                */
>> > +               crashpoint->kprobe.symbol_name = NULL;
>>
>> Is kprobe.addr sufficient for register_kprobe?
>
> Yes as Masami explained.
> Leaving symbol_name ends up failure of register_kprobe().
>
>> > +       }
>> >         lkdtm_crashpoint = crashpoint;
>> >         lkdtm_crashtype = crashtype;
>> >         lkdtm_kprobe = &crashpoint->kprobe;
>> >         ret = register_kprobe(lkdtm_kprobe);
>> >         if (ret < 0) {
>> > -               pr_info("Couldn't register kprobe %s\n",
>> > -                       crashpoint->kprobe.symbol_name);
>> > +               if (IS_ENABLED(CONFIG_ARM64))
>> > +                       pr_info("Couldn't register kprobe 0x%lx\n",
>> > +                               (unsigned long)crashpoint->kprobe.addr);
>> > +               else
>> > +                       pr_info("Couldn't register kprobe %s\n",
>> > +                               crashpoint->kprobe.symbol_name);
>> >                 lkdtm_kprobe = NULL;
>> >                 lkdtm_crashpoint = NULL;
>> >                 lkdtm_crashtype = NULL;
>>
>> So I can replicate, how did you test this?
>
> All what I did in my arm64 test is
> # echo PANIC > /sys/kernel/debug/provoke-crash/INT_HARDWARE_ENTRY
>
> The probe point will hit sooner or later and we will see a panic
> (and kdump kicks in).

Great, thanks!

-Kees

-- 
Kees Cook
Pixel Security
