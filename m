From: keescook@chromium.org (Kees Cook)
Date: Tue, 24 Oct 2017 07:51:55 -0700
Subject: [PATCH] drivers/firmware: psci: Convert timers to use
 timer_setup()
In-Reply-To: <20171024135258.GA9612@red-moon>
References: <20171024101331.GA69243@beast> <20171024135258.GA9612@red-moon>
Message-ID: <CAGXu5jLuZM1b-g5=qEt7JR-Y7KyOkt1eXnh9RucSXcDfTS981w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 6:52 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> Hi Kees,
>
> On Tue, Oct 24, 2017 at 03:13:31AM -0700, Kees Cook wrote:
>> In preparation for unconditionally passing the struct timer_list pointer to
>> all timer callbacks, switch to using the new timer_setup() and from_timer()
>> to pass the timer pointer explicitly.
>
>> Also adds missing call to destroy_timer_on_stack().
>
> This patch should be split I think. I can send a patch to add
> the missing destroy_timer_on_stack() call (which may get in
> as a fix) and then we add a patch to update the timer setup
> API.

Okay, sure, should be fine to split this.

>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  drivers/firmware/psci_checker.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/firmware/psci_checker.c b/drivers/firmware/psci_checker.c
>> index 6523ce962865..f3f4f810e5df 100644
>> --- a/drivers/firmware/psci_checker.c
>> +++ b/drivers/firmware/psci_checker.c
>> @@ -220,7 +220,7 @@ static int hotplug_tests(void)
>>       return err;
>>  }
>>
>> -static void dummy_callback(unsigned long ignored) {}
>> +static void dummy_callback(struct timer_list *unused) {}
>>
>>  static int suspend_cpu(int index, bool broadcast)
>>  {
>> @@ -287,7 +287,7 @@ static int suspend_test_thread(void *arg)
>>       pr_info("CPU %d entering suspend cycles, states 1 through %d\n",
>>               cpu, drv->state_count - 1);
>>
>> -     setup_timer_on_stack(&wakeup_timer, dummy_callback, 0);
>> +     timer_setup_on_stack(&wakeup_timer, dummy_callback, 0);
>
> drivers/firmware/psci_checker.c: In function 'suspend_test_thread':
> drivers/firmware/psci_checker.c:290:2: error: implicit declaration of
> function 'timer_setup_on_stack' [-Werror=implicit-function-declaration]
>   timer_setup_on_stack(&wakeup_timer, dummy_callback, 0);
>     ^~~~~~~~~~~~~~~~~~~~
>
> On which tree this change is based on ?

Oh whoops, sorry, timer_setup() was in -rc3, but I see now that
timer_setup_on_stack() is only in -next. If you're okay with this
change, I can carry it in the timer tree for -next instead.

> I will send out the fix separately and CC you in.

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
