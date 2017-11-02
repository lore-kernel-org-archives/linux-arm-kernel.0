From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 2 Nov 2017 08:09:48 +0530
Subject: [PATCH] mailbox: add support for doorbell/signal mode controllers
In-Reply-To: <59a05fcb-ff30-0683-144e-93521a7413f9@arm.com>
References: <1509553964-4451-1-git-send-email-sudeep.holla@arm.com>
 <CABb+yY1tcm-68E5oG75hstuMd6AOeb=BB6HeKGnQ1zj4Qya6hg@mail.gmail.com>
 <59a05fcb-ff30-0683-144e-93521a7413f9@arm.com>
Message-ID: <CABb+yY16-B9vReRjLopV1RsyB8a=c5X9XaomtTj44520XrDdmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 1, 2017 at 11:45 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 01/11/17 18:03, Jassi Brar wrote:
>> On Wed, Nov 1, 2017 at 10:02 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>>
>>> Such controllers don't need to transmit any data, they just transmit
>>> the signal. In such controllers the data pointer passed to
>>> mbox_send_message is passed to client via it's tx_prepare callback.
>>> Controller doesn't need any data to be passed from the client.
>>>
>> Some controllers need a non-zero value written to a register in order
>> to trigger the signal.
>
> You are right, just right non-zero or whatever controller value to
> trigger the interrupt to remote.
>
>> That register is visible to the remote. While the data/packet is setup
>> during tx_prepare() callback.
>
> Agreed.
>
>> You are overlooking this class of doorbell controllers.
>>
>
> Not sure what do you mean by that ?
>
Such doorbell controllers can't use send_signal(chan) because they
need that non-zero value from client to send over the shared register.
You are assuming every protocol implements just one command.

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
> Again agreed. But see below for reason to create this API.
>
>>> The new API send_signal will eliminate the
>>> issue Jassi has explained in earlier discussion with respect to generic
>>> message format using Rockchip example.
>>>
>> Sorry I don't see how.
>> Please explain how can send_signal() api be used by, say, rockchip to
>> support SCMI?
>>
>
>  80         writel_relaxed(msg->cmd, mb->mbox_base +
> MAILBOX_A2B_CMD(chans->idx));
>  81         writel_relaxed(msg->rx_size, mb->mbox_base +
>
>  82                        MAILBOX_A2B_DAT(chans->idx));
>
>  83
>
>  will be replaced with
>
> writel(whatever_value_to trigger_signal, MAILBOX_A2B_CMD(chans->idx));
>
> in its send_signal function.
>
1) Where does the  "whatever_value_to_trigger_signal"  come from?
That has to come from client. You can not dictate the channel
transfers a fixed u32 value over its lifetime. SCMI may use one
command code but other protocols use more.

2) Using 'rx_size' is not a software choice made in the driver. The
_hardware_ has two registers shared with remote side - a CMD and a
DATA register. So the driver (written agnostic to any particular
client) would naturally expect the command+data from the client to be
programmed in to CMD and DAT registers.


>> I am not convinced we should clone an api just so that a client driver
>> becomes simpler. Esp when it shifts, and not avoid, the additional
>> code (to support the client) onto the provider side.
>>
>
> It doesn't tie the data format with particular mailbox controller.
> send_data has void *data and the interpretation is controller specific.
> send_signal on the other handle can implemented by the controllers which
> knows how and can trigger the specific signal to the remote.
>
Yeah that's what I said - you want to make a client simpler by pushing
the code requirement onto the provider side.

For example, you mean we modify the provider rockchip-mailbox.c by implementing

rockchip_send_signal(chan)
{
  struct rockchip_mbox_msg msg;

  msg.cmd = chan->idx;  //only one command supported by the channel !!!
  msg.rx_size = 0;

  rockchip_send_data(chan, (void*) &msg);
}

whereas I suggest this SCMI specific code should be part of
transport/mapping shim layer of SCMI.
