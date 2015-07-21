From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 21 Jul 2015 18:48:51 +0100
Subject: [PATCH 3/6] mailbox: Add support for ST's Mailbox IP
In-Reply-To: <CABb+yY1oKJKJGnn345uzE1mnVk5kCaGTO0b4zzqojN39m2OMyg@mail.gmail.com>
References: <1437134647-28298-1-git-send-email-lee.jones@linaro.org>
 <1437134647-28298-4-git-send-email-lee.jones@linaro.org>
 <CABb+yY2nAT6V4Q8suAXRtPXrXkArGWVTAW28ts4Z3C_ybuJovA@mail.gmail.com>
 <20150721150629.GJ3061@x1>
 <CABb+yY25DC_hmuUhbEVvdEqdUnM6bJxCjBcamZBL97o=jR83Ug@mail.gmail.com>
 <20150721155253.GN3061@x1>
 <CABb+yY1oKJKJGnn345uzE1mnVk5kCaGTO0b4zzqojN39m2OMyg@mail.gmail.com>
Message-ID: <20150721174851.GP3061@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Jul 2015, Jassi Brar wrote:

> On Tue, Jul 21, 2015 at 9:22 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Tue, 21 Jul 2015, Jassi Brar wrote:
> >
> >> >
> >> >> > +static int sti_mbox_send_data(struct mbox_chan *chan, void *data)
> >> >> > +{
> >> >> > +       struct sti_channel *chan_info = chan->con_priv;
> >> >> > +       struct sti_mbox_device *mdev = chan_info->mdev;
> >> >> > +       struct sti_mbox_pdata *pdata = dev_get_platdata(mdev->dev);
> >> >> > +       unsigned int instance = chan_info->instance;
> >> >> > +       unsigned int channel = chan_info->channel;
> >> >> > +       void __iomem *base;
> >> >> > +
> >> >> > +       if (!sti_mbox_tx_is_ready(chan))
> >> >> > +               return -EBUSY;
> >> >> This is the first thing I look out for in every new driver :)  this
> >> >> check is unnecessary.
> >> >
> >> > In what way?  What if the channel is disabled or there is an IRQ
> >> > already pending?
> >> >
> >> API calls send_data() only if last_tx_done() returned true.
> >
> > I know for a fact that the 'catchers' in sti_mbox_tx_is_ready() to
> > fire, because I have triggered them.  I'd really rather keep this
> > harmless check in.
> >
> If you put some printk in send_data() and last_tx_done() you'll see
> what I mean :)
> 
> >> >> > +static const struct sti_mbox_pdata mbox_stih407_pdata = {
> >> >> > +       .num_inst       = 4,
> >> >> > +       .num_chan       = 32,
> >> >> > +       .irq_val        = 0x04,
> >> >> > +       .irq_set        = 0x24,
> >> >> > +       .irq_clr        = 0x44,
> >> >> > +       .ena_val        = 0x64,
> >> >> > +       .ena_set        = 0x84,
> >> >> > +       .ena_clr        = 0xa4,
> >> >> >
> >> >> Register offsets are parameters of the controller
> >> >
> >> > And this is a controller driver?  Not sure I get the point.
> >> >
> >> Platform_data usually carries board/platform specific parameters.
> >> Register offset "properties" are as fixed as the behavior of the
> >> controller, so they should stay inside the code, not come via
> >> platform_data.
> >
> > That's not the case for this controller.  There is nothing preventing
> > these values from changing on a new board revisions.
> >
> Hmm ... interesting! Can't see how enable/disable channel and irq
> set/clear could be effected by writing to random, but agreed upon,
> location between two processors. There ought to be some controller
> listening there?  Now I am more interested in knowing this IP :)

High level
----------

          MB0       MB1       MB2       MB3       MB4
      +---------+---------+---------+---------+---------+
INST0 |         |         |         |         |         |
      +---------+---------+---------+---------+---------+
INST1 |         |         |         |         |         |
      +---------+---------+---------+---------+---------+
INST2 |         |         |         |         |         |
      +---------+---------+---------+---------+---------+
INST3 |         |         |         |         |         |
      +---------+---------+---------+---------+---------+

Low level [each box above looks like this)
------------------------------------------

         1                                                             32        
        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
IRQ_VAL | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
IRQ_SET | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
IRQ_CLR | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
ENB_VAL | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
ENB_SET | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
ENB_CLR | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

That's it.  That's the entirety of the "IP".

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
