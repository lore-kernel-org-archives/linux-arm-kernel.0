From: B29397@freescale.com (Chen Peter-B29397)
Date: Thu, 20 Sep 2012 02:56:18 +0000
Subject: [PATCH 0/4] Add PHY nofity for some i.mx SoCs
In-Reply-To: <CAEOSq-NZNo-dyEO5+hjcF9VEjbBdf0GVXcVRDC-6zThLAu+2aQ@mail.gmail.com>
References: <1347592731-12998-1-git-send-email-peter.chen@freescale.com>
 <CAEOSq-NZNo-dyEO5+hjcF9VEjbBdf0GVXcVRDC-6zThLAu+2aQ@mail.gmail.com>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803C86036@039-SN2MPN1-022.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> -----Original Message-----
> From: Mike Thompson [mailto:mpthompson at gmail.com]
> Sent: Thursday, September 20, 2012 3:58 AM
> To: Chen Peter-B29397
> Cc: stern at rowland.harvard.edu; balbi at ti.com;
> alexander.shishkin at linux.intel.com; Zhao Richard-B20223; snijsure at grid-
> net.com; Estevam Fabio-R49496; marex at denx.de; gregkh at linuxfoundation.org;
> linux-usb at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 0/4] Add PHY nofity for some i.mx SoCs
> 
> Tested on OLinuXino-Micro imx233 based hardware with patches applied
> against 'linux-next' branch.
> 
> Tested-by: Mike Thompson <mpthompson@gmail.com>
> 

Hi Felipe, how about the first and second patches in this patchset?
Alex, how about the third patch in this patchset?
Alan, how about the fourth patch in this patset?

Thanks,
Peter 


> Mike Thompson
> 
> On Thu, Sep 13, 2012 at 8:18 PM, Peter Chen <peter.chen@freescale.com>
> wrote:
> > At some i.mx SoCs, when controller works at host mode, the PHY
> > register needs to be changed at device connect, disconnect, bus
> > suspend and resume due to the SoC limitations.
> >
> > The phy notification should be added according to below rules:
> >
> > 1. Only set HW_USBPHY_CTRL.ENHOSTDISCONDETECT
> > during high speed host mode.
> > 2. Do not set HW_USBPHY_CTRL.ENHOSTDISCONDETECT
> > during the reset and speed negotiation period.
> > 3. Do not set HW_USBPHY_CTRL.ENHOSTDISCONDETECT
> > during host suspend/resume sequence.
> >
> > Please refer: i.mx23RM(page 413) for detail.
> > http://www.freescale.com/files/dsp/doc/ref_manual/IMX23RM.pdf
> >
> > Freescale i.MX SoC, i.mx23, i.mx28 and i.mx6(i.mx6SL does not
> > need to follow the 3rd rule) need to follow above rules.
> >
> > The correct notification setting method should be:
> > 1. Set connect notify after the second bus reset.
> > 2. Set disconnect notify after disconnection.
> > 3. Set suspend nofity after bus goes to suspend (portsc.suspendM=1).
> > 4. Set resume notify after resume (portsc.fpr=0).
> >
> > Peter Chen (4):
> >   usb: phy: add notify_suspend/notify_resume callback
> >   usb: mxs-phy: implement notify_suspend/notify_resume callback
> >   usb: chipidea: add phy notify at suspend/resume procedure
> >   usb: refine phy notify operation during connection and disconnection
> >
> >  drivers/usb/chipidea/host.c |   75
> +++++++++++++++++++++++++++++++++++++++++-
> >  drivers/usb/core/hub.c      |   14 ++++----
> >  drivers/usb/otg/mxs-phy.c   |   56 +++++++++++++++++++++++++-------
> >  include/linux/usb/phy.h     |   44 +++++++++++++++++++++----
> >  4 files changed, 161 insertions(+), 28 deletions(-)
> >
