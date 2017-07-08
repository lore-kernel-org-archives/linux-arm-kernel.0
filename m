From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sat, 8 Jul 2017 11:02:42 +0530
Subject: [PATCH 3/9] firmware: arm_scmi: add basic driver infrastructure
 for SCMI
In-Reply-To: <5f2e4f3c-297b-c5f8-9244-399c1c4e2c21@arm.com>
References: <1498492513-29771-4-git-send-email-sudeep.holla@arm.com>
 <1499446341-5956-1-git-send-email-jaswinder.singh@linaro.org>
 <5f2e4f3c-297b-c5f8-9244-399c1c4e2c21@arm.com>
Message-ID: <CABb+yY3Xo-meg5bTZ5Cj1DAvf_0yOw0QB5Kq6U7VG+L_L+Mo3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roy, Matt, Nishant, Harb Abdulhamid, Loc,

I have a gut feeling you guys were part of the SCMI spec committee. If
so, could you please chime in?


On Fri, Jul 7, 2017 at 11:09 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 07/07/17 17:52, Jassi Brar wrote:
>> Hi Arnd, Hi Rob, Hi Mark,
>>
>> [CC'ing only those who I have the email id of]
>>
>>> +/**
>>> + * scmi_do_xfer() - Do one transfer
>>> + *
>>> + * @info: Pointer to SCMI entity information
>>> + * @xfer: Transfer to initiate and wait for response
>>> + *
>>> + * Return: -ETIMEDOUT in case of no response, if transmit error,
>>> + *   return corresponding error, else if all goes well,
>>> + *   return 0.
>>> + */
>>> +int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>>> +{
>>> +    int ret;
>>> +    int timeout;
>>> +    struct scmi_info *info = handle_to_scmi_info(handle);
>>> +    struct device *dev = info->dev;
>>> +
>>> +    ret = mbox_send_message(info->tx_chan, xfer);
>>> +
>>>
>> The api is
>>
>>     int mbox_send_message(struct mbox_chan *chan, void *mssg)
>>
>> where each controller driver defines its own format in which it accepts
>> the 'mssg' to be transmitted.
>>
>
> Yes they can continue that, but SCMI just doesn't depend on that.
>
>> For example :-
>> ti_msgmgr_send_data(struct mbox_chan *, struct ti_msgmgr_message *)
>> rockchip_mbox_send_data(struct mbox_chan *, struct rockchip_mbox_msg *)
>> ....and so on...  you get the idea.
>>
>
> Yes I am aware of that.
>
>> Some controller driver may ignore the 'mssg' because only an interrupt line
>> is shared with the remote and not some register/fifo.
>> For example,
>>   sti_mbox_send_data(struct mbox_chan *, void *ignored)
>>
>
> Exactly, now with SCMI, every controller *can do* that, as we just care
> about the signaling which in other terms I have so far referred as
> "doorbell".
>
No, the controllers can not ... unless you clone and adapt the 9
drivers+bindings to conform to the expectations of SCMI (like you
attempted with MHU recently). Also, then mandate every future
controller driver must emulate "doorbell" channels.

As the mailbox maintainer, I am open to suggestions that would allow
every controller to support SCMI.
But compared to the options of scmi-as-a-library and
scmi-as-child-node-of-platform-parent, this does not even qualify as
an option.

Why? Because SCMI is but one protocol that provides 4 features ATM,
and certainly can not provide for every whim and quirk of future
platforms.  Among the sane requirements are watchdog,
suspend/resume/hibernation and thermal _control_ (not just sensor
readings) and among the weird are video, network and storage over
mailbox api. And even a filesystem backed by read/write over mailbox!!
 And these are only that I have worked on first hand.

  The point is : you can not assume SCMI to be the only protocol
running over a controller _and_ you can not dictate other protocols to
not touch certain bits of the signal register/fifo.

In simplest terms, controller driver can not cater to only a
particular client. That's the reason we have the controller driver
define the message format and clients conform to it.

Thanks.
