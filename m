From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 29 Jul 2015 11:34:05 +0200
Subject: [PATCHv4 2/6] dmaengine: mv_xor: add suspend/resume support
In-Reply-To: <20150722051011.GQ23525@localhost>
References: <1436365699-6862-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1436365699-6862-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150722051011.GQ23525@localhost>
Message-ID: <20150729113405.2b337ae0@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod,

On Wed, 22 Jul 2015 10:40:11 +0530, Vinod Koul wrote:

> > +static int mv_xor_suspend(struct platform_device *pdev, pm_message_t state)
> > +{
> > +	struct mv_xor_device *xordev = platform_get_drvdata(pdev);
> > +	int i;
> > +
> > +	for (i = 0; i < MV_XOR_MAX_CHANNELS; i++) {
> > +		struct mv_xor_chan *mv_chan = xordev->channels[i];
> > +
> > +		if (!mv_chan)
> > +			continue;
> > +
> > +		mv_chan->saved_config_reg =
> > +			readl_relaxed(XOR_CONFIG(mv_chan));
> > +		mv_chan->saved_int_mask_reg =
> > +			readl_relaxed(XOR_INTR_MASK(mv_chan));
> this sound fine, but I am missing the suspension of the channel. If a
> transfer was active while suspend was invoked then how would this work?

There are indeed no provisions to handle this problem. Does the
dmaengine framework provide any helpers to ease with this? I have
quickly looked at other dmaengine drivers, and I haven't seen any of
them taking care of this problem. Do you have a pointer to a driver
handling this problem?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
