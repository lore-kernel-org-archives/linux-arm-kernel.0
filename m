From: Michael.Williams@arm.com (Michael Williams)
Date: Wed, 17 Feb 2016 12:08:17 +0000
Subject: [PATCH V3 6/6] coresight-stm: adding driver for CoreSight STM
 component
In-Reply-To: <CAG2=9p9-c5z6yXm6VDkDeqZmpFGt3z88ccNQxZTwia=dm3_GNQ@mail.gmail.com>
References: <1454756672-12790-1-git-send-email-zhang.chunyan@linaro.org>
 <1454756672-12790-7-git-send-email-zhang.chunyan@linaro.org>
 <CANLsYkxvLFu1C+_H9c0EoMebLQu1gnwt9bqY6_R3j+ua2w+xMg@mail.gmail.com>
 <VI1PR08MB06708C5EA9DEE2D71C13FFAA8AA90@VI1PR08MB0670.eurprd08.prod.outlook.com>
 <CAG2=9p9-c5z6yXm6VDkDeqZmpFGt3z88ccNQxZTwia=dm3_GNQ@mail.gmail.com>
Message-ID: <VI1PR08MB0670BF982CDE54DA7EE9B0BF8AAE0@VI1PR08MB0670.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chunyan,

Chunyan Zhang wrote on 2016-02-17:
> Hi Michael,
>
> One question below need to be clarified.
>
> On Fri, Feb 12, 2016 at 10:55 PM, Michael Williams
> <Michael.Williams@arm.com> wrote:
>> Mathieu Poirier [mailto:mathieu.poirier at linaro.org] wrote:
>>> On 6 February 2016 at 04:04, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
>>>> From: Pratik Patel <pratikp@codeaurora.org>
>>>>
>>>> This driver adds support for the STM CoreSight IP block, allowing any
>>>> system compoment (HW or SW) to log and aggregate messages via a
>>>> single entity.
>>>>
>>>> The CoreSight STM exposes an application defined number of channels
>>>> called stimulus port.  Configuration is done using entries in sysfs
>>>> and channels made available to userspace via configfs.
>>>>
>>>> Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
>>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>>>> ---
>>>>  .../ABI/testing/sysfs-bus-coresight-devices-stm    |  53 ++
>>>>  Documentation/trace/coresight.txt                  |  37 +-
>>>>  drivers/hwtracing/coresight/Kconfig                |  11 +
>>>>  drivers/hwtracing/coresight/Makefile               |   1 +
>>>>  drivers/hwtracing/coresight/coresight-stm.c        | 928 +++++++++++++++++++++
>>>>  include/linux/coresight-stm.h                      |   6 +
>>>>  include/uapi/linux/coresight-stm.h                 |  12 +
>>>>  7 files changed, 1046 insertions(+), 2 deletions(-)
>>>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
>>>>  create mode 100644 drivers/hwtracing/coresight/coresight-stm.c
>>>>  create mode 100644 include/linux/coresight-stm.h
>>>>  create mode 100644 include/uapi/linux/coresight-stm.h
>
> [...]
>
>>>> +static int stm_send(void *addr, const void *data, u32 size, u8 max)
>>>> +{
>>>> +       u32 len = size;
>>>> +       u8 paload[8];
>>>> +
>>>> +       if (stm_addr_unaligned(data, max)) {
>>>> +               memcpy(paload, data, size);
>>>> +               data = paload;
>>>> +       }
>>>> +
>>>> +       /* now we are 64bit/32bit aligned */
>>>> +#ifdef CONFIG_64BIT
>>>> +       if (size == 8)
>>>> +               writeq_relaxed(*(u64 *)data, addr);
>>>> +#endif
>>>
>>> We probably don't need an #ifdef here.  Checking the size of the
>>> transfer against the fundamental data size will result in the same
>>> outcome, i.e preventing 64 bit transfers on a 32 bit architecture.  An
>>> error (understandable by the caller) should probably be returned in
>>> this case.
>>
>> In theory this is correct, but if the code is unreachable for non-32-bit architectures,
> why include it at all?
>
>                             ^^^^^^^
> I guess you mean the code is unreachable for "non-64-bit" architectures?

Yes; apologies for my mistake!

[snip]

Mike

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
