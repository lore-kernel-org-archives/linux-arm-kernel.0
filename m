From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 15 Dec 2017 11:23:46 +0000
Subject: arm64: unhandled level 0 translation fault
In-Reply-To: <CAMuHMdXx-8+g5Xf0UtuYu71+K8Pz9CyQe=ifzzOWVRB1KpMGcg@mail.gmail.com>
References: <CAMuHMdXh_6FaV-SFGWxcBb1-NNGYngDrYnnWA=9Y6xmRAkcxqg@mail.gmail.com>
 <CAMuHMdWH=3kRmwjDHsTzUVmB7=s5cnY16Ujfroe_B6dawGSDfw@mail.gmail.com>
 <20171214152431.GC12608@e103592.cambridge.arm.com>
 <CAMuHMdXx-8+g5Xf0UtuYu71+K8Pz9CyQe=ifzzOWVRB1KpMGcg@mail.gmail.com>
Message-ID: <20171215112343.GR22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 07:08:27PM +0100, Geert Uytterhoeven wrote:
> Hi Dave,
> 
> On Thu, Dec 14, 2017 at 4:24 PM, Dave P Martin <Dave.Martin@arm.com> wrote:
> > On Thu, Dec 14, 2017 at 02:34:50PM +0000, Geert Uytterhoeven wrote:
> >> On Tue, Dec 12, 2017 at 11:20 AM, Geert Uytterhoeven
> >> <geert@linux-m68k.org> wrote:
> >> > During userspace (Debian jessie NFS root) boot on arm64:
> >> >
> >> > rpcbind[1083]: unhandled level 0 translation fault (11) at 0x00000008,
> >> > esr 0x92000004, in dash[aaaaadf77000+1a000]
> >> > CPU: 0 PID: 1083 Comm: rpcbind Not tainted
> >> > 4.15.0-rc3-arm64-renesas-02176-g14f9a1826e48e355 #51
> >> > Hardware name: Renesas Salvator-X 2nd version board based on r8a7795 ES2.0+ (DT)
> >>
> >> This is a quad Cortex A57.
> >>
> >> > pstate: 80000000 (Nzcv daif -PAN -UAO)
> >> > pc : 0xaaaaadf8a51c
> >> > lr : 0xaaaaadf8ac08
> >> > sp : 0000ffffcffeac00
> >> > x29: 0000ffffcffeac00 x28: 0000aaaaadfa1000
> >> > x27: 0000ffffcffebf7c x26: 0000ffffcffead20
> >> > x25: 0000aaaacea1c5f0 x24: 0000000000000000
> >> > x23: 0000aaaaadfa1000 x22: 0000aaaaadfa1000
> >> > x21: 0000000000000000 x20: 0000000000000008
> >> > x19: 0000000000000000 x18: 0000ffffcffeb500
> >> > x17: 0000ffffa22babfc x16: 0000aaaaadfa1ae8
> >> > x15: 0000ffffa2363588 x14: ffffffffffffffff
> >> > x13: 0000000000000020 x12: 0000000000000010
> >> > x11: 0101010101010101 x10: 0000aaaaadfa1000
> >> > x9 : 00000000ffffff81 x8 : 0000aaaaadfa2000
> >> > x7 : 0000000000000000 x6 : 0000000000000000
> >> > x5 : 0000aaaaadfa2338 x4 : 0000aaaaadfa2000
> >> > x3 : 0000aaaaadfa2338 x2 : 0000000000000000
> >> > x1 : 0000aaaaadfa28b0 x0 : 0000aaaaadfa4c30
> >> >
> >> > Sometimes it happens with other processes, but the main address, esr, and
> >> > pstate values are always the same.
> >> >
> >> > I regularly run arm64/for-next/core (through bi-weekly renesas-drivers
> >> > releases, so the last time was two weeks ago), but never saw the issue
> >> > before until today, so probably v4.15-rc1 is OK.
> >> > Unfortunately it doesn't happen during every boot, which makes it
> >> > cumbersome to bisect.
> >> >
> >> > My first guess was UNMAP_KERNEL_AT_EL0, but even after disabling that,
> >> > and even without today's arm64/for-next/core merged in, I still managed to
> >> > reproduce the issue, so I believe it was introduced in v4.15-rc2 or
> >> > v4.15-rc3.
> >> >
> >> > Once, when the kernel message above wasn't shown, I got an error from
> >> > userspace, which may be related:
> >> > *** Error in `/bin/sh': free(): invalid pointer: 0x0000aaaadd970988 ***
> >>
> >> With more boots (10 instead of 6) to declare a kernel good, I bisected this
> >> to commit 9de52a755cfb6da5 ("arm64: fpsimd: Fix failure to restore FPSIMD
> >> state after signals").
> >>
> >> Reverting that commit on top of v4.15-rc3 fixed the issue for me.
> >
> > Good work on the bisect -- I'll need to have a think about this...
> >
> > That patch fixes a genuine problem so we can't just revert it.
> >
> > What if you revert _just this function_ back to what it was in v4.14?
> 
> With fpsimd_update_current_state() reverted to v4.14, and
> 
> -               __this_cpu_write(fpsimd_last_state, st);
> +               __this_cpu_write(fpsimd_last_state.st, st);
> 
> to make it build, the problem seems to be fixed, too.
> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert

Interesting if I apply that to v4.14 and then flatten the new code for CONFIG_ARM64_SVE=n, I get:

Working:

void fpsimd_update_current_state(struct fpsimd_state *state)
{
	local_bh_disable();

	fpsimd_load_state(state);
	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
		struct fpsimd_state *st = &current->thread.fpsimd_state;

		__this_cpu_write(fpsimd_last_state.st, st);
		st->cpu = smp_processor_id();
	}

	local_bh_enable();
}

Broken:

void fpsimd_update_current_state(struct fpsimd_state *state)
{
	struct fpsimd_last_state_struct *last;
	struct fpsimd_state *st;

	local_bh_disable();

	current->thread.fpsimd_state = *state;
	fpsimd_load_state(&current->thread.fpsimd_state);

	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
		last = this_cpu_ptr(&fpsimd_last_state);
		st = &current->thread.fpsimd_state;

		last->st = st;
		last->sve_in_use = test_thread_flag(TIF_SVE);
		st->cpu = smp_processor_id();
	}

	local_bh_enable();
}

Can you try my flattened "broken" version by itself and see if that does
reproduce the bug?  If not, my flattening may be making bad assumptions...


Assuming the "broken" version reproduces the bug, I can't yet see exactly
where the breakage comes from.

The two important differences here seem to be

1) Staging the state via current->thread.fpsimd_state instead of loading
directly:

-	fpsimd_load_state(state);
+	current->thread.fpsimd_state = *state;
+	fpsimd_load_state(&current->thread.fpsimd_state);

and

2) Using this_cpu_ptr() + assignment instead of __this_cpu_write() when
reassociating the task's fpsimd context with the cpu:

 {
+	struct fpsimd_last_state_struct *last;
+	struct fpsimd_state *st;

[...]

 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
-		struct fpsimd_state *st = &current->thread.fpsimd_state;
-
-		__this_cpu_write(fpsimd_last_state.st, st);
-		st->cpu = smp_processor_id();
+		last = this_cpu_ptr(&fpsimd_last_state);
+		st = &current->thread.fpsimd_state;
+
+		last->st = st;
+		last->sve_in_use = test_thread_flag(TIF_SVE);
+		st->cpu = smp_processor_id();
 	}


I can't see why either of these breaks anything yet.

Can you try them independently and see whether you can isolate the
breakage to one of them?

Cheers
---Dave
