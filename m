From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 2 Nov 2017 10:18:51 +0530
Subject: [PATCH] mailbox: add support for doorbell/signal mode controllers
In-Reply-To: <20171102032728.GI28761@minitux>
References: <1509553964-4451-1-git-send-email-sudeep.holla@arm.com>
 <CABb+yY1tcm-68E5oG75hstuMd6AOeb=BB6HeKGnQ1zj4Qya6hg@mail.gmail.com>
 <59a05fcb-ff30-0683-144e-93521a7413f9@arm.com>
 <20171101221709.GB28761@minitux>
 <CABb+yY0unrs-LpqFyh1ibVO00ztA+=i_1-+MpRCrG5mLsWoiSw@mail.gmail.com>
 <20171102032728.GI28761@minitux>
Message-ID: <CABb+yY3aXQHy2Y1DSxnFzho+6mfPQ442cCNag0QEGEuf3XZB6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 2, 2017 at 8:57 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Wed 01 Nov 20:02 PDT 2017, Jassi Brar wrote:
>
>> On Thu, Nov 2, 2017 at 3:47 AM, Bjorn Andersson
>> <bjorn.andersson@linaro.org> wrote:
>> > On Wed 01 Nov 11:15 PDT 2017, Sudeep Holla wrote:
>> >>
>> >>  80         writel_relaxed(msg->cmd, mb->mbox_base +
>> >> MAILBOX_A2B_CMD(chans->idx));
>> >>  81         writel_relaxed(msg->rx_size, mb->mbox_base +
>> >>
>> >>  82                        MAILBOX_A2B_DAT(chans->idx));
>> >>
>> >>  83
>> >
>> > This is just terrible, using the void *mssg to pass a struct which is
>> > interpreted by the controller removes any form of abstraction provided
>> > by the framework.
>> >
>> > In my view the void *mssg should point to the data to be written in the
>> > mailbox register, and hence might be of different size - but only of
>> > native type.
>> >
>> Please note the terrible 'rx_size' is not a software option - the
>> hardware has a DAT register so the driver rightfully allows a client
>> to write a value in that as well.
>
> Okay, so the interface exposed by the mailbox driver is not { cmd,
> rx_size } but rather __le32 data[2], or perhaps a generic { cmd, data }.
> That sounds more generic.
>
>
> I think it would be good to replace the totally opaque void * with some
> sort of structured data type and having the framework ensure that
> clients and controllers are compatible. That would, by design, allow for
> reuse between controllers and clients.
>
> Perhaps something like:
>
> enum mbox_msg_type {
>         MBOX_MSG_TYPE_NULL,
>         MBOX_MSG_TYPE_U32,
>         MBOX_MSG_TYPE_CMD_DATA,
> };
>
> struct mbox_msg {
>         enum mbox_msg_type type;
>
>         union {
>                 u32 u;
>                 struct {
>                         u32 cmd;
>                         u32 data;
>                 } cd;
>         };
> };
>
> And have the controller register for a specific "type", so the framework
> could validate that the type of data being passed matches the hardware.
>
> Have you had any thoughts around this before?
>
Yes. Different controllers have different capabilities... some have
32bits data register, some have 4x32bits deep fifos and some 8x32bits
deep.... while some traverse descriptor rings. Even with all these
termed 'standard' options, the clients still have to understand the
underlying controller and what the remote expects it to behave and do
very platform specific tasks. So mailbox clients are inherently
difficult to be reusable on other platforms.

cheers
