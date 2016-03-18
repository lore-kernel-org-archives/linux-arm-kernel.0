From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 18 Mar 2016 09:54:14 +0800
Subject: [PATCH] usb: chipidea: Configure DMA properties and ops from DT
In-Reply-To: <3240370.XdEELlSA8f@wuerfel>
References: <1456119133-16114-1-git-send-email-bjorn.andersson@linaro.org>
 <CADRPPNRTXiiVzbqmpX7h_af7Q+qw+-ZB3zDb0855a1U=CmWh-A@mail.gmail.com>
 <20160314105108.GB2131@shlinux2.ap.freescale.net>
 <3240370.XdEELlSA8f@wuerfel>
Message-ID: <20160318015414.GA30851@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 04:52:55PM +0100, Arnd Bergmann wrote:
> On Monday 14 March 2016 18:51:08 Peter Chen wrote:
> > On Wed, Mar 09, 2016 at 05:16:50PM -0600, Li Yang wrote:
> > > On Tue, Mar 8, 2016 at 9:40 PM, Bjorn Andersson
> > > <bjorn.andersson@linaro.org> wrote:
> > > > On Tue, Mar 8, 2016 at 11:52 AM, Li Yang <leoli@freescale.com> wrote:
> > > >> On Wed, Mar 2, 2016 at 4:59 PM, Li Yang <leoli@freescale.com> wrote:
> > > >>> On Mon, Feb 22, 2016 at 4:07 PM, Bjorn Andersson
> > > >>> <bjorn.andersson@linaro.org> wrote:
> > > >>>> On Mon 22 Feb 02:03 PST 2016, Srinivas Kandagatla wrote:
> > > >
> > > > I had the chance to go through this with Arnd and the verdict is that
> > > > devices not described in DT should not do DMA (or allocate buffers for
> > > > doing DMA).
> > > >
> > > > So I believe the solution is to fall back on Peter's description; the
> > > > chipidea driver is the core driver and the Qualcomm code should just
> > > > be a platform layer.
> > > >
> > > > My suggestion is that we turn the chipidea core into a set of APIs
> > > > that can called by the platform specific pieces. That way we will have
> > > > the chipidea core be the device described in the DT.
> > > 
> > > But like I said, this problem is not just existing for chipidea
> > > driver.  We already found that the dwc3 driver is also suffering from
> > > the same issue.  I don't know how many other drivers are impacted by
> > > this change, but I suspect there will be some. A grep of
> > > platform_device_add() in driver/ directory returns many possible
> > > drivers to be impacted.  As far as I know, the
> > > drivers/net/ethernet/freescale/fman/mac.c is registering child
> > > ethernet devices that definitely will do dma.   If you want to do this
> > > kind of rework to all these drivers, it will be a really big effort.
> > > 
> > 
> > +1
> > 
> > Yes, I think this DMA things should be covered by driver core too.
> > 
> 
> I don't think it's a very widespread problem, there are only very few
> developers that intentionally use this method, and some use the
> platform_device_register_full() call to create a device with a known
> mask, which is generally ok for the limited case where the driver
> is only ever going to run on a single platform, but not in the
> more general case that of_dma_configure is designed to handle.

Even only for qualcomm platforms, it may be possible have different
DMA masks at ARM64 platforms, so we may can't use a fixed value
at glue layer driver. So, using of_dma_configure is suitable choice
for DT platforms for this case, right?

> 
> I think we should fix the drivers to consistently use the device
> that was created by the platform (DT or ACPI or board file)
> to pass that into the DMA API, anything else will just cause
> more subtle bugs.
> 

Although I don't know what kinds of bugs it may have, it may be
met before, otherwise, why most of platform drivers need to call
dma_set_coherent_mask or dma_coerce_mask_and_coherent explicitly

-- 

Best Regards,
Peter Chen
