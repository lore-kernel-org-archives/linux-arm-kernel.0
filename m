From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 31 Oct 2016 19:14:13 +0100
Subject: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
In-Reply-To: <20161031154622.GB1041@n2100.armlinux.org.uk>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20161031154643eucas1p16e74053f4947f9a945f7029a52914154@eucas1p1.samsung.com>
 <20161031154622.GB1041@n2100.armlinux.org.uk>
Message-ID: <2291876.8LAt3RcuXX@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, October 31, 2016 03:46:22 PM Russell King - ARM Linux wrote:
> On Wed, Oct 26, 2016 at 07:01:12PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> > 
> > On Wednesday, July 13, 2016 04:37:31 PM Arnd Bergmann wrote:
> > > On Wednesday, July 13, 2016 12:59:23 PM CEST Bartlomiej Zolnierkiewicz wrote:
> > > > 
> > > > On Friday, July 08, 2016 10:23:48 PM Arnd Bergmann wrote:
> > > > > On Friday, July 8, 2016 5:24:41 PM CEST Bartlomiej Zolnierkiewicz wrote:
> > > > > > This patch disables deprecated IDE subsystem in assabet_defconfig
> > > > > > (no IDE host drivers are selected in this config so there is no
> > > > > > valid reason to enable IDE subsystem itself).
> > > > > > 
> > > > > > Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > > > > > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > > > 
> > > > > I think the series makes a lot of sense. I have checked your assertions
> > > > > in the changelogs and found no flaws in your logic, so I think we should
> > > > > take them all through arm-soc unless there are other concerns.
> > > > 
> > > > Thank you.
> > > > 
> > > > Should I resend everything or just patches that were not reposted yet
> > > > (the ones that were marked as RFT initially and got no feedback)?
> > > 
> > > I'd be fine with just getting a pull request with all the patches that
> > > had no negative feedback and that were not already applied (if any).
> > 
> > Here it is (sorry for taking so long).
> 
> I've just been digging in the dmesg logs from when I was using the
> Assabet+Neponset as my firewall, and it was having to use the IDE
> ide-cs driver rather than the pata pcmcia driver.
> 
> I don't recall whether the pata pcmcia driver was a problem or not,
> as the PCMCIA interface can't cope with _any_ 32-bit accesses.  I
> think PATA tries to use the "highest" possible access size by
> default...

It doesn't actually - it defaults to 16-bits for PIO data access and
you must explicitly enable 32-bits using ATA_PFLAG_PIO32 port flag
(pata_pcmcia doesn't set it so it should be okay).  Also taskfile
registers are accessed using 8-bits access by default transport
functions (which are used by pata_pcmcia).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
