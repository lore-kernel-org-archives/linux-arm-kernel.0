From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 02 Oct 2015 07:47:56 +0300
Subject: [RFC PATCH 06/20] coresight: etm3x: unlocking tracer in default
 arch init
In-Reply-To: <CANLsYkwO64CRfcZ+z+=+ucbtOVeOcOoCy+d0GO5sEuTf+Qe0WQ@mail.gmail.com>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
 <1442593594-10665-7-git-send-email-mathieu.poirier@linaro.org>
 <87eghgjg4v.fsf@ashishki-desk.ger.corp.intel.com>
 <CANLsYkwO64CRfcZ+z+=+ucbtOVeOcOoCy+d0GO5sEuTf+Qe0WQ@mail.gmail.com>
Message-ID: <87vbap3mgz.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> On 30 September 2015 at 05:33, Alexander Shishkin
> <alexander.shishkin@linux.intel.com> wrote:
>> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>>
>>> Calling function 'smp_call_function_single()' to unlock the
>>> tracer and calling it right after to perform the default
>>> initialisation doesn't make sense.
>>>
>>> Moving 'etm_os_unlock()' just before making the default
>>> initialisation results in the same outcome while saving
>>> one call to 'smp_call_function_single()'.
>>>
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> ---
>>>  drivers/hwtracing/coresight/coresight-etm3x.c | 8 +++++---
>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
>>> index c6880c1ade55..a4c158df0fef 100644
>>> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
>>> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
>>> @@ -1867,6 +1867,11 @@ static void etm_init_arch_data(void *info)
>>>        * certain registers might be ignored.
>>>        */
>>>       etm_clr_pwrdwn(drvdata);
>>> +
>>> +     /* Make sure all registers are accessible */
>>> +     etm_os_unlock(drvdata);
>>
>> In case of co-processor register access, this will end up unlocking the
>> local ETM instead of the one on target cpu, by the looks of it.
>
> "etm_init_arch_data()" is also called from "smp_function_calls()" and
> as such, will end up executing the correct CPU.

Yes, but it doesn't unlock the OSLAR register, which also needs to be
done on target cpu.

Regards,
--
Alex
