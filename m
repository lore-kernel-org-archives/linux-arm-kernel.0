From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 1 Jul 2013 23:21:37 +0800
Subject: [v2 4/4] sata: imx: add ahci sata support on imx platforms
In-Reply-To: <20130701133611.GB11408@mtj.dyndns.org>
References: <1372672975-2997-1-git-send-email-r65037@freescale.com>
 <1372672975-2997-5-git-send-email-r65037@freescale.com>
 <20130701133611.GB11408@mtj.dyndns.org>
Message-ID: <20130701152135.GV13206@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 06:36:11AM -0700, Tejun Heo wrote:
> On Mon, Jul 01, 2013 at 06:02:55PM +0800, Richard Zhu wrote:
> > imx6q contains one Synopsys AHCI SATA controller,
> > But it can't shares ahci_platform driver with other
> > controllers.
> > Because there are some misalignments of the bits
> > definitions of the HBA registers and the Vendor
> > Specific registers
> >  - CAP_SSS(bit20) of the HOST_CAP is writable, default
> >  value is '0', should be configured to be '1'
> >  - bit0 (only one AHCI SATA port on imx6q) of the
> >  HOST_PORTS_IMPL should be set to be '1'.(default 0)
> >  - One Vendor Specific register HOST_TIMER1MS(offset:0xe0)
> >  should be configured regarding to the frequency of AHB
> >  bus clock.
> 
> If these are the only differences, can't you make ahci_platform deal
> with different variants?  That's how we deal with subtly different
> variants of about the same controllers.

There are more:

 - There is an additional phy clock to manage
 - There are some i.MX SoC integration level registers to set up

I prefer to that we reuse the generic ahci_platform stuff, and handle
the differences in a sata_imx.c via pdata->init() interface.

Shawn
