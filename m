From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 24 Jul 2017 10:50:03 +0100
Subject: [PATCH 3/9] firmware: arm_scmi: add basic driver infrastructure
 for SCMI
In-Reply-To: <CABb+yY3Xo-meg5bTZ5Cj1DAvf_0yOw0QB5Kq6U7VG+L_L+Mo3w@mail.gmail.com>
References: <1498492513-29771-4-git-send-email-sudeep.holla@arm.com>
 <1499446341-5956-1-git-send-email-jaswinder.singh@linaro.org>
 <5f2e4f3c-297b-c5f8-9244-399c1c4e2c21@arm.com>
 <CABb+yY3Xo-meg5bTZ5Cj1DAvf_0yOw0QB5Kq6U7VG+L_L+Mo3w@mail.gmail.com>
Message-ID: <f165d171-a55b-662f-888c-3be2c3e8f11a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/07/17 06:32, Jassi Brar wrote:
> Hi Roy, Matt, Nishant, Harb Abdulhamid, Loc,
> 
> I have a gut feeling you guys were part of the SCMI spec committee. If
> so, could you please chime in?
> 

I take complete silence as no objection.

> 
> On Fri, Jul 7, 2017 at 11:09 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 07/07/17 17:52, Jassi Brar wrote:
>>> Hi Arnd, Hi Rob, Hi Mark,
>>>
>>> [CC'ing only those who I have the email id of]
>>>
>>>> +/**
>>>> + * scmi_do_xfer() - Do one transfer
>>>> + *
>>>> + * @info: Pointer to SCMI entity information
>>>> + * @xfer: Transfer to initiate and wait for response
>>>> + *
>>>> + * Return: -ETIMEDOUT in case of no response, if transmit error,
>>>> + *   return corresponding error, else if all goes well,
>>>> + *   return 0.
>>>> + */
>>>> +int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>>>> +{
>>>> +    int ret;
>>>> +    int timeout;
>>>> +    struct scmi_info *info = handle_to_scmi_info(handle);
>>>> +    struct device *dev = info->dev;
>>>> +
>>>> +    ret = mbox_send_message(info->tx_chan, xfer);
>>>> +
>>>>
>>> The api is
>>>
>>>     int mbox_send_message(struct mbox_chan *chan, void *mssg)
>>>
>>> where each controller driver defines its own format in which it accepts
>>> the 'mssg' to be transmitted.
>>>
>>
>> Yes they can continue that, but SCMI just doesn't depend on that.
>>
>>> For example :-
>>> ti_msgmgr_send_data(struct mbox_chan *, struct ti_msgmgr_message *)
>>> rockchip_mbox_send_data(struct mbox_chan *, struct rockchip_mbox_msg *)
>>> ....and so on...  you get the idea.
>>>
>>
>> Yes I am aware of that.
>>
>>> Some controller driver may ignore the 'mssg' because only an interrupt line
>>> is shared with the remote and not some register/fifo.
>>> For example,
>>>   sti_mbox_send_data(struct mbox_chan *, void *ignored)
>>>
>>
>> Exactly, now with SCMI, every controller *can do* that, as we just care
>> about the signaling which in other terms I have so far referred as
>> "doorbell".
>>

You keep combining the 2 changes. Please treat them differently.
I need ARM MHU doorbell changes as I need to support multiple channels
on my platform which are independent and run different protocol.
That doorbell change *is not SCMI* specific. I am not sure how to conver
that message to you. All my attempts have failed so far.

> No, the controllers can not ... unless you clone and adapt the 9
> drivers+bindings to conform to the expectations of SCMI (like you
> attempted with MHU recently). Also, then mandate every future
> controller driver must emulate "doorbell" channels.
> 

Why do you think so ? Please give me your understanding on what SCMI
specification expects as you seem to think we need to clone ?
All I am saying is we don't pass any information in the controller.
The current drivers just need a way to trigger the remote and I believe
all of them already have.

> As the mailbox maintainer, I am open to suggestions that would allow
> every controller to support SCMI.

That's good to know.

> But compared to the options of scmi-as-a-library and
> scmi-as-child-node-of-platform-parent, this does not even qualify as
> an option.
> 

I don't understand this.

> Why? Because SCMI is but one protocol that provides 4 features ATM,
> and certainly can not provide for every whim and quirk of future
> platforms.  Among the sane requirements are watchdog,
> suspend/resume/hibernation and thermal _control_ (not just sensor
> readings) and among the weird are video, network and storage over
> mailbox api. And even a filesystem backed by read/write over mailbox!!
>  And these are only that I have worked on first hand.
> 

Fine. We need to support them I am not saying that we don't. Please
answer my question above which I believe should reduce the confusion.

>   The point is : you can not assume SCMI to be the only protocol
> running over a controller _and_ you can not dictate other protocols to
> not touch certain bits of the signal register/fifo.
> 

NO, I am saying again that I am not assuming that and you are the one
who is assuming MHU *must* work in the way the driver is written
currently and constantly/repeatedly ignoring the fact what MHY
specification states and mixing that change with SCMI here.

> In simplest terms, controller driver can not cater to only a
> particular client. That's the reason we have the controller driver
> define the message format and clients conform to it.

100%. You need to understand the fact that my changes makes it work with
SCMI and other protocol and MHU as it stands only work with whatever
platform you have with whatever client that supports.

-- 
Regards,
Sudeep
