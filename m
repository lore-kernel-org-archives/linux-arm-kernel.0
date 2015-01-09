From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Jan 2015 15:24:02 +0000
Subject: [PATCH v3 2/8] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <CAJe_ZhdkF5o91HE8woAw0-DN5TuS_j6LM15NF0z6oHcQwPvnsQ@mail.gmail.com>
References: <1420802369-3840-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1420802889-4041-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <20150109125102.GL12302@n2100.arm.linux.org.uk>
 <CAJe_ZhdkF5o91HE8woAw0-DN5TuS_j6LM15NF0z6oHcQwPvnsQ@mail.gmail.com>
Message-ID: <20150109152402.GQ12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 06:49:12PM +0530, Jassi Brar wrote:
> On 9 January 2015 at 18:21, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Jan 09, 2015 at 07:28:09PM +0800, Vincent Yang wrote:
> >> +static irqreturn_t mhu_rx_interrupt(int irq, void *p)
> >> +{
> >> +     struct mbox_chan *chan = p;
> >> +     struct mhu_link *mlink = (struct mhu_link *)chan->con_priv;
> >> +     u32 val;
> >> +
> >> +     pr_debug("%s:%d\n", __func__, __LINE__);
> >> +     val = readl_relaxed(mlink->rx_reg + INTR_STAT_OFS);
> >> +     mbox_chan_received_data(chan, (void *)val);
> >> +
> >> +     writel_relaxed(val, mlink->rx_reg + INTR_CLR_OFS);
> >> +
> >> +     return IRQ_HANDLED;
> >
> > What if 'val' was zero - is the interrupt still "handled" ?
> >
> This irq shouldn't fire unless RX_STAT register has some non-zero value.

You claim this interrupt handler using IRQF_SHARED - what if another user
of this interrupt gets stuck?  Your handler above will prevent the kernel
recovering as it will think that you are validly processing the stuck
interrupt each time.

If it isn't shared, then don't use IRQF_SHARED.

Either way, it is good practice to return IRQ_NONE if there's no work to
be done.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
