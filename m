From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed, 27 Apr 2016 09:04:32 -0600
Subject: [PATCH] ARM: cpuidle: Pass on arm_cpuidle_suspend()'s return value
In-Reply-To: <20160427091434.GA4303@red-moon>
References: <1461669301-30834-1-git-send-email-james.morse@arm.com>
 <20160426113103.GB2204@red-moon>
 <CAJZ5v0h+P5baWVkTcbjxOjsXyp7aDy25+ik_9XHtUs6+jeN7Pw@mail.gmail.com>
 <20160427091434.GA4303@red-moon>
Message-ID: <20160427150432.GC1387@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27 2016 at 03:14 -0600, Lorenzo Pieralisi wrote:
>[+ Lina]
>
>On Tue, Apr 26, 2016 at 09:05:57PM +0200, Rafael J. Wysocki wrote:
>> On Tue, Apr 26, 2016 at 1:31 PM, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>> > On Tue, Apr 26, 2016 at 12:15:01PM +0100, James Morse wrote:
>> >> arm_cpuidle_suspend() may return -EOPNOTSUPP, or any value returned
>> >> by the cpu_ops/cpuidle_ops suspend call. arm_enter_idle_state() doesn't
>> >> update 'ret' with this value, meaning we always signal success to
>> >> cpuidle_enter_state(), causing it to update the usage counters as if we
>> >> succeeded.
>> >>
>> >> Fixes: 191de17aa3c1 ("ARM64: cpuidle: Replace cpu_suspend by the common ARM/ARM64 function")
>> >> Signed-off-by: James Morse <james.morse@arm.com>
>> >> ---
>> >>  drivers/cpuidle/cpuidle-arm.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> >
>> >>
>> >> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
>> >> index 545069d5fdfb..e342565e8715 100644
>> >> --- a/drivers/cpuidle/cpuidle-arm.c
>> >> +++ b/drivers/cpuidle/cpuidle-arm.c
>> >> @@ -50,7 +50,7 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
>> >>                * call the CPU ops suspend protocol with idle index as a
>> >>                * parameter.
>> >>                */
>> >> -             arm_cpuidle_suspend(idx);
>> >> +             ret = arm_cpuidle_suspend(idx);
>> >>
>> >>               cpu_pm_exit();
>> >>       }
>> >> --
>>
>> OK
>>
>> Should that go into -stable?
>
>Yes for arm64, but I would ask Daniel and Lina please to chime in if
>they see any issue with this change (in particular in relation to the
>Qualcomm back-end), it looks like it just slipped through the cracks
>but let's check with them before merging it and send it to stable
>kernels to prevent any issue.
>
This patch looks okay to me. In the QCOM backend driver, wee return -1
if the state was not achieved because of a pending interrupt. This was
previously ignored, but a quick check doesnt yield an issue returning
that backend specific value. Its not a real error per-se and therefore a
-1.

Thanks,
Lina
