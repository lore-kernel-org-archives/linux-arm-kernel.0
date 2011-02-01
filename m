From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 1 Feb 2011 12:44:54 +0100
Subject: [PATCH 3/9] Add a mfd IPUv3 driver
In-Reply-To: <20110201105909.GS9041@pengutronix.de>
References: <1292842127-21406-1-git-send-email-s.hauer@pengutronix.de>
	<1292842127-21406-4-git-send-email-s.hauer@pengutronix.de>
	<20110201105127.GA10128@sortiz-mobl>
	<20110201105909.GS9041@pengutronix.de>
Message-ID: <20110201114453.GC10128@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 11:59:09AM +0100, Sascha Hauer wrote:
> On Tue, Feb 01, 2011 at 11:51:28AM +0100, Samuel Ortiz wrote:
> > Hi Sascha,
> > 
> > On Mon, Dec 20, 2010 at 11:48:41AM +0100, Sascha Hauer wrote:
> > > The IPU is the Image Processing Unit found on i.MX50/51/53 SoCs. It
> > > features several units for image processing, this patch adds support
> > > for the units needed for Framebuffer support, namely:
> > > 
> > > - Display Controller (dc)
> > > - Display Interface (di)
> > > - Display Multi Fifo Controller (dmfc)
> > > - Display Processor (dp)
> > > - Image DMA Controller (idmac)
> > > 
> > > This patch is based on the Freescale driver, but follows a different
> > > approach. The Freescale code implements logical idmac channels and
> > > the handling of the subunits is hidden in common idmac code pathes
> > > in big switch/case statements. This patch instead just provides code
> > > and resource management for the different subunits. The user, in this
> > > case the framebuffer driver, decides how the different units play
> > > together.
> > > 
> > > The IPU has other units missing in this patch:
> > > 
> > > - CMOS Sensor Interface (csi)
> > > - Video Deinterlacer (vdi)
> > > - Sensor Multi FIFO Controler (smfc)
> > > - Image Converter (ic)
> > > - Image Rotator (irt)
> > > 
> > > So expect more files to come in this directory.
> > I couldn't look into details as the patch is huge, but it looks mostly good.
> > One thing I don't really like is the
> > 
> > +static struct device *ipu_dev;
> > +void __iomem *ipu_cm_reg;
> > +void __iomem *ipu_idmac_reg;
> > 
> > part. I know there is currently no HW supporting more than one of those
> > controllers, but as a general principle I find this is not a good programming
> > habit.
> 
> Ok, will look into it.
> 
> > 
> > Now, on a less technical note: I don't really see how this driver fits in the
> > MFD category, unless the upcoming units support brings something new. If I
> > were looking for the i.MX5x image processing unit, I would be looking under
> > drivers/video/.
> 
> The ipu unit also supports cameras which would go to drivers/media/video.
> This is the original reason for putting it into drivers/mfd. 
Ok, makes a bit more sense.

> That said,
> I'm not very comfortable with putting it there, mostly because it
> contains a lot of code to which a mfd maintainer can hardly say anything
> to 
I won't argue with that :)
I'm not really confortable with it neither, even though the code looks nice
and I'm quite sure you're committed to maintaining it in the long term.

> and because it's one framework more which has to synchronized when
> changes to the IPU come.
Ok, so would moving it do drivers/video/ make sense ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
