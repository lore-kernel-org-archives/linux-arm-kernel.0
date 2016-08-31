From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 31 Aug 2016 14:15:29 +0530
Subject: [PATCH v13 0/4] Mediatek MT8173 CMDQ support
In-Reply-To: <1472631185.21158.44.camel@mtksdaap41>
References: <1472009252-1074-1-git-send-email-hs.liao@mediatek.com>
 <20b10079-3ae2-9da9-1149-0bceabac9837@gmail.com>
 <1472132247.26044.23.camel@mtksdaap41>
 <CABb+yY2-cug=iwjTJEx_NQ9gj+8SZ1uHoD5hVGQDkQ7t5P=vSA@mail.gmail.com>
 <1472631185.21158.44.camel@mtksdaap41>
Message-ID: <CABb+yY3uJMxcPgV4agGOd447ETe5UF-EqKWadvgfzy_QzzeGCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 1:43 PM, Horng-Shyang Liao <hs.liao@mediatek.com> wrote:

>> >> The driver uses the mailbox framework, so it should live in the
>> >> drivers/mailbox folder.
>> >
>> > As you know, the maximum number of gce threads is 16.
>> > However, we plan to support more clients in the future,
>> > and they may need to use more than 16 gce threads.
>> >
>> > For this issue, our plan is to let multiple clients share the same gce
>> > thread; i.e. we will acquire gce thread for client dynamically by
>> > internal policy in cmdq driver.
>> > Unfortunately. mailbox channel has exclusive feature.
>> > Quote from comment of mbox_request_channel().
>> > "The channel is exclusively allocated and can't be used by another
>> > client before the owner calls mbox_free_channel."
>> > Therefore, we plan to remove mailbox framework from cmdq driver in the
>> > future.
>> >
>> Platforms that need shared access to a channel, implement a 'server'
>> driver that serialise (which is needed still) the access to common
>> channel. If you think you don't need mutual exclusion and don't care
>> about replies, simply share the mailbox handle among different
>> clients.
>
> Thank you for your kindly reply.
> We would like to discuss further with you on this topic.
>
> Our requirement is
> (1) cmdq task cannot be split, and
> (2) cmdq thread can have multiple cmdq tasks from different clients.
>
> According to your comment "implement a 'server' driver that serialise
> the access to common channel", do you mean we should implement cmdq
> client (mailbox client) as a server and other clients call the functions
> of cmdq client?
>
> clients --> cmdq client (mailbox client) --> cmdq (mailbox controller)
>
> If so, could you please tell us the benefit of using mailbox framework?
>
You don't have to reinvent 80% of the wheel and reuse the mailbox.c
core that supports many features and is tested on many platforms. Your
implementation is going to be quite similar, only you clump all the
code in one file and you use different terminology.

You said "we will acquire gce thread for client dynamically by
internal policy in cmdq driver"
On mailbox api, this maps to simply sharing the channel/thread handle,
protected by a lock, among clients on some basis (like FCFS or
whatever you internal policy is). So your server driver could be very
thin. And all your clients could follow the mailbox api (which is good
from the point of reusability/portability).

> Our original plan is to let cmdq driver manage cmdq thread internally.
> Cmdq driver can choose a suitable cmdq thread to execute a flushed cmdq
> task dynamically, and client doesn't need to know the existence of cmdq
> thread.
>
>
> Could you also please tell us the purpose of putting all mailbox
> driver into mailbox folder?
> We know that some other drivers also follow this rule, and just want
> to know more details.
>
Any driver that implements the Mailbox API should live in
drivers/mailbox/.  And why you should implement mailbox api, is
explained above.
