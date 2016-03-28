From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Mon, 28 Mar 2016 10:58:29 +0800
Subject: [RESEND PATCH V4 0/4] Introduce CoreSight STM support
In-Reply-To: <CANLsYkyZODA6dHpKZfx2DPaZ0qe==6T1FGgR5ajZASGmcuJXhw@mail.gmail.com>
References: <1457418835-31417-1-git-send-email-zhang.chunyan@linaro.org>
 <CANLsYkyZODA6dHpKZfx2DPaZ0qe==6T1FGgR5ajZASGmcuJXhw@mail.gmail.com>
Message-ID: <CAG2=9p94GH9qRTffV8OrGvqktT_iyfGR4zBLN3NABJaesj8t2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 25, 2016 at 8:51 PM, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
> On 7 March 2016 at 23:33, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
>> This patchset adds support for the CoreSight STM IP block.
>>
>> In the fourth version, comments from various people have been
>> addressed.  Representing configurations where channels are shared
>> between multiple masterIDs has been kept unchanged from the previous
>> version because a viable alternative hasn't been suggested.
>>
>> This RESEND PATCH 1/4 depends on the patch [3] which has been
>> merged into linux-next.
>
> We are not going anywhere with 1/4.  Since the functionality conveyed
> by that patch isn't strictly needed simply drop it (along with 2/4).
> Please take into consideration the comments I made on 4/4 and respin
> on 4.6-rc1 when it comes out.

Got it. Noticed 4.6-rc1 has been came out, I will send out a new
patchset today, include 3/4 and 4/4 with addressing your comments on
4/4.

Thanks for your review,
Chunyan

>
> Thanks,
> Mathieu
>
>>
>> Changes from V3:
>>  - Removed ioctl get_options interface from the generic STM code and CoreSight STM driver.
>>  - Removed 'write_max' from the structure 'stm_drvdata', and changed 'write_64bit' to 'write_bytes'.
>>  - Revised stm_fundamental_data_size() to return the fundamental data size instead of 0/1.
>>  - Removed stm_remove() from the driver.
>>  - Revised the return value of ::packet() callback function according to [2].
>>  - Modified stm_send() to send one STP packet at a time.
>>  - Added comments to invariant/guaranteed CoreSight STM transaction mode.
>>
>> Changes from V2:
>>  - Changed to return -EFAULT if failed on the command STP_GET_OPTIONS.
>>  - Used Alex's patch [1] instead of the last 2/6.
>>  - Removed the while loop from stm_send(), since the packet size passed
>>    to it isn't larger than 4 bytes on 32-bit system and 8 bytes on
>>    64-bit system.
>>  - Removed stm_send_64bit(), since the process of packets on 64-bit
>>    CS-STM should be basically the same with on 32-bit system, except the
>>    maximum length of writing STM at a time.
>>  - Removed the support of writing 64-bit to CoreSight STM buffer at a time
>>    on 32-bit ARM architecture according to an ARM engineer suggestion.  As
>>    he said that the STM might receive a 64-bit write, or might receive a
>>    pair of 32-bit writes to the two addressed words in either order.
>>    So 64-bit write isn't guaranteed to work on the ARM 32-bit architecture.
>>
>> Changes from v1:
>>  - Added a definition of coresight_simple_func() in CS-STM driver to
>>    avoid the kbuild test robot error for the time being.  This
>>    modification will be removed when merging the code in which the
>>    coresight_simple_func() has been moved to the header file.
>>  - Calculate the channel number according to the channel memory space size.
>>
>>
>> Thanks,
>> Chunyan
>>
>> [1] https://lkml.org/lkml/2016/2/4/652
>> [2] https://lkml.org/lkml/2016/2/12/397
>> [3] https://lkml.org/lkml/2015/12/22/348
>>
>> Chunyan Zhang (1):
>>   Documentations: Add explanations of the case for non-configurable
>>     masters
>>
>> Mathieu Poirier (2):
>>   stm class: provision for statically assigned masterIDs
>>   coresight-stm: Bindings for System Trace Macrocell
>>
>> Pratik Patel (1):
>>   coresight-stm: adding driver for CoreSight STM component
>>
>>  .../ABI/testing/sysfs-bus-coresight-devices-stm    |  53 ++
>>  .../devicetree/bindings/arm/coresight.txt          |  28 +
>>  Documentation/trace/coresight.txt                  |  37 +-
>>  Documentation/trace/stm.txt                        |   6 +
>>  drivers/hwtracing/coresight/Kconfig                |  11 +
>>  drivers/hwtracing/coresight/Makefile               |   1 +
>>  drivers/hwtracing/coresight/coresight-stm.c        | 890 +++++++++++++++++++++
>>  drivers/hwtracing/stm/core.c                       |  17 +-
>>  drivers/hwtracing/stm/policy.c                     |  18 +-
>>  include/linux/coresight-stm.h                      |   6 +
>>  include/linux/stm.h                                |   8 +
>>  include/uapi/linux/coresight-stm.h                 |  21 +
>>  12 files changed, 1090 insertions(+), 6 deletions(-)
>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
>>  create mode 100644 drivers/hwtracing/coresight/coresight-stm.c
>>  create mode 100644 include/linux/coresight-stm.h
>>  create mode 100644 include/uapi/linux/coresight-stm.h
>>
>> --
>> 1.9.1
>>
