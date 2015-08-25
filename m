From: dianders@chromium.org (Doug Anderson)
Date: Tue, 25 Aug 2015 12:40:00 -0700
Subject: [PATCH] ARM: probes: Don't stop the machine if we're in the
 debugger
In-Reply-To: <CAGXu5j+oExmQPR9UuJy8oVaL_DzZ70kSP6ftS+ZhyFSs7hyxsA@mail.gmail.com>
References: <1440460739-19522-1-git-send-email-dianders@chromium.org>
 <55DBB48E.7040508@codeaurora.org>
 <CAGXu5j+oExmQPR9UuJy8oVaL_DzZ70kSP6ftS+ZhyFSs7hyxsA@mail.gmail.com>
Message-ID: <CAD=FV=Xe7hg7ifJ3JAO8StfugMYnojc3SNfsa=gLfWpm0n262A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kees,

On Tue, Aug 25, 2015 at 9:50 AM, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Aug 24, 2015 at 5:19 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> On 08/24/2015 04:58 PM, Douglas Anderson wrote:
>>>
>>> If we're in kgdb then the machine is already stopped.  Trying to stop
>>> it again will cause us to try to sleep, which is not allowed while in
>>> kgdb.  To avoid this problem, only stop the machine when we're not in
>>> kgdb.
>>>
>>> Reported-by: Aapo Vienamo <avienamo@nvidia.com>
>>> Suggested-by: Kees Cook <keescook@chromium.org>
>
> I actually suggested using in_atomic_preempt_off() which is I think a
> better catch-all. Could you use that instead, please?

I chose not to use that because (I think) in_atomic_preempt_off()
doesn't guarantee that stop_machine() is not needed.  Said another
way: if in_atomic_preempt_off() returns true then we can't sleep on
the current CPU.  ...but other CPUs may be running.  In this case
technically we need to call stop_machine(), but we'd need to do it in
a way that didn't require sleeping.

In the case of kgdb we know that the machine is stopped and we're
atomic too.  ...so we could certainly fix kgdb by checking for
"atomic", but that would mean there would be other places where we'd
get no warning and (I think) invalid behavior.

Stephen Boyd suggested that I just change this so that we expose a new
function and that makes everything a bit cleaner.  I'll try that.

-Doug
