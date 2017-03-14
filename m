From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 14 Mar 2017 13:32:40 -0600
Subject: [2/2] coresight: Fix reference count for software sources
In-Reply-To: <c6534dee-172b-24b0-0aee-84c9c8ccafaa@arm.com>
References: <1489073232-5093-3-git-send-email-suzuki.poulose@arm.com>
 <CANLsYkwg_PRcL5Sqd15phOFS-L8-v3SdvF1kBFa9De-==tx9gw@mail.gmail.com>
 <c6534dee-172b-24b0-0aee-84c9c8ccafaa@arm.com>
Message-ID: <CANLsYkxDhNLF1C6To72nt8ouZamrEHorDmuR_j_VfVTe6HToJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 March 2017 at 11:55, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 14/03/17 17:40, Mathieu Poirier wrote:
>>
>> On 14 March 2017 at 11:32, Mathieu Poirier <mathieu.poirier@linaro.org>
>> wrote:
>>>
>>> From: "Suzuki K. Poulose" <Suzuki.Poulose@arm.com>
>>>
>>> For software sources (i.e STM), there could be multiple agents
>>> generating the trace data, unlike the ETMs. So we need to
>>> properly do the accounting for the active number of users
>>> to disable the device when the last user goes away. Right
>>> now, the reference counting is broken for sources as we skip
>>> the actions when we detect that the source is enabled.
>>>
>>> This patch fixes the problem by adding the refcounting for
>>> software sources, even when they are enabled.
>>>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Reported-by: Robert Walker <robert.walker@arm.com>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>>  drivers/hwtracing/coresight/coresight.c | 13 +++++++++++--
>>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight.c
>>> b/drivers/hwtracing/coresight/coresight.c
>>> index 34cd1ed..2da9e39 100644
>>> --- a/drivers/hwtracing/coresight/coresight.c
>>> +++ b/drivers/hwtracing/coresight/coresight.c
>>> @@ -552,6 +552,7 @@ int coresight_enable(struct coresight_device *csdev)
>>>         int cpu, ret = 0;
>>>         struct coresight_device *sink;
>>>         struct list_head *path;
>>> +       enum coresight_dev_subtype_source subtype =
>>> csdev->subtype.source_subtype;
>>
>>
>> Checkpatch.pl complains about a line over 80 characters.
>
>
>
> Hmm, I think the name of the enum is unusually long. I could clean it up a
> little bit.
> Also, it does look silly to split a simple variable assignment though.
>
> What do you prefer ?

enum coresight_dev_subtype_source subtype;
...
...

subtype = csdev->subtype.source_subtype;

That is probably the easiest.


>
> Suzuki
