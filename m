From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 30 Nov 2016 12:12:55 +0200
Subject: [PATCH v7 0/8] drm: sun8i: Add DE2 HDMI video support
In-Reply-To: <20161130100545.44546ed28896cdb9768f68cd@free.fr>
References: <cover.1480414715.git.moinejf@free.fr>
 <20161129213650.uqcgekodq77wlmxs@lukather>
 <20161130100545.44546ed28896cdb9768f68cd@free.fr>
Message-ID: <2039137.LtCOH6bs2I@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Fran?ois,

On Wednesday 30 Nov 2016 10:05:45 Jean-Francois Moine wrote:
> On Tue, 29 Nov 2016 22:36:50 +0100 Maxime Ripard wrote:
> > On Tue, Nov 29, 2016 at 11:18:35AM +0100, Jean-Francois Moine wrote:
> > > This patchset series adds HDMI video support to the Allwinner
> > > sun8i SoCs which include the display engine 2 (DE2).
> > > The driver contains the code for the A83T and H3 SoCs, and
> > > some H3 boards, but it could be used/extended for other SoCs
> > > (A64, H2, H5) and boards (Banana PIs, Orange PIs).
> > 
> > Honestly, I'm getting a bit worried by the fact that you ignore
> > reviews.
> > 
> > On the important reviews that you got that are to be seen as major
> > 
> > issues that block the inclusion, we have:
> >   - The fact that the HDMI driver is actually just a designware IP,
> >     and while you should use the driver that already exists, you just
> >     duplicated all that code.
> 
> The DW registers in the A83T and H3 are obfuscated, so, the code in
> bridge/DW cannot be used as it is. There should be either a translation
> table or a function to compute the register addresses.

Jernej mentioned there could be a way to restore the original Synopsys memory 
map. If that works then using the dw-hdmi could be an option.

> More, it is not sure that the bridge/DW code would work with Allwinner's
> SoCs.

If it doesn't work and can't be made to work in a non-invasive way they it 
should certainly not be used :-)

> It seems that they got some schematics from DesignWare, but, is it really
> the same hardware?

That's not really relevant, as long as the hardware is compatible, it doesn't 
matter if it's a Synopsys IP or a custom implementation of the HDMI TX with a 
compatible interface.

> Also, if some changes had to be done in the bridge code, I could not check
> if this would break or not the other SoCs.

Nothing new here, all drivers that support multiple SoCs have the same 
problem. That's why we have maintainers, testers and board farms to try and 
catch issues as early as possible.

> Eventually, I went the same way as omap/hdmi5: different driver.

I might try to fix that for OMAP5 at some point, we'll see.

> >   - The fact that you ignored Rob (v6) and I (v5) comment on using OF
> >     graph to model the connection between the display engine and the
> >     TCON. Something that Laurent also pointed out in this version.
> 
> I simply use the drm function drm_of_component_probe().
> If this one is in the DRM core, why should I not use it?
> If it must not be used, it would be nice to mark it as deprecated and
> to update the code of the drivers which are using it.

I haven't used that function so I can't comment here, except for the fact that 
DT bindings are not designed based on a given OS implementation. It should be 
the other way around, the bindings should be designed to clearly describe the 
hardware in a clean and consistent way that can be used by any host software, 
and the Linux helper functions should then be developed based on those 
bindings.

> >   - The fact that you ignored that you needed an HDMI connector node
> >     as a child of the HDMI controller. This has been reported by Rob
> >     (v6) and yet again in this version by Laurent.
> 
> As I don't know what is a DT 'connector', I cannot go further.
> I hope Laurent will give me clearer explanations and a real example.

Done, we can discuss this in that part of the mail thread.

> >   - And finally the fact that we can't have several display engine in
> >     parallel, if needs be. This has happened in the past already on
> >     Allwinner SoCs, so it's definitely something we should consider in
> >     the DT bindings, since we can't break them.
> 
> IIRC, I proposed my driver before yours, and the DE2 is completely
> different from the other display engines.
> What you are telling is "add more code to already complex code and have
> a big driver for all SoCs in each kernels".
> I think it should be better to have small modules, each one treating
> specific hardware, and to let only the needed code in the kernel memory
> at startup time.
> 
> > Until those are fixed, I cannot see how this driver can be merged,
> > unfortunately.
> 
> No problem. I just wanted to help people by giving the job I did on the
> boards I have. My boards are working for almost one year, fine enough
> for I use them as daily desktop computers. I don't want to spend one
> more year for having my code in the Linux kernel: there are so much
> other exciting things to do...

And you're certainly welcome to contribute drivers to the kernel, that's 
always appreciated. Of course, to ensure a reasonable level of quality and 
consistency between drivers, the review process often requires changes to be 
made to the code being submitted. When it comes to drivers I mostly pay 
attention to DT bindings, userspace APIs and modification to common code. 
Driver code itself, as long as it's reasonably clean and doesn't impede 
development of other drivers or impact system security in an adverse way, is 
still important but maybe slightly less so. I'll defer to Maxime to come to an 
agreement on the multiple display engines in parallel problem as I'm not 
familiar with it for the Allwinner platforms.

-- 
Regards,

Laurent Pinchart
