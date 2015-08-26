From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 26 Aug 2015 13:52:29 +0200
Subject: [PATCH 1/7] drm/vc4: Add devicetree bindings for VC4.
In-Reply-To: <CAF6AEGu2fi0M7DsicHz+5SDHi1DyDRmvWjkmYPPgY6pZ423WcA@mail.gmail.com>
References: <1439427380-2436-1-git-send-email-eric@anholt.net>
 <1439427380-2436-2-git-send-email-eric@anholt.net>
 <55CEC25E.7070303@wwwdotorg.org>
 <874mjxwyx5.fsf@eliezer.anholt.net>
 <CAL_JsqJxiGUR5BxBPyR3-0NxqWsOxMGrWQA6cMXe2pjTom__nw@mail.gmail.com>
 <CAF6AEGu2fi0M7DsicHz+5SDHi1DyDRmvWjkmYPPgY6pZ423WcA@mail.gmail.com>
Message-ID: <20150826115229.GI1367@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 04:42:18PM -0400, Rob Clark wrote:
> On Mon, Aug 24, 2015 at 9:47 AM, Rob Herring <robherring2@gmail.com> wrote:
> > On Mon, Aug 17, 2015 at 1:30 PM, Eric Anholt <eric@anholt.net> wrote:
> >> Stephen Warren <swarren@wwwdotorg.org> writes:
> >>
> >>> On 08/12/2015 06:56 PM, Eric Anholt wrote:
> >>>> Signed-off-by: Eric Anholt <eric@anholt.net>
> >>>
> >>> This one definitely needs a patch description, since someone might not
> >>> know what a VC4 is, and "git log" won't show the text from the binding
> >>> doc itself. I'd suggest adding the initial paragraph of the binding doc
> >>> as the patch description, or more.
> >>>
> >>>> diff --git a/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt b/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt
> >>
> >>>> +- hvss:             List of references to HVS video scalers
> >>>> +- encoders: List of references to output encoders (HDMI, SDTV)
> >>>
> >>> Would it make sense to make all those nodes child node of the vc4
> >>> object. That way, there's no need to have these lists of objects; they
> >>> can be automatically built up as the DT is enumerated. I know that e.g.
> >>> the NVIDIA Tegra host1x binding works this way, and I think it may have
> >>> been inspired by other similar cases.
> >>
> >> I've looked at tegra, and the component system used by msm appears to be
> >> nicer than it.  To follow tegra's model, it looks like I need to build
> >> this extra bus thing corresponding to host1x that is effectively the
> >> drivers/base/component.c code, so that I can get at vc4's structure from
> >> the component drivers.
> >>
> >>> Of course, this is only appropriate if the HW modules really are
> >>> logically children of the VC4 HW module. Perhaps they aren't. If they
> >>> aren't though, I wonder what this "vc4" module actually represents in HW?
> >>
> >> It's the subsystem, same as we use a subsystem node for msm, sti,
> >> rockchip, imx, and exynos.  This appears to be the common model of how
> >> the collection of graphics-related components is represented in the DT.
> >
> > I think most of these bindings are wrong. They are grouped together
> > because that is what DRM wants not because that reflects the h/w. So
> > convince me this is one block, not that it is what other people do.
> 
> I think, when it comes to more complex driver subsystems (like drm in
> particular) we have a bit of mismatch between how things look from the
> "pure hw ignoring sw" perspective, and the "how sw and in particular
> userspace expects things" perspective.  Maybe it is less a problem in
> other subsystems, where bindings map to things that are only visible
> in the kernel, or well defined devices like uart or sata controller.
> But when given the choice, I'm going to err on the side of not
> confusing userspace and the large software stack that sits above
> drm/kms, over dt purity.
> 
> Maybe it would be nice to have a sort of dt overlay that adds the bits
> needed to tie together hw blocks that should be assembled into a
> single logical device for linux and userspace (but maybe not some
> other hypothetical operating system).  But so far that doesn't exist.
> All we have is a hammer (devicetree), everything looks like a nail.
> End result is we end up adding some things in the bindings which
> aren't purely about the hw.  Until someone invents a screwdriver, I'm
> not sure what else to do.  In the end, other hypothetical OS is free
> to ignore those extra fields in the bindings if it doesn't need them.
> So meh?

I thought we agreed a while back that these kind of "pull everything for
the logical device together" dt nodes which just have piles of phandles
are totally accepted? At least that's the point behind the component
helpers, and Eric even suggested to create dt-specific component helpers
to cut down a bit on the usual boilerplate. dt maintainers are also fine
with this approach afaik. From my understanding tegra with the host1x bus
really is the odd one out and not the norm.

Given that and with the hope that we'll eventually see a dt-enabled
component functions to standardize this even more the overall concept is

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
