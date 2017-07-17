From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jul 2017 13:05:13 +0100
Subject: [PATCH 2/4] drm/bridge: dw-hdmi: add cec notifier support
In-Reply-To: <e80b0213-7632-faf4-5d57-06509912990d@xs4all.nl>
References: <20170530142218.GS22219@n2100.armlinux.org.uk>
 <E1dFi3E-0004lh-Pu@rmk-PC.armlinux.org.uk>
 <0c2c4988-37bb-fd01-efee-c6878cc53923@baylibre.com>
 <20170609133822.GR4902@n2100.armlinux.org.uk>
 <5b2fdadd-f1fa-c454-b3fe-facf221beb78@baylibre.com>
 <20170609141056.GS4902@n2100.armlinux.org.uk>
 <b46f25c1-45fd-2917-6559-218f6887a882@xs4all.nl>
 <20170717090516.GJ31807@n2100.armlinux.org.uk>
 <e80b0213-7632-faf4-5d57-06509912990d@xs4all.nl>
Message-ID: <20170717120513.GK31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 01:39:48PM +0200, Hans Verkuil wrote:
> On 17/07/17 11:05, Russell King - ARM Linux wrote:
> > On Mon, Jul 17, 2017 at 10:56:47AM +0200, Hans Verkuil wrote:
> >> Hi Russell,
> >>
> >> On 09/06/17 16:10, Russell King - ARM Linux wrote:
> >>> On Fri, Jun 09, 2017 at 03:56:39PM +0200, Neil Armstrong wrote:
> >>>> Yes, but on the Amlogic Meson plarform, the DW-HDMI CEC controller is
> >>>> not used, but a custom one, so this notifier is actually useful for
> >>>> this platform and maybe others.
> >>>
> >>> Is the CEC controller configured into dw-hdmi (is the config bit set?)
> >>> I'm just wondering if we're going to end up with two CEC drivers trying
> >>> to bind to the same notifier.
> >>>
> >>>> Should we really wait until I push the Amlogic AO CEC driver ? Having a
> >>>> notifier in the DW-HDMI driver won't harm anybody since it *will be used*.
> >>>
> >>> It sounds like this adds additional information that has been missing
> >>> from the review of my patches - and I suspect changes Hans' comments.
> >>> So, I'll wait, it seems pointless to try and update the patches when
> >>> it's not clear how to proceed due to other dependencies, especially
> >>> when it means that their existing state is what's required (I'm pleased
> >>> that I've held off modifying the patches so far.)
> >>>
> >>> If that means having to wait another kernel revision, then I guess that's
> >>> what will have to happen.
> >>
> >> Can you respin your patch series, keeping the notifier support? The CEC
> >> kernel config handling has been cleaned up (just select CEC_CORE and
> >> CEC_NOTIFIER) so you should be good to go.
> > 
> > Not yet - the change to the way you're dealing with Kconfig in CEC is
> > fundamentally broken, and needs fixing before we can merge dw-hdmi-cec
> > support.
> > 
> > As a result of these Kconfig changes, dw-hdmi-cec now fails if:
> > 
> > 1. You build the CEC part as a module
> > 2. You build the HDMI part into the kernel
> > 
> > This results in CEC_NOTIFIER=y and CEC_CORE=m, which, when the HDMI part
> > gets built, results in the stubs in the notifier code being used, rather
> > than the real functions.  This in turn causes the CEC part to never
> > receive a physical address, which is therefore non-functional.
> > 
> > I did have a patch to fix this, but it was never committed, and I got
> > busy with other stuff (so it ended up being git reset --hard away.)
> > 
> 
> This is more a DRM_DW_HDMI issue than a CEC issue IMHO.
> 
> This will fix this:
> 
> config DRM_DW_HDMI
>         tristate
>         select DRM_KMS_HELPER
>         select REGMAP_MMIO
>         select CEC_CORE if CEC_NOTIFIER			<<<<<<
> 
> config DRM_DW_HDMI_CEC
>         tristate "Synopsis Designware CEC interface"
>         depends on DRM_DW_HDMI
>         select CEC_CORE
>         select CEC_NOTIFIER
>         help
>           Support the CE interface which is part of the Synopsis
>           Designware HDMI block.
> 
> This makes sense: if DRM_DW_HDMI_CEC is disabled but another CEC module is
> used instead (as is apparently the case for amlogic), then the
> 
> 	select CEC_CORE if CEC_NOTIFIER
> 
> line ensures that CONFIG_CEC_CORE has the right m/y value.

I disagree with this approach.

If DRM_DW_HDMI=y and DRM_DW_HDMI_CEC=n, but some other driver is enabled
that selects CEC_NOTIFIER, then we end up with CEC_CORE forced enabled
through dw-hdmi, even though we haven't asked for the CEC part to be
enabled.

You might as well have CEC_NOTIFIER itself select CEC_CORE, and be done
with it, because that's basically what this boils down to.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
