From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Oct 2015 14:26:38 +0100
Subject: [RFC PATCH v2 1/4] drm: Introduce generic probe function for
 component based masters.
In-Reply-To: <20151019130258.GU3394@e106497-lin.cambridge.arm.com>
References: <1445257313-7147-1-git-send-email-Liviu.Dudau@arm.com>
 <1445257313-7147-2-git-send-email-Liviu.Dudau@arm.com>
 <20151019122537.GZ32532@n2100.arm.linux.org.uk>
 <20151019130258.GU3394@e106497-lin.cambridge.arm.com>
Message-ID: <20151019132638.GB32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 02:02:58PM +0100, Liviu Dudau wrote:
> On Mon, Oct 19, 2015 at 01:25:37PM +0100, Russell King - ARM Linux wrote:
> > Please don't move this into here, it's completely inappropriate.  Just
> > because something makes use of this does not mean they only support
> > 32-bit DMA.  Besides, this has nothing to do with whether or not it's
> > OF-based or not.
> 
> Understood. My thinking process was that component-based drivers are all
> OF-enabled (how else do you make use of the framework?) and 32-bit DMA is
> present in 2 out of 3 drivers that are converted, so it looks to be common
> enough that adding it to armada would not hurt. It was all done in the name of
> collecting common code in a single function.

Which is an utterly crap reason.

It's also not appropriate.  I'm really not sure why you think that moving
this here would in any way be appropriate - from my point of view, the
mere proposal is utterly insane.

The "container" device does not do any DMA, so it's inappropriate for
it to have DMA masks set or negotiated on it.  So, actually, no one
should be setting the DMA mask for their container device.  It's wrong.

What if we have a 64-bit OF based platform wanting to use the component
helper, and they want to call this function?  You prevent them doing so
by moving this into here, because they're then forced down to 32-bit DMA.
Please, get rid of it, and leave this crappiness in the respective
drivers.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
