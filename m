From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 17 Mar 2017 10:36:17 +0000
Subject: [2/2] coresight: Fix reference count for software sources
In-Reply-To: <CAG2=9p_JjxJPSAjBWfQEG_8gy0afPVTyBab+O9YY=8sQekLB+A@mail.gmail.com>
References: <1489073232-5093-3-git-send-email-suzuki.poulose@arm.com>
 <CANLsYkwg_PRcL5Sqd15phOFS-L8-v3SdvF1kBFa9De-==tx9gw@mail.gmail.com>
 <ddf386ee-0be5-b1ca-174c-89d9e48ba282@arm.com>
 <CAG2=9p_+2jv8xxUex=mvNXJswk+cx-kXGRcTbCd9i5-vOf6X4A@mail.gmail.com>
 <33ea0fe9-e93b-0cd0-9950-8443aceafc5b@arm.com>
 <CAG2=9p_JjxJPSAjBWfQEG_8gy0afPVTyBab+O9YY=8sQekLB+A@mail.gmail.com>
Message-ID: <3bf23d06-5f7b-e3de-36ab-2245ad1ef46f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/03/17 12:13, Chunyan Zhang wrote:
> On 16 March 2017 at 00:00, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>> On 15/03/17 03:51, Chunyan Zhang wrote:
>>>> Btw, should we allow the user to turn on the STM from sysfs (echo 1 >
>>>> $STM/enable_source) ?
>>>
>>>
>>> If enabling STM can not be allowed via sysfs, how should we allow
>>> users to turn on STM when they want to mmap STM to user space, and
>>> write STM device from user space directly? For example this kind of
>>> use case [1].
>>
>>
>> The ioct(, STP_POLICY_ID_SET) indirectly turns on the STM hardware via :
>> stm_char_policy_set_ioctl()->stm.link (stm_generic_link)->
>> coresight_enable().
>>
>
> Ah, that's right.  Especially after your patch [1] merged, it is
> indeed not necessary.  Thanks for pointing this.
>

>>
>>>
>>>> All STM users should set their policy via ioctls and that in turn turns
>>>> the
>>>> device on.
>>>
>>>
>>> Yes users can set policy via ioctls to request resource of STM (i.e.
>>> which STM channel(s) will be written), but they still need to use
>>> sysfs to enable STM.
>>
>>
>> As mentioned above, it is not necessary.
>>
>>>
>>>> So it doesn't make sense for enable_source to really enable
>>>> the hardware unless someone really opens it.
>>>
>>>
>>> Right, there're two ways to enable STM currently, e.g.
>>> 1) echo <addr>.stm  > /sys/class/stm_source/stm_ftrace/stm_source_link
>>
>>
>> I am not familiar with the stm_source class. From a quick glance, it looks
>> like,
>> writing to stm_source_link triggers :
>>  stm_source_link_store()->stm_source_link_add()->(stm->data->link()).
>>
>> which is fine for connecting a source (ftrace,console or heartbeat) to STM.
>>
>>> 2) echo 1 > $STM/enable_source
>>
>>
>> This is a bit awkward for an application who wants to mmap and stream data,
>> and is quite unnecessary from my explanation above.
>>
>>>
>>> That would probably make people confused, I would appreciate any
>>> better solution.
>>
>>
>> Please let me know if you have any outstanding concerns.
>
> I haven't thought out other use case which need this sysfs interface
> for CoreSight STM device, I'm ok with hiding it, but I'm not sure if
> it's good to remove this ABI from CoreSight STM but leave it to other
> CoreSight source components.

I was not planning to remove the ABI, but make it a no-op.

I had a chat with some of our experts in the area and they have one use case
which needs the STM turned on. If the user wants to run two applications
back to back (without overlap in execution), there is no way to make sure that
the STM stays on after the first application exits. So I think that is a valid
use case. So, we cannot make it

The reason I brought up this discussion is that we don't know how many times the
STM is enabled from the sysfs vs. stm_generic_link(). This could possibly cause
issues with sysfs disabling the STM (by unbalanced enable/disable). As the user
doesn't necessarily know how many times he/she enabled the device. May be we
should keep track of the sysfs refcount separately and pass it down to the csdev->refcnt
only once.

I will cook up a patch.

Suzuki

>
> Thanks,
> Chunyan
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/479893.html
>
>>
>> Cheers
>> Suzuki
>>
