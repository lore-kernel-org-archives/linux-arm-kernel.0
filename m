From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 15 Mar 2017 16:00:32 +0000
Subject: [2/2] coresight: Fix reference count for software sources
In-Reply-To: <CAG2=9p_+2jv8xxUex=mvNXJswk+cx-kXGRcTbCd9i5-vOf6X4A@mail.gmail.com>
References: <1489073232-5093-3-git-send-email-suzuki.poulose@arm.com>
 <CANLsYkwg_PRcL5Sqd15phOFS-L8-v3SdvF1kBFa9De-==tx9gw@mail.gmail.com>
 <ddf386ee-0be5-b1ca-174c-89d9e48ba282@arm.com>
 <CAG2=9p_+2jv8xxUex=mvNXJswk+cx-kXGRcTbCd9i5-vOf6X4A@mail.gmail.com>
Message-ID: <33ea0fe9-e93b-0cd0-9950-8443aceafc5b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/03/17 03:51, Chunyan Zhang wrote:
> Hi Suzuki,
>
> On 15 March 2017 at 02:06, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>> On 14/03/17 17:40, Mathieu Poirier wrote:
>>>
>>> On 14 March 2017 at 11:32, Mathieu Poirier <mathieu.poirier@linaro.org>
>>> wrote:
>>>>
>>>> From: "Suzuki K. Poulose" <Suzuki.Poulose@arm.com>
>>>>
>>>> For software sources (i.e STM), there could be multiple agents
>>>> generating the trace data, unlike the ETMs. So we need to
>>>> properly do the accounting for the active number of users
>>>> to disable the device when the last user goes away. Right
>>>> now, the reference counting is broken for sources as we skip
>>>> the actions when we detect that the source is enabled.
>>>>
>>>> This patch fixes the problem by adding the refcounting for
>>>> software sources, even when they are enabled.
>>>>
>>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>> Reported-by: Robert Walker <robert.walker@arm.com>
>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> ---
>>>>  drivers/hwtracing/coresight/coresight.c | 13 +++++++++++--
>>>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight.c
>>>> b/drivers/hwtracing/coresight/coresight.c
>>>> index 34cd1ed..2da9e39 100644
>>>> --- a/drivers/hwtracing/coresight/coresight.c
>>>> +++ b/drivers/hwtracing/coresight/coresight.c
>>>> @@ -552,6 +552,7 @@ int coresight_enable(struct coresight_device *csdev)
>>>>         int cpu, ret = 0;
>>>>         struct coresight_device *sink;
>>>>         struct list_head *path;
>>>> +       enum coresight_dev_subtype_source subtype =
>>>> csdev->subtype.source_subtype;
>>>
>>>
>>> Checkpatch.pl complains about a line over 80 characters.
>>>
>>>>
>>>>         mutex_lock(&coresight_mutex);
>>>>
>>>> @@ -559,8 +560,16 @@ int coresight_enable(struct coresight_device *csdev)
>>>>         if (ret)
>>>>                 goto out;
>>>>
>>>> -       if (csdev->enable)
>>>> +       if (csdev->enable) {
>>>> +               /*
>>>> +                * There could be multiple applications driving the
>>>> software
>>>> +                * source. So keep the refcount for each such user when
>>>> the
>>>> +                * source is already enabled.
>>>> +                */
>>>> +               if (subtype == CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE)
>>>> +                       atomic_inc(csdev->refcnt);
>>>>                 goto out;
>>>> +       }
>>>>
>>
>> Btw, should we allow the user to turn on the STM from sysfs (echo 1 >
>> $STM/enable_source) ?
>
> If enabling STM can not be allowed via sysfs, how should we allow
> users to turn on STM when they want to mmap STM to user space, and
> write STM device from user space directly? For example this kind of
> use case [1].

The ioct(, STP_POLICY_ID_SET) indirectly turns on the STM hardware via :
stm_char_policy_set_ioctl()->stm.link (stm_generic_link)-> coresight_enable().


>
>> All STM users should set their policy via ioctls and that in turn turns the
>> device on.
>
> Yes users can set policy via ioctls to request resource of STM (i.e.
> which STM channel(s) will be written), but they still need to use
> sysfs to enable STM.

As mentioned above, it is not necessary.

>
>> So it doesn't make sense for enable_source to really enable
>> the hardware unless someone really opens it.
>
> Right, there're two ways to enable STM currently, e.g.
> 1) echo <addr>.stm  > /sys/class/stm_source/stm_ftrace/stm_source_link

I am not familiar with the stm_source class. From a quick glance, it looks like,
writing to stm_source_link triggers :
  stm_source_link_store()->stm_source_link_add()->(stm->data->link()).

which is fine for connecting a source (ftrace,console or heartbeat) to STM.

> 2) echo 1 > $STM/enable_source

This is a bit awkward for an application who wants to mmap and stream data,
and is quite unnecessary from my explanation above.

>
> That would probably make people confused, I would appreciate any
> better solution.

Please let me know if you have any outstanding concerns.

Cheers
Suzuki
