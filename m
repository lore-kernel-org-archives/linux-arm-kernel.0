From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 23 Sep 2015 07:13:08 -0700
Subject: [PATCH 1/2] arm64: fpsimd: Fix FPSIMD corruption in rt_sigreturn
 with CONFIG_PREEMPT
In-Reply-To: <20150923110509.GJ6281@e103592.cambridge.arm.com>
References: <1442316997-32282-1-git-send-email-will.deacon@arm.com>
 <CAKv+Gu8Yt0T6AF7MmOtpPpk8VcDBVraSNMbgm03dW5BR1QMqsA@mail.gmail.com>
 <20150915143952.GE31157@arm.com>
 <20150921153756.GM27273@e103592.cambridge.arm.com>
 <CAKv+Gu8H=0+1Q134cnrNHZF07zpJ2Qk=KNYaJuTHqo-d36fjKA@mail.gmail.com>
 <20150923110509.GJ6281@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu8AOEVwGOA3p0gZRC_14BO-5dRcuvH4KmpB8iY7oF9OVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 September 2015 at 04:05, Dave Martin <Dave.Martin@arm.com> wrote:
> On Tue, Sep 22, 2015 at 06:20:29PM -0700, Ard Biesheuvel wrote:
>> On 21 September 2015 at 08:37, Dave P Martin <Dave.Martin@arm.com> wrote:
>> > On Tue, Sep 15, 2015 at 03:39:53PM +0100, Will Deacon wrote:
>> >> On Tue, Sep 15, 2015 at 01:11:10PM +0100, Ard Biesheuvel wrote:
>
> [...]
>
>> >> > On 15 September 2015 at 13:36, Will Deacon <will.deacon@arm.com> wrote:
>> >> > > From: Dave P Martin <Dave.Martin@arm.com>
>> >> > >
>> >> > > The arm64 context switch implementation uses a flag
>> >> > > TIF_FOREIGN_FPSTATE to track whether the hardware FPSIMD regs are
>> >> > > out of sync with the logical state of current's registers.
>> >> > >
>> >> > > During sigreturn, the registers and task_struct are temporarily out
>> >> > > of sync, between writing the task_struct and loading its contents
>> >> > > back into the FPSIMD registers -- however, TIF_FOREIGN_FPSTATE is
>> >> > > not set.  This can cause the context switch code to discard some or
>> >> > > all of the restored FPSIMD state if preemption occurs during the
>> >> > > critical region of rt_sigreturn.
>
> [...]
>
>> >> > I am not following something here. If the task gets preempted before
>> >> > the call to fpsimd_update_current_state(), it will proceed to
>> >> > overwrite the registers with whatever is on the stack in fpsimd after
>> >> > being scheduled back in, and everything should work fine, right?.
>
> [...]
>
>> > Urg, looks like I confused myself here.  Ard's assessment looks correct.
>> >
>> > Not staging the data via the stack seemed a harmless change which I
>> > thought was an improvement, since at half a K the amount of data is non-
>> > trivial.
>> >
>> > I'll go back and make some measurements to see whether getting rid
>> > of the extra copy is really worth it.  I think reading straight into
>> > the task_struct with __get_user() can work, but it looks like I'll
>> > need to fiddle with the preemption region, or otherwise handle the
>> > ensuing race...
>> >
>>
>> Indeed. I think you will need something like fpsimd_load_state_user
>> which runs with preemption disabled and restarts if it is interrupted.
>
> Yep -- I'll take another look at it, and scratch my head some more.
>

Actually, I meant 'preemption enabled' (given the __user bit)
