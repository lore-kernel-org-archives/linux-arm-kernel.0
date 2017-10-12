From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu, 12 Oct 2017 14:03:56 -0700
Subject: [PATCH v3 16/22] firmware: arm_scmi: add arm_mhu specific mailbox
 interface
In-Reply-To: <25023d1a-a221-b131-5a1e-7d909b006d1b@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-17-git-send-email-sudeep.holla@arm.com>
 <CAK8P3a0XmiXqZ-z7WV+nk7B86p23Jmf31Q=pVovXVebhA28_0Q@mail.gmail.com>
 <CABb+yY1N6hmC6Kd2QteMw_oCf=-mYHf7p6RdhYPQK+QUO7VP4A@mail.gmail.com>
 <f142dac2-a27c-4c46-4d22-4df4f2e8cfb1@arm.com>
 <CABb+yY1w358uw2EoeioAvZy06LTuOO0krGFFXoQSNAR5m5ANmQ@mail.gmail.com>
 <25023d1a-a221-b131-5a1e-7d909b006d1b@arm.com>
Message-ID: <CAOCOHw54mQUVxVyLRWbV5Ty7trK99MM6zgXsuuxQEHnD3qvKVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 6, 2017 at 6:51 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 06/10/17 14:47, Jassi Brar wrote:
>> On Fri, Oct 6, 2017 at 7:02 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
[..]
>>> Again that's not the point, doorbell is more common feature and that can
>>> be supported. As SCMI expects doorbell feature in the specification, it
>>> just need to support that class of controllers.
>>>
>> NO.  All SCMI expects is SHMEM and a signal reaching the other end.
>> The signal mechanism need not necessarily be "doorbell".
>>
>
> Agreed, but creating an abstraction ro do something as generic as
> doorbell and writing shim layer for each controller to use SCMI also
> sounds bad.
>

In the Qualcomm platform we have a single register that exposes 32
doorbells, wired to interrupts on the various processors/co-processors
in the SoC.

There is a handful of different clients each using these doorbells to
inform the other side that something has happened (often that some
piece of shared memory has been filled with data). Over the years
(platforms) this register has moved around as such multiple
implementations exists.

You can see an example of this in
drivers/mailbox/qcom-apcs-ipc-mailbox.c and e.g.
drivers/rpmsg/qcom_glink_native.c (qcom_glink_rpm.c prior to v4.14).



I'm struggling to figure out exactly how your case looks like, but if
your doorbell exists in only one instance and there is only one client
then I would suggest that it's overkill to create another driver for
it.

Regards,
Bjorn
