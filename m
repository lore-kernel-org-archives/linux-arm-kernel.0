From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 01 Dec 2016 11:19:56 +0200
Subject: [PATCH v7 0/8] drm: sun8i: Add DE2 HDMI video support
In-Reply-To: <20161201091313.th7nucjmvtuolqza@lukather>
References: <cover.1480414715.git.moinejf@free.fr> <2039137.LtCOH6bs2I@avalon>
 <20161201091313.th7nucjmvtuolqza@lukather>
Message-ID: <2084988.kISO4Quil7@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Thursday 01 Dec 2016 10:13:13 Maxime Ripard wrote:
> On Wed, Nov 30, 2016 at 12:12:55PM +0200, Laurent Pinchart wrote:
> >> More, it is not sure that the bridge/DW code would work with Allwinner's
> >> SoCs.
> > 
> > If it doesn't work and can't be made to work in a non-invasive way they it
> > should certainly not be used :-)
> 
> Even if the register layout is completely scrambled, as long as the
> bits themselves aren't (and by comparing the two drivers it looks like
> they haven't changed), you can easily deal with that using the
> regmap_fields, with the two implementations (the original one and the
> scrambled one) providing their register map that way, and the driver
> code using whatever has been provided.

Looking at https://linux-sunxi.org/DWC_HDMI_Controller#DWC_HDMI_Controller it 
seems that an address remapping function could be used.

> >> Eventually, I went the same way as omap/hdmi5: different driver.
> > 
> > I might try to fix that for OMAP5 at some point, we'll see.
> 
> For complex drivers that have already a driver written and a lot of
> testing that already happened, I don't think duplication is a smart
> move.
> 
> >>>   - And finally the fact that we can't have several display engine in
> >>>     parallel, if needs be. This has happened in the past already on
> >>>     Allwinner SoCs, so it's definitely something we should consider in
> >>>     the DT bindings, since we can't break them.
> >> 
> >> IIRC, I proposed my driver before yours, and the DE2 is completely
> >> different from the other display engines.
> >> What you are telling is "add more code to already complex code and have
> >> a big driver for all SoCs in each kernels".
> >> I think it should be better to have small modules, each one treating
> >> specific hardware, and to let only the needed code in the kernel memory
> >> at startup time.
> >> 
> >>> Until those are fixed, I cannot see how this driver can be merged,
> >>> unfortunately.
> >> 
> >> No problem. I just wanted to help people by giving the job I did on the
> >> boards I have. My boards are working for almost one year, fine enough
> >> for I use them as daily desktop computers. I don't want to spend one
> >> more year for having my code in the Linux kernel: there are so much
> >> other exciting things to do...
> > 
> > And you're certainly welcome to contribute drivers to the kernel, that's
> > always appreciated. Of course, to ensure a reasonable level of quality and
> > consistency between drivers, the review process often requires changes to
> > be made to the code being submitted. When it comes to drivers I mostly
> > pay attention to DT bindings, userspace APIs and modification to common
> > code. Driver code itself, as long as it's reasonably clean and doesn't
> > impede development of other drivers or impact system security in an
> > adverse way, is still important but maybe slightly less so. I'll defer to
> > Maxime to come to an agreement on the multiple display engines in
> > parallel problem as I'm not familiar with it for the Allwinner platforms.
> 
> The earlier Allwinner SoCs (with the old display engine), we had some
> SoCs with multiple instances of the display engine and TCON (the
> display engine roughly implementing the planes, the TCON the
> CRTC. Roughly.). However, those were sharing some encoders (HDMI,
> DSI) after that.
> 
> So we need to have a single DRM device taking care of the multiple
> display engines, which essentialy means that we have to decouple the
> DRM device from the display engine. This was done in the earlier
> designs using an additional node with a list of phandles to the
> display engines in the system, and obviously, I'd prefer to have some
> consistency and reuse the same thing.
> 
> But the current approach doesn't work and will require some DT
> modifications if that case happens again, which we can't do because of
> the DT ABI.

-- 
Regards,

Laurent Pinchart
