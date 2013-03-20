From: bhutchings@solarflare.com (Ben Hutchings)
Date: Wed, 20 Mar 2013 19:09:17 +0000
Subject: [PATCH v3 1/1 net-next] NET: FEC: dynamtic check DMA desc buff
 type
In-Reply-To: <1363800515.2677.13.camel@bwh-desktop.uk.solarflarecom.com>
References: <1357265063-30528-1-git-send-email-Frank.Li@freescale.com>
 <20130320160418.GG20530@pengutronix.de>
 <1363800515.2677.13.camel@bwh-desktop.uk.solarflarecom.com>
Message-ID: <1363806557.2677.19.camel@bwh-desktop.uk.solarflarecom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-20 at 17:28 +0000, Ben Hutchings wrote:
> On Wed, 2013-03-20 at 17:04 +0100, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > On Fri, Jan 04, 2013 at 10:04:23AM +0800, Frank Li wrote:
> > > MX6 and mx28 support enhanced DMA descriptor buff to support 1588
> > > ptp. But MX25, MX3x, MX5x can't support enhanced DMA descriptor buff.
> > > Check fec type and choose correct DMA descriptor buff type.
> > > 
> > > Remove static config CONFIG_FEC_PTP.
> > > ptp function will be auto detected.
> > Your patch (now as ff43da86c69d76a726ffe7d1666148960dc1d108 in v3.9-rc1)
> > breaks building with CONFIG_FEC=m:
> > 
> > 	ERROR: "fec_ptp_init" [drivers/net/ethernet/freescale/fec.ko] undefined!
> > 	ERROR: "fec_ptp_ioctl" [drivers/net/ethernet/freescale/fec.ko] undefined!
> > 	ERROR: "fec_ptp_start_cyclecounter" [drivers/net/ethernet/freescale/fec.ko] undefined!
> > 
> > IMHO you should build fec.o and fec_ptp.o into the same module as they
> > cannot live without each other anyhow.
> 
> They are in the same module.  So I don't see how that error is possible.

Sorry, I misread the Makefile.  They are either both built as modules or
both built-in, but they are separate modules.

Ben.

> > Having said I wonder if it would be worthwile to support FEC without
> > PTP_1588_CLOCK. For example make the above three functions static
> > inlines if CONFIG_PTP_1588_CLOCK=n and drop the select on the latter.
> 
> See previous discussions:
> <http://thread.gmane.org/gmane.linux.kernel/1363200/focus=1376659>,
> <http://thread.gmane.org/gmane.linux.network/247963>,
> <http://thread.gmane.org/gmane.linux.network/247823/focus=248173>
> 
> Ben.
> 

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
