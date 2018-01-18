From: houlong.wei@mediatek.com (houlong wei)
Date: Thu, 18 Jan 2018 16:31:53 +0800
Subject: FW: [PATCH v20 2/4] mailbox: mediatek: Add Mediatek CMDQ driver
In-Reply-To: <CABb+yY02S=+00mY-NTkJUBPiVruYdf0xuovKomehUxLNOQPLuA@mail.gmail.com>
References: <1483499169-16329-1-git-send-email-hs.liao@mediatek.com>
 <1483499169-16329-3-git-send-email-hs.liao@mediatek.com>
 <CABb+yY23TUB8NpmpiO=cCmVFAVJMqKPfGgX14j+_Yj7tJvMOuQ@mail.gmail.com>
 <1485419833.990.1.camel@mtksdaap41>
 <CABb+yY13VaFpYz6EExvAXLpAqEWDJ4R50WG0DYbXO6iCESbA5A@mail.gmail.com>
 <1486359476.11424.33.camel@mtksdaap41>
 <CABb+yY0jCGqnrMLkkTNoEmLX4jDstWh7-UYhDyKjV-gFOnxpsg@mail.gmail.com>
 <1487733150.15869.11.camel@mtksdaap41>
 <CABb+yY2dzcR4fYvrSQK5jemwUSkYVJ8aWEmiE6wstw-Yyqy7bw@mail.gmail.com>
 <1487854104.17813.1.camel@mtksdaap41>
 <497f8e4ef7ae4c8a9b7b4ab259801306@mtkmbs01n1.mediatek.inc>
 <1515400735.21044.35.camel@mhfsdcap03>
 <CABb+yY02S=+00mY-NTkJUBPiVruYdf0xuovKomehUxLNOQPLuA@mail.gmail.com>
Message-ID: <1516264313.16602.30.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

There is one request for one GCE h/w buffer which contains a list of
registers operation.
I will resubmit a version and please review again.

Thanks,
Houlong

On Thu, 2018-01-18 at 16:01 +0800, Jassi Brar wrote:
> On Mon, Jan 8, 2018 at 2:08 PM, houlong wei <houlong.wei@mediatek.com> wrote:
> > Hi Jassi,
> >
> > Sorry for reply so late.
> > According to previous discussion, there are two methods to move
> > dma_map_single() outside of spin_lock.
> > (1) put in mtk-cmdq-helper.c, as described by HS on 2017-02-09.
> >   > I think a trade-off solution is to put in mtk-cmdq-helper.c.
> >   > Although it is a mailbox client, it is not a CMDQ client.
> >   > We can include mailbox_controller.h in mtk-cmdq-helper.c (instead of
> > mtk-cmdq.h), and then map dma at cmdq_pkt_flush_async before
> > mbox_send_message.
> >
> >   > pkt->pa_base = dma_map_single(client->chan->mbox->dev, pkt->va_base,
> >   >                              pkt->cmd_buf_size, DMA_TO_DEVICE);
> > (2) schedule a tasklet in send_data().
> >
> > After internal discussion with HS and other experts, now we prefer
> > method (1).
> > How do you think about it?
> >
> I don't exactly see how you mean but please remember send_data()
> callback is supposed to be atomic ... it is protected by
> spin_lock_irqsave/restore in drivers/mailbox/mailbox.c:msg_submit()
> 
> BTW, how many requests max can be queued in the GCE h/w buffer?
> And since it's been over a year now, could you please resubmit after
> checking for checkpatch with the --strict option?
> 
> Thanks.
