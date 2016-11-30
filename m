From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 30 Nov 2016 10:08:35 +0200
Subject: [PATCH v7 0/8] drm: sun8i: Add DE2 HDMI video support
In-Reply-To: <239b60f3-3ea7-4aa7-8e8d-353e1a1d4ee5@googlegroups.com>
References: <cover.1480414715.git.moinejf@free.fr> <2256264.6LWGGhFAiO@avalon>
 <239b60f3-3ea7-4aa7-8e8d-353e1a1d4ee5@googlegroups.com>
Message-ID: <3152670.pRMCOA29o4@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jernej,

On Tuesday 29 Nov 2016 15:24:25 Jernej Skrabec wrote:
> Dne torek, 29. november 2016 23.56.31 UTC+1 je oseba Laurent Pinchart
> napisala:
> > On Tuesday 29 Nov 2016 14:47:20 Jernej Skrabec wrote:
> >> Dne torek, 29. november 2016 22.37.03 UTC+1 je oseba Maxime Ripard
> > napisala:
> >>> On Tue, Nov 29, 2016 at 11:18:35AM +0100, Jean-Francois Moine wrote:
> >>>> This patchset series adds HDMI video support to the Allwinner
> >>>> sun8i SoCs which include the display engine 2 (DE2).
> >>>> The driver contains the code for the A83T and H3 SoCs, and
> >>>> some H3 boards, but it could be used/extended for other SoCs
> >>>> (A64, H2, H5) and boards (Banana PIs, Orange PIs).
> >>> 
> >>> Honestly, I'm getting a bit worried by the fact that you ignore
> >>> reviews.
> >>> 
> >>> On the important reviews that you got that are to be seen as major
> >>> issues that block the inclusion, we have:
> >>>   - The fact that the HDMI driver is actually just a designware IP,
> >>>     and while you should use the driver that already exists, you just
> >>>     duplicated all that code.
> >> 
> >> That might be hard thing to do. A83T fits perfectly, but H3 and newer
> >> SoCs do not. They are using completely different HDMI phy. Decoupling
> >> controller and phy code means rewritting a good portion of the code,
> >> unless some tricks are applied, like calling phy function pointers, if
> >> they are defined.
> > 
> > Same HDMI TX but different HDMI TX PHY ? Kieran is working on decoupling
> > the PHY configuration code for a Renesas SoC, that might be of interest to
> > you.
> 
> Exactly. I'm developing only U-Boot driver, but Jean-Francois will probably
> have more interest in this.

We'll post patches as soon as they're ready.

By the way, do you know if the H3 and newer SoCs use a different PHY from 
Synopsys, or a custom PHY developed by Allwinner ?

> >> Register addresses also differ, but that can be easily solved by using
> >> undocumented magic value to restore them.
> > 
> > I love that :-)
> 
> Is it allowed to use magic number which was found in binary blob? I'm new in
> all this.

I don't really see a problem with that, we have many drivers in the kernel 
that have been developed through reverse-engineering. You should not include 
large pieces of code that have been obtained through decompilation of a 
proprietary binary blob as those could be protected by copyright, but writing 
to undocumented registers based on information found through usage of a binary 
driver isn't a problem. (Please remember that I'm not a lawyer though)

> >>>   - The fact that you ignored Rob (v6) and I (v5) comment on using OF
> >>>     graph to model the connection between the display engine and the
> >>>     TCON. Something that Laurent also pointed out in this version.
> >>>   
> >>>   - The fact that you ignored that you needed an HDMI connector node
> >>>     as a child of the HDMI controller. This has been reported by Rob
> >>>     (v6) and yet again in this version by Laurent.
> >>>   
> >>>   - And finally the fact that we can't have several display engine in
> >>>     parallel, if needs be. This has happened in the past already on
> >>>     Allwinner SoCs, so it's definitely something we should consider in
> >>>     the DT bindings, since we can't break them.
> >>> 
> >>> Until those are fixed, I cannot see how this driver can be merged,
> >>> unfortunately.

-- 
Regards,

Laurent Pinchart
