From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Feb 2015 14:46:11 +0000
Subject: [PATCH v5 2/7] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <CAJe_ZhdL6=4bMPRitFeCqrO2jeYQuDa9071estTBd3PTbmURYA@mail.gmail.com>
References: <1422955310-6542-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1422955763-6630-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <20150203123216.GO8656@n2100.arm.linux.org.uk>
 <CAJe_ZhdL6=4bMPRitFeCqrO2jeYQuDa9071estTBd3PTbmURYA@mail.gmail.com>
Message-ID: <20150203144611.GS8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 03, 2015 at 08:09:34PM +0530, Jassi Brar wrote:
> On 3 February 2015 at 18:02, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Feb 03, 2015 at 05:29:23PM +0800, Vincent Yang wrote:
> >> +static int mhu_send_data(struct mbox_chan *chan, void *data)
> >> +{
> >> +     struct mhu_link *mlink = chan->con_priv;
> >> +
> >> +     pr_debug("%s:%d\n", __func__, __LINE__);
> >> +     if (!mhu_last_tx_done(chan)) {
> >> +             dev_err(chan->mbox->dev, "Last TX(%d) pending!\n", mlink->irq);
> >> +             return -EBUSY;
> >> +     }
> >> +
> >> +     writel_relaxed((u32)data, mlink->tx_reg + INTR_SET_OFS);
> >
> > Doesn't that cause a GCC warning?
> >
> I don't see any, but I'll drop the cast.

A cast is probably needed.  You're right that GCC no longer warns about
this - I'm pretty sure it used to complain about casting pointers to
ints, and we used to need to cast to "unsigned long" first.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
