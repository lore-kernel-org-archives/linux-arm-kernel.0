From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 9 Dec 2013 14:22:17 +0000
Subject: [PATCH] ARM : unwinder : Prevent data abort due to stack overflow
In-Reply-To: <CAPoNrtsHOXJMUsgUE_MET298n_H2sC2P+RbfUoG=kqK9chTTHw@mail.gmail.com>
References: <1386310193-6434-1-git-send-email-a.anurag@samsung.com>
 <20131206121149.GA4897@e103592.cambridge.arm.com>
 <CAPoNrtsHOXJMUsgUE_MET298n_H2sC2P+RbfUoG=kqK9chTTHw@mail.gmail.com>
Message-ID: <20131209142212.GA4281@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 07, 2013 at 01:43:21PM +0530, Anurag Aggarwal wrote:
> >>
> >> +     /* we are just starting, initialize last register set as 0 */
> >> +     ctrl.last_register_set = 0;
> >> +
> >>       while (ctrl.entries > 0) {
> >> -             int urc = unwind_exec_insn(&ctrl);
> >> +             int urc;
> >> +             if ((ctrl.sp_high - ctrl.vrs[SP]) < TOTAL_REGISTERS)
> >> +                     ctrl.last_register_set = 1;
> >
> >If this is done once per unwind_exec_insn(), I think it would be better
> >to put the check at the start of unwind_exec_insn() instead of outside.
> 
> I think it is better to do the above check here only because this check
> is strictly not a part of decoder and execution cycle.
> 
> I think uniwnd_exec_insn(), should only be used for decoding and
> execution of instruction, as you have suggested earlier. So, it makes
> sense to keep it in unwind_frame only().

It's debatable, since the stack checking is an intrinsic part of insn
execution.  But since there is only one call site for unwind_exec_insn
and it is unlikely than another will appear in the future, I am happy
for it to remain in your current form.

Cheers
---Dave
