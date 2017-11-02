From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 2 Nov 2017 16:56:40 +0530
Subject: [PATCH] mailbox: add support for doorbell/signal mode controllers
In-Reply-To: <4268c9d9-dc1e-0bd7-3fac-790c2d42b54b@arm.com>
References: <1509553964-4451-1-git-send-email-sudeep.holla@arm.com>
 <CABb+yY1tcm-68E5oG75hstuMd6AOeb=BB6HeKGnQ1zj4Qya6hg@mail.gmail.com>
 <59a05fcb-ff30-0683-144e-93521a7413f9@arm.com>
 <CABb+yY16-B9vReRjLopV1RsyB8a=c5X9XaomtTj44520XrDdmA@mail.gmail.com>
 <4268c9d9-dc1e-0bd7-3fac-790c2d42b54b@arm.com>
Message-ID: <CABb+yY3Gd3u-_xNPSqJT_+yVHGMs7pgt3Bc4faGvN2KwOsm6_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 2, 2017 at 4:17 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 02/11/17 02:39, Jassi Brar wrote:

>>>>>
>>>>> Such controllers don't need to transmit any data, they just transmit
>>>>> the signal. In such controllers the data pointer passed to
>>>>> mbox_send_message is passed to client via it's tx_prepare callback.
>>>>> Controller doesn't need any data to be passed from the client.
>>>>>
>>>> Some controllers need a non-zero value written to a register in order
>>>> to trigger the signal.
>>>
>>> You are right, just right non-zero or whatever controller value to
>>> trigger the interrupt to remote.
>>>
>>>> That register is visible to the remote. While the data/packet is setup
>>>> during tx_prepare() callback.
>>>
>>> Agreed.
>>>
>>>> You are overlooking this class of doorbell controllers.
>>>>
>>>
>>> Not sure what do you mean by that ?
>>>
>> Such doorbell controllers can't use send_signal(chan) because they
>> need that non-zero value from client to send over the shared register.
>> You are assuming every protocol implements just one command.
>>
>
> No that non-zero value is not client specific, it's entirely controller
> specific.
>
??
For example BCM2835 has such a controller. Have a look at
bcm2835_send_data() and let me know what is that controller specific
value.


>>> Again agreed. But see below for reason to create this API.
>>>
>>>>> The new API send_signal will eliminate the
>>>>> issue Jassi has explained in earlier discussion with respect to generic
>>>>> message format using Rockchip example.
>>>>>
>>>> Sorry I don't see how.
>>>> Please explain how can send_signal() api be used by, say, rockchip to
>>>> support SCMI?
>>>>
>>>
>>>  80         writel_relaxed(msg->cmd, mb->mbox_base +
>>> MAILBOX_A2B_CMD(chans->idx));
>>>  81         writel_relaxed(msg->rx_size, mb->mbox_base +
>>>
>>>  82                        MAILBOX_A2B_DAT(chans->idx));
>>>
>>>  83
>>>
>>>  will be replaced with
>>>
>>> writel(whatever_value_to trigger_signal, MAILBOX_A2B_CMD(chans->idx));
>>>
>>> in its send_signal function.
>>>
>> 1) Where does the  "whatever_value_to_trigger_signal"  come from?
>
> Controller specific.
>
>> That has to come from client.
>
> No.
>
Again, let me know what does the controller expect 'val' to be

  writel(val, MAILBOX_A2B_CMD(chans->idx))


Your entire post is based on your assertion that the controller
expects a particular non-zero value to trigger a signal, which is
wrong. So lets first get that straight and not stray from the point.
