From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 03 Jul 2014 16:43:07 +0900
Subject: [PATCH] arm: ptrace: fix syscall modification under
 PTRACE_O_TRACESECCOMP
In-Reply-To: <20140624085405.GA26013@arm.com>
References: <20140618202748.GA9022@www.outflux.net>
 <20140620102258.GA26626@arm.com>
 <CAGXu5jKJ07bXw_K+7uSAf=H_SDoeoaWPxS4rwuonbR71Svwwmw@mail.gmail.com>
 <20140620172330.GA30656@arm.com>
 <CAGXu5jKg0didhwZTUq8AbMnwD=RV=EaWiZWBWuar625JXGnL6w@mail.gmail.com>
 <CAGXu5j+bk3g0Dude8jfKM3dXxX8LE_46CMmcBCGdVMNX_Hu-6w@mail.gmail.com>
 <20140623084608.GA9316@arm.com>
 <CAGXu5jLJRU21YoBXjXRpfHW1-jwy_PV0hpH_oUfew23xLF4gYg@mail.gmail.com>
 <20140624085405.GA26013@arm.com>
Message-ID: <53B5098B.9050801@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 06/24/2014 05:54 PM, Will Deacon wrote:
> On Mon, Jun 23, 2014 at 08:46:52PM +0100, Kees Cook wrote:
>> On Mon, Jun 23, 2014 at 1:46 AM, Will Deacon <will.deacon@arm.com> wrote:
>>> On Fri, Jun 20, 2014 at 07:10:46PM +0100, Kees Cook wrote:
>>>> On Fri, Jun 20, 2014 at 10:36 AM, Kees Cook <keescook@chromium.org> wrote:
>>>>> On Fri, Jun 20, 2014 at 10:23 AM, Will Deacon <will.deacon@arm.com> wrote:
>>>>>> Right, gotcha. Thanks for the explanation. I was confused, because
>>>>>> tracehook_report_syscall does the right thing (returns
>>>>>> current_thread_info()->syscall), but if we don't have TIF_SYSCALL_TRACE set,
>>>>>> then updates during the secure_computing callback will be ignored.re
>>>>>>
>>>>>> However, my fix to this is significantly smaller than your patch, so I fear
>>>>>> I'm still missing something.
>>>>>
>>>>> Oh, yes, that's much smaller. Nice! I will test this and report back.
>>>>
>>>> Yup, I can confirm this works. Thanks!
>>>>
>>>> Tested-by: Kees Cook <keescook@chromium.org>
>>>
>>> Thanks, Kees. I'll post a patch shortly. I'll try and remember to keep an
>>> eye out for this when seccomp lands for arm64 too.
>>
>> Great, thanks!
>>
>> What's the state of seccomp on arm64? I saw a series back in March,
>> but nothing since then? It looked complete, but I haven't set up a
>> test environment yet to verify.
>
> I think Akashi was going to repost `real soon now' so we can include them
> for 3.17. He missed the merge window last time around.

I took a quick look at the current implementation of ptrace.
ptrace(PTRACE_GETREGSET/SETREGSET), eventually gpr_get/set(), handles only 'struct user_pt_regs',
and we have no way to modify orig_x0 nor syscallno in 'struct pt_regs' directly.
So it seems to me that we can't change a system call by ptrace().
Do I misunderstand anything?

-Takahiro AKASHI


> Will
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
