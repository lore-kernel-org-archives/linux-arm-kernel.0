From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 2 Nov 2017 10:51:33 +0000
Subject: [PATCH] mailbox: add support for doorbell/signal mode controllers
In-Reply-To: <20171101221217.GA28761@minitux>
References: <1509553964-4451-1-git-send-email-sudeep.holla@arm.com>
 <CABb+yY1tcm-68E5oG75hstuMd6AOeb=BB6HeKGnQ1zj4Qya6hg@mail.gmail.com>
 <20171101221217.GA28761@minitux>
Message-ID: <9c0a0af0-6a2d-4394-a274-2e52ea65845d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/11/17 22:12, Bjorn Andersson wrote:
> On Wed 01 Nov 11:03 PDT 2017, Jassi Brar wrote:
>> On Wed, Nov 1, 2017 at 10:02 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> [..]
>>>
>>> This is rough idea I have on extending mailbox interface to support
>>> the doorbell requirements.
>>>
>> What doorbell requirements does the api not support?
>> QComm's APCS IPC is what you call a "doorbell" controller and is
>> already supported by the API. It could run SCMI even easier than MHU
>> (your controller).
>>
> 
> I agree; from a mbox consumer perspective a doorbell should be a mailbox
> channel that when signalled will ring the bell, i.e. the message is not
> significant and should not be provided by the client.
> 

Exactly.

> If the message is significant and is not derived from the mailbox
> channel (e.g. channel id -> bit in register) it is not a mailbox
> doorbell, it's s regular mailbox used as a doorbell.
> 

Agreed, in my case(ARM MHU) it's indeed a register bit.

> 
> The potential improvement I see in the Qualcomm case is to wrap the
> mbox_send_message(chan, NULL); mbox_client_txdone(chan, 0); calls in one
> simple "mbox_ring_door_bell(chan)" - but I haven't investigated the
> validity of this as a generic function.
> 

Yes that's exactly what I want to do as we make progress with this
patch. For that we find need to add send_signal(chan), instead of
send_data(chan, data).
-- 
Regards,
Sudeep
