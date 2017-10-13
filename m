From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 13 Oct 2017 19:42:11 +0530
Subject: [PATCH v3 16/22] firmware: arm_scmi: add arm_mhu specific mailbox
 interface
In-Reply-To: <0b65a3fd-32ff-f708-7dce-8e3a5cabf908@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-17-git-send-email-sudeep.holla@arm.com>
 <CAK8P3a0XmiXqZ-z7WV+nk7B86p23Jmf31Q=pVovXVebhA28_0Q@mail.gmail.com>
 <CABb+yY1N6hmC6Kd2QteMw_oCf=-mYHf7p6RdhYPQK+QUO7VP4A@mail.gmail.com>
 <f142dac2-a27c-4c46-4d22-4df4f2e8cfb1@arm.com>
 <CABb+yY1w358uw2EoeioAvZy06LTuOO0krGFFXoQSNAR5m5ANmQ@mail.gmail.com>
 <25023d1a-a221-b131-5a1e-7d909b006d1b@arm.com>
 <CAOCOHw54mQUVxVyLRWbV5Ty7trK99MM6zgXsuuxQEHnD3qvKVA@mail.gmail.com>
 <0b65a3fd-32ff-f708-7dce-8e3a5cabf908@arm.com>
Message-ID: <CABb+yY0HxvLs51PmB7K-T2pp+OJE8ckiBAdBa=ss2rfUes=u2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 13, 2017 at 7:12 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Hi Bjorn,
>
> Thanks for taking a look at this. Much appreciated.
>
> On 12/10/17 22:03, Bjorn Andersson wrote:
>> On Fri, Oct 6, 2017 at 6:51 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
>>>
>>> On 06/10/17 14:47, Jassi Brar wrote:
>>>> On Fri, Oct 6, 2017 at 7:02 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> [..]
>>>>> Again that's not the point, doorbell is more common feature and that can
>>>>> be supported. As SCMI expects doorbell feature in the specification, it
>>>>> just need to support that class of controllers.
>>>>>
>>>> NO.  All SCMI expects is SHMEM and a signal reaching the other end.
>>>> The signal mechanism need not necessarily be "doorbell".
>>>>
>>>
>>> Agreed, but creating an abstraction ro do something as generic as
>>> doorbell and writing shim layer for each controller to use SCMI also
>>> sounds bad.
>>>
>>
>> In the Qualcomm platform we have a single register that exposes 32
>> doorbells, wired to interrupts on the various processors/co-processors
>> in the SoC.
>>
>
> It's exactly same even on ARM MHU controller.
>
This has been a big problem in our communication. You start with
"exactly same..." and go on telling the difference.
And that difference is important.

In MHU the 32bits are tied together and all go to one target
processor. Whereas on QCom, each bit corresponds to independent signal
going to a different target processor.

IOW, QCom has 32 channels per register whereas MHU has one. The
current drivers reflect that reality and hence I am against any change
in MHU driver.  Not to mean even changing the MHU driver will fix the
core issue - which is https://lkml.org/lkml/2017/7/7/465 and this
patchset tries to address that.
