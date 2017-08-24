From: yong.deng@magewell.com (Yong)
Date: Thu, 24 Aug 2017 09:43:08 +0800
Subject: [PATCH v2 1/3] media: V3s: Add support for Allwinner CSI.
In-Reply-To: <20170823192413.y5psmcgd3ghvpkbz@flea.home>
References: <1501131697-1359-1-git-send-email-yong.deng@magewell.com>
 <1501131697-1359-2-git-send-email-yong.deng@magewell.com>
 <20170728160233.xooevio4hoqkgfaq@flea.lan>
 <20170730060801.bkc2kvm72ktixy74@tarshish>
 <20170821202145.kmxancepyq55v3o2@flea.lan>
 <20170823104118.b4524830e4bb767d7714772c@magewell.com>
 <20170823192413.y5psmcgd3ghvpkbz@flea.home>
Message-ID: <20170824094308.c78aab49c64f4755a7706453@magewell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Aug 2017 21:24:13 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Wed, Aug 23, 2017 at 10:41:18AM +0800, Yong wrote:
> > > > > > +static irqreturn_t sun6i_csi_isr(int irq, void *dev_id)
> > > > > > +{
> > > > > > +	struct sun6i_csi_dev *sdev = (struct sun6i_csi_dev *)dev_id;
> > > > > > +	struct regmap *regmap = sdev->regmap;
> > > > > > +	u32 status;
> > > > > > +
> > > > > > +	regmap_read(regmap, CSI_CH_INT_STA_REG, &status);
> > > > > > +
> > > > > > +	if ((status & CSI_CH_INT_STA_FIFO0_OF_PD) ||
> > > > > > +	    (status & CSI_CH_INT_STA_FIFO1_OF_PD) ||
> > > > > > +	    (status & CSI_CH_INT_STA_FIFO2_OF_PD) ||
> > > > > > +	    (status & CSI_CH_INT_STA_HB_OF_PD)) {
> > > > > > +		regmap_write(regmap, CSI_CH_INT_STA_REG, status);
> > > > > > +		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, 0);
> > > > > > +		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN,
> > > > > > +				   CSI_EN_CSI_EN);
> > > > > 
> > > > > You need to enable / disable it at every frame? How do you deal with
> > > > > double buffering? (or did you choose to ignore it for now?)
> > > > 
> > > > These *_OF_PD status bits indicate an overflow error condition.
> > > 
> > > Shouldn't we return an error code then? The names of these flags could
> > > be better too.
> > 
> > Then, where and how to deal with the error coce.
> 
> If you want to deal with FIFO overflow, I'm not sure you have anything
> to do. It means, you've been to slow to queue buffers, so I guess
> stopping the pipeline until more buffers are queued would make
> sense. And we should probably increase the sequence number while doing
> so to notify the userspace that some frames were lost.

If there is no queued buffers, the CSI must has been already stoped by
sun6i_video_frame_done. So, the FIFO overflow may only occur on some 
unpredictable conditions or something I don't know.

For sequence number, I can't actually get the number of the lost frames.

Maybe I misunderstood you. Did you mean use IRQ_RETVAL(error) instead
of IRQ_HANDLED?

> 
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com


Thanks,
Yong
