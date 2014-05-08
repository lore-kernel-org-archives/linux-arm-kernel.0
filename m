From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 May 2014 22:19:49 -0500
Subject: [PATCH v7] DMA: sun6i: Add driver for the Allwinner A31 DMA
 controller
In-Reply-To: <20140502163429.GA32284@intel.com>
References: <20140430070408.GR32284@intel.com> <20140430215322.GH3000@lukather>
 <20140502163429.GA32284@intel.com>
Message-ID: <20140508031949.GQ7047@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 10:04:29PM +0530, Vinod Koul wrote:
> On Wed, Apr 30, 2014 at 02:53:22PM -0700, Maxime Ripard wrote:
> > Hi Vinod,
> > 
> > On Wed, Apr 30, 2014 at 12:34:08PM +0530, Vinod Koul wrote:
> > > On Thu, Apr 24, 2014 at 04:22:44PM +0200, Maxime Ripard wrote:
> > > > +static inline void sun6i_dma_free(struct sun6i_dma_dev *sdc)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < NR_MAX_VCHANS; i++) {
> > > > +		struct sun6i_vchan *vchan = &sdc->vchans[i];
> > > > +
> > > > +		list_del(&vchan->vc.chan.device_node);
> > > > +		tasklet_kill(&vchan->vc.task);
> > > > +	}
> > > > +
> > > > +	tasklet_kill(&sdc->task);
> > > This is again not good. see http://lwn.net/Articles/588457/
> > > At this point HW can still generate interrupts or you can have irq running!
> > 
> > I'm not sure to fully understand the issue here, but what is not good?
> > the first or the second tasklet_kill calls, or both?
> > 
> > From what I understood, the issue is only there whenever you are
> > calling tasklet_disable without making sure that no one will schedule
> > your tasklet before disabling it.
> > 
> > But the point is I don't actually use either _enable/_disable. I might
> > be wrong in not using those functions, but I don't really see how I
> > can be impacted.
> 
> Well that was one part of it. How do you ensure the tasklet is not scheduled
> while and after you are killing it. You need to ensure irq is disabled and pending irqs
> have finished processing. I dont see that bit.

Ok. I'll change that.

Do you want me to use tasklet_enable and tasklet_disable as well?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140507/86ae662c/attachment.sig>
