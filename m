From: jld@mozilla.com (Jed Davis)
Date: Fri, 19 Jul 2013 21:46:55 -0700
Subject: [PATCH] ARM: Fix r7/r11 confusion when CONFIG_THUMB2_KERNEL=y
In-Reply-To: <20130715135420.GG10000@mudshark.cambridge.arm.com>
References: <1373685501-1620-1-git-send-email-jld@mozilla.com>
 <20130715135420.GG10000@mudshark.cambridge.arm.com>
Message-ID: <20130720044655.GC9433@mozilla.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 02:54:20PM +0100, Will Deacon wrote:
> On Sat, Jul 13, 2013 at 04:18:20AM +0100, Jed Davis wrote:
[...]
> > Effects of this are probably limited to failure of EHABI unwinding when
> > starting from a function that uses r7 to restore its stack pointer, but
> > the possibility for further breakage (which would be invisible on
> > non-Thumb kernels) is worrying.
[...]
> I'm struggling to understand exactly the problem that this patch is trying
> to address. If it's just a code consistency issue, I don't think it's worth
> it (I actually find it less confusing the way we currently have things) but
> if there is a real bug, perhaps you could provide a testcase?

There is a real bug here, but my commit message wasn't very clear.  This
was breaking PERF_COUNT_SW_CONTEXT_SWITCHES with CONFIG_THUMB2_KERNEL=y
(with my other recently posted patch applied), because kernel/sched.c is
built with -fno-omit-frame-pointer (which is wrong, but that's a problem
for another patch) and so __schedule's EHABI entry uses 0x97 (mov sp, r7),
and somewhere along the line the unwinder gets the r11 value instead.
This would also apply to any function with a variable-length array, but
__schedule happens to have the perf hook I was trying to use.

I should add that this bug doesn't affect me directly at the moment,
because we're not currently using CONFIG_THUMB2_KERNEL on Firefox OS,
because our kernels are assorted older versions with hardware vendors'
changes and there are some issues with it.  But I felt it was worth
tracking this down before trying to send changes upstream.

The "right" thing to do here might be to just include all the registers,
or at least {r4-pc}, in struct stackframe.  The parts that aren't {fp,
sp, lr, pc} could be ifdef'ed if we're concerned enough about the
overhead in kernels using APCS frame pointer unwinding.

I agree that a test case would be good -- I'm more than a little worried
of regressions without one -- but I could use some advice on how best to
do that.

--Jed
