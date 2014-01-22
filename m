From: will.deacon@arm.com (Will Deacon)
Date: Wed, 22 Jan 2014 10:31:40 +0000
Subject: [PATCH v6 0/3] AArch64: KGDB support
In-Reply-To: <CALicx6tn4SJ4BjDGBNwH_8dGt82yHeAVyLzP+97rb8FDJdZSYQ@mail.gmail.com>
References: <1387453851-19341-1-git-send-email-vijay.kilari@gmail.com>
 <20140116134550.GA7496@arm.com>
 <CALicx6tQu2O8o4pr-N8Xc=D-Y9kOMsFNsn6BLVDqRo0Pbay00Q@mail.gmail.com>
 <20140120102302.GC16496@mudshark.cambridge.arm.com>
 <CALicx6v-pxOxdx4Q+a_Rx4XdHPXvgbVoYuouJoBxRdENMzCvAA@mail.gmail.com>
 <20140121183604.GQ30706@mudshark.cambridge.arm.com>
 <CALicx6tx9aLmXpai5SFzZeR6cfu7NKF7WipZWY1nrKGBcA-oGA@mail.gmail.com>
 <CALicx6tn4SJ4BjDGBNwH_8dGt82yHeAVyLzP+97rb8FDJdZSYQ@mail.gmail.com>
Message-ID: <20140122103140.GC1621@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 07:50:46AM +0000, Vijay Kilari wrote:
> On Wed, Jan 22, 2014 at 10:01 AM, Vijay Kilari <vijay.kilari@gmail.com> wrote:
> >>> On Mon, Jan 20, 2014 at 3:53 PM, Will Deacon <will.deacon@arm.com> wrote:
> >> That's a good point: I think we wait until our first exception before they
> >> are unmasked. Perhaps we should:
> >>
> >>  (1) Move local_dbg_{save,restore} from debug-monitors.h into irqflags.h
> 
> local_dbg_save is setting bit #8 it should be bit #9?
> 
> #define local_dbg_save(flags)
>          \
>         do {
>          \
>                 typecheck(unsigned long, flags);
>          \
>                 asm volatile(
>          \
>                 "mrs    %0, daif                        //
> local_dbg_save\n"    \
>                 "msr    daifset, #8"

That uses daifset, so #8 is bit 3 which is D.

> >>  (2) Add local_dbg_enable/local_dbg_disable macros
> >>  (3) Add a call to local_dbg_enable in the clear_os_lock function after the
> >>      isb().
> >>
> >> Does that work for you?
> >
> > Yes, only after first exception occurs the PSTATE.D is unmasked.
> >
> > I have patched (temp) as below and now KGDB boot tests pass
> >
> > diff --git a/arch/arm64/include/asm/debug-monitors.h
> > b/arch/arm64/include/asm/debug-monitors.h
> > index aff3a76..ea2bc46 100644
> > --- a/arch/arm64/include/asm/debug-monitors.h
> > +++ b/arch/arm64/include/asm/debug-monitors.h
> > @@ -64,6 +111,24 @@ struct task_struct;
> >
> >  #define DBG_ARCH_ID_RESERVED   0       /* In case of ptrace ABI updates. */
> >
> > +#define local_dbg_enable()
> >          \
> > +       do {
> >          \
> > +               asm volatile(
> >          \
> > +               "msr    daifclr, #9             //

I think this is going to unmask fiq as well...

Will
