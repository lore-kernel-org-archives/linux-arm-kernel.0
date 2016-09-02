From: hs.liao@mediatek.com (Horng-Shyang Liao)
Date: Fri, 2 Sep 2016 16:50:49 +0800
Subject: [PATCH v13 0/4] Mediatek MT8173 CMDQ support
In-Reply-To: <CABb+yY3uJMxcPgV4agGOd447ETe5UF-EqKWadvgfzy_QzzeGCQ@mail.gmail.com>
References: <1472009252-1074-1-git-send-email-hs.liao@mediatek.com>
 <20b10079-3ae2-9da9-1149-0bceabac9837@gmail.com>
 <1472132247.26044.23.camel@mtksdaap41>
 <CABb+yY2-cug=iwjTJEx_NQ9gj+8SZ1uHoD5hVGQDkQ7t5P=vSA@mail.gmail.com>
 <1472631185.21158.44.camel@mtksdaap41>
 <CABb+yY3uJMxcPgV4agGOd447ETe5UF-EqKWadvgfzy_QzzeGCQ@mail.gmail.com>
Message-ID: <1472806249.17078.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

On Wed, 2016-08-31 at 14:15 +0530, Jassi Brar wrote:
> On Wed, Aug 31, 2016 at 1:43 PM, Horng-Shyang Liao <hs.liao@mediatek.com> wrote:
[...]
> >> Platforms that need shared access to a channel, implement a 'server'
> >> driver that serialise (which is needed still) the access to common
> >> channel. If you think you don't need mutual exclusion and don't care
> >> about replies, simply share the mailbox handle among different
> >> clients.
> >
> > Thank you for your kindly reply.
> > We would like to discuss further with you on this topic.
> >
> > Our requirement is
> > (1) cmdq task cannot be split, and
> > (2) cmdq thread can have multiple cmdq tasks from different clients.
> >
> > According to your comment "implement a 'server' driver that serialise
> > the access to common channel", do you mean we should implement cmdq
> > client (mailbox client) as a server and other clients call the functions
> > of cmdq client?
> >
> > clients --> cmdq client (mailbox client) --> cmdq (mailbox controller)
> >
> > If so, could you please tell us the benefit of using mailbox framework?
> >
> You don't have to reinvent 80% of the wheel and reuse the mailbox.c
> core that supports many features and is tested on many platforms. Your
> implementation is going to be quite similar, only you clump all the
> code in one file and you use different terminology.
> 
> You said "we will acquire gce thread for client dynamically by
> internal policy in cmdq driver"
> On mailbox api, this maps to simply sharing the channel/thread handle,
> protected by a lock, among clients on some basis (like FCFS or
> whatever you internal policy is). So your server driver could be very
> thin. And all your clients could follow the mailbox api (which is good
> from the point of reusability/portability).
> 
> > Our original plan is to let cmdq driver manage cmdq thread internally.
> > Cmdq driver can choose a suitable cmdq thread to execute a flushed cmdq
> > task dynamically, and client doesn't need to know the existence of cmdq
> > thread.
> >
> >
> > Could you also please tell us the purpose of putting all mailbox
> > driver into mailbox folder?
> > We know that some other drivers also follow this rule, and just want
> > to know more details.
> >
> Any driver that implements the Mailbox API should live in
> drivers/mailbox/.  And why you should implement mailbox api, is
> explained above.

Thank you for your explanation.
I will move cmdq driver to mailbox folder in the next version.

Thanks,
HS
