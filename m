From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 15 Dec 2017 17:11:30 +0000
Subject: arm64: unhandled level 0 translation fault
In-Reply-To: <CAMuHMdWio0KnJc3DQeQyf-MHpDC=tc3cJLNK7MmaL=MdDz45UQ@mail.gmail.com>
References: <CAMuHMdXh_6FaV-SFGWxcBb1-NNGYngDrYnnWA=9Y6xmRAkcxqg@mail.gmail.com>
 <CAMuHMdWH=3kRmwjDHsTzUVmB7=s5cnY16Ujfroe_B6dawGSDfw@mail.gmail.com>
 <20171214152431.GC12608@e103592.cambridge.arm.com>
 <CAMuHMdXx-8+g5Xf0UtuYu71+K8Pz9CyQe=ifzzOWVRB1KpMGcg@mail.gmail.com>
 <20171215112343.GR22781@e103592.cambridge.arm.com>
 <CAMuHMdWio0KnJc3DQeQyf-MHpDC=tc3cJLNK7MmaL=MdDz45UQ@mail.gmail.com>
Message-ID: <20171215171129.GS22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 02:30:00PM +0100, Geert Uytterhoeven wrote:
> Hi Dave,
> 
> On Fri, Dec 15, 2017 at 12:23 PM, Dave Martin <Dave.Martin@arm.com> wrote:
> > On Thu, Dec 14, 2017 at 07:08:27PM +0100, Geert Uytterhoeven wrote:
> >> On Thu, Dec 14, 2017 at 4:24 PM, Dave P Martin <Dave.Martin@arm.com> wrote:

[...]

> >> > Good work on the bisect -- I'll need to have a think about this...
> >> >
> >> > That patch fixes a genuine problem so we can't just revert it.
> >> >
> >> > What if you revert _just this function_ back to what it was in v4.14?
> >>
> >> With fpsimd_update_current_state() reverted to v4.14, and
> >>
> >> -               __this_cpu_write(fpsimd_last_state, st);
> >> +               __this_cpu_write(fpsimd_last_state.st, st);
> >>
> >> to make it build, the problem seems to be fixed, too.
> 
> > Interesting if I apply that to v4.14 and then flatten the new code for CONFIG_ARM64_SVE=n, I get:
> >
> > Working:
> >
> > void fpsimd_update_current_state(struct fpsimd_state *state)
> > {
> >         local_bh_disable();
> >
> >         fpsimd_load_state(state);
> >         if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
> >                 struct fpsimd_state *st = &current->thread.fpsimd_state;
> >
> >                 __this_cpu_write(fpsimd_last_state.st, st);
> >                 st->cpu = smp_processor_id();
> >         }
> >
> >         local_bh_enable();
> > }
> >
> > Broken:
> >
> > void fpsimd_update_current_state(struct fpsimd_state *state)
> > {
> >         struct fpsimd_last_state_struct *last;
> >         struct fpsimd_state *st;
> >
> >         local_bh_disable();
> >
> >         current->thread.fpsimd_state = *state;
> >         fpsimd_load_state(&current->thread.fpsimd_state);
> >
> >         if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
> >                 last = this_cpu_ptr(&fpsimd_last_state);
> >                 st = &current->thread.fpsimd_state;
> >
> >                 last->st = st;
> >                 last->sve_in_use = test_thread_flag(TIF_SVE);
> >                 st->cpu = smp_processor_id();
> >         }
> >
> >         local_bh_enable();
> > }
> >
> > Can you try my flattened "broken" version by itself and see if that does
> > reproduce the bug?  If not, my flattening may be making bad assumptions...
> >
> > Assuming the "broken" version reproduces the bug, I can't yet see exactly
> > where the breakage comes from.
> 
> Correct, above "Working" is working, and "Broken" is broken.
> 
> > The two important differences here seem to be
> >
> > 1) Staging the state via current->thread.fpsimd_state instead of loading
> > directly:
> >
> > -       fpsimd_load_state(state);
> > +       current->thread.fpsimd_state = *state;
> > +       fpsimd_load_state(&current->thread.fpsimd_state);
> 
> The change above introduces the breakage.
> 
> > 2) Using this_cpu_ptr() + assignment instead of __this_cpu_write() when
> > reassociating the task's fpsimd context with the cpu:
> >
> >  {
> > +       struct fpsimd_last_state_struct *last;
> > +       struct fpsimd_state *st;
> >
> > [...]
> >
> >         if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
> > -               struct fpsimd_state *st = &current->thread.fpsimd_state;
> > -
> > -               __this_cpu_write(fpsimd_last_state.st, st);
> > -               st->cpu = smp_processor_id();
> > +               last = this_cpu_ptr(&fpsimd_last_state);
> > +               st = &current->thread.fpsimd_state;
> > +
> > +               last->st = st;
> > +               last->sve_in_use = test_thread_flag(TIF_SVE);
> > +               st->cpu = smp_processor_id();
> >         }
> 
> The change above is fine.

Thanks for this.

Will came up with a convincing hypothesis for how the dodgy change broke
things here -- see the diff in his separate reply.

I'll cook up a more complete fix, but the diff Will provided should at
least get things working.

Cheers
---Dave
