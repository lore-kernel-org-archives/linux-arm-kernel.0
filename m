From: hs.liao@mediatek.com (Horng-Shyang Liao)
Date: Wed, 31 Aug 2016 16:13:05 +0800
Subject: [PATCH v13 0/4] Mediatek MT8173 CMDQ support
In-Reply-To: <CABb+yY2-cug=iwjTJEx_NQ9gj+8SZ1uHoD5hVGQDkQ7t5P=vSA@mail.gmail.com>
References: <1472009252-1074-1-git-send-email-hs.liao@mediatek.com>
 <20b10079-3ae2-9da9-1149-0bceabac9837@gmail.com>
 <1472132247.26044.23.camel@mtksdaap41>
 <CABb+yY2-cug=iwjTJEx_NQ9gj+8SZ1uHoD5hVGQDkQ7t5P=vSA@mail.gmail.com>
Message-ID: <1472631185.21158.44.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

On Thu, 2016-08-25 at 19:12 +0530, Jassi Brar wrote:
> On Thu, Aug 25, 2016 at 7:07 PM, Horng-Shyang Liao <hs.liao@mediatek.com> wrote:
> > Hi Matthias,
> >
> > On Wed, 2016-08-24 at 13:00 +0200, Matthias Brugger wrote:
> >> On 24/08/16 05:27, HS Liao wrote:
[...]
> >> > HS Liao (4):
> >> >   dt-bindings: soc: Add documentation for the MediaTek GCE unit
> >> >   CMDQ: Mediatek CMDQ driver
> >> >   arm64: dts: mt8173: Add GCE node
> >> >   CMDQ: save more energy in idle
> >> >
> >> >  .../devicetree/bindings/soc/mediatek/gce.txt       |  44 +
> >> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  10 +
> >> >  drivers/soc/mediatek/Kconfig                       |  11 +
> >> >  drivers/soc/mediatek/Makefile                      |   1 +
> >> >  drivers/soc/mediatek/mtk-cmdq.c                    | 983 +++++++++++++++++++++
> >>
> >> The driver uses the mailbox framework, so it should live in the
> >> drivers/mailbox folder.
> >
> > As you know, the maximum number of gce threads is 16.
> > However, we plan to support more clients in the future,
> > and they may need to use more than 16 gce threads.
> >
> > For this issue, our plan is to let multiple clients share the same gce
> > thread; i.e. we will acquire gce thread for client dynamically by
> > internal policy in cmdq driver.
> > Unfortunately. mailbox channel has exclusive feature.
> > Quote from comment of mbox_request_channel().
> > "The channel is exclusively allocated and can't be used by another
> > client before the owner calls mbox_free_channel."
> > Therefore, we plan to remove mailbox framework from cmdq driver in the
> > future.
> >
> Platforms that need shared access to a channel, implement a 'server'
> driver that serialise (which is needed still) the access to common
> channel. If you think you don't need mutual exclusion and don't care
> about replies, simply share the mailbox handle among different
> clients.

Thank you for your kindly reply.
We would like to discuss further with you on this topic.

Our requirement is
(1) cmdq task cannot be split, and
(2) cmdq thread can have multiple cmdq tasks from different clients.

According to your comment "implement a 'server' driver that serialise
the access to common channel", do you mean we should implement cmdq
client (mailbox client) as a server and other clients call the functions
of cmdq client?

clients --> cmdq client (mailbox client) --> cmdq (mailbox controller)

If so, could you please tell us the benefit of using mailbox framework?

Our original plan is to let cmdq driver manage cmdq thread internally.
Cmdq driver can choose a suitable cmdq thread to execute a flushed cmdq
task dynamically, and client doesn't need to know the existence of cmdq
thread.


Could you also please tell us the purpose of putting all mailbox
driver into mailbox folder?
We know that some other drivers also follow this rule, and just want
to know more details.

Thanks,
HS
