From: robherring2@gmail.com (Rob Herring)
Date: Wed, 26 Aug 2015 19:35:50 -0500
Subject: [PATCH 1/7] drm/vc4: Add devicetree bindings for VC4.
In-Reply-To: <CAPM=9tw=3yGQE3_G+=ian-+iV-OCRatbFc-stoMczmXeM2Ko+Q@mail.gmail.com>
References: <1439427380-2436-1-git-send-email-eric@anholt.net>
 <1439427380-2436-2-git-send-email-eric@anholt.net>
 <55CEC25E.7070303@wwwdotorg.org>
 <874mjxwyx5.fsf@eliezer.anholt.net>
 <CAL_JsqJxiGUR5BxBPyR3-0NxqWsOxMGrWQA6cMXe2pjTom__nw@mail.gmail.com>
 <CAF6AEGu2fi0M7DsicHz+5SDHi1DyDRmvWjkmYPPgY6pZ423WcA@mail.gmail.com>
 <20150826115229.GI1367@phenom.ffwll.local>
 <20150826120934.GC320@ulmo.nvidia.com>
 <CAL_JsqJ2v=wBaUe_gN_UcpQKis+kRH6oa0NTN24Lp9w9LVWtbQ@mail.gmail.com>
 <CAPM=9tw=3yGQE3_G+=ian-+iV-OCRatbFc-stoMczmXeM2Ko+Q@mail.gmail.com>
Message-ID: <CAL_JsqLPHuzvt-AsSVKLFGbxMQJ6JM4gz1M8UOamSBagHi=vXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 3:59 PM, Dave Airlie <airlied@gmail.com> wrote:
> On 27 August 2015 at 00:30, Rob Herring <robherring2@gmail.com> wrote:
>> On Wed, Aug 26, 2015 at 7:09 AM, Thierry Reding
>> <thierry.reding@gmail.com> wrote:
>>> On Wed, Aug 26, 2015 at 01:52:29PM +0200, Daniel Vetter wrote:
>>>> On Tue, Aug 25, 2015 at 04:42:18PM -0400, Rob Clark wrote:
>>>> > On Mon, Aug 24, 2015 at 9:47 AM, Rob Herring <robherring2@gmail.com> wrote:
>>>> > > On Mon, Aug 17, 2015 at 1:30 PM, Eric Anholt <eric@anholt.net> wrote:
>>>> > >> Stephen Warren <swarren@wwwdotorg.org> writes:
>>>> > >>
>>>> > >>> On 08/12/2015 06:56 PM, Eric Anholt wrote:
>>>> > >>>> Signed-off-by: Eric Anholt <eric@anholt.net>
[...]
>>>> > >>>> +- hvss:             List of references to HVS video scalers
>>>> > >>>> +- encoders: List of references to output encoders (HDMI, SDTV)
[...]
>>>> > >>> Of course, this is only appropriate if the HW modules really are
>>>> > >>> logically children of the VC4 HW module. Perhaps they aren't. If they
>>>> > >>> aren't though, I wonder what this "vc4" module actually represents in HW?
>>>> > >>
>>>> > >> It's the subsystem, same as we use a subsystem node for msm, sti,
>>>> > >> rockchip, imx, and exynos.  This appears to be the common model of how
>>>> > >> the collection of graphics-related components is represented in the DT.
>>>> > >
>>>> > > I think most of these bindings are wrong. They are grouped together
>>>> > > because that is what DRM wants not because that reflects the h/w. So
>>>> > > convince me this is one block, not that it is what other people do.
>>>> >
>>>> > I think, when it comes to more complex driver subsystems (like drm in
>>>> > particular) we have a bit of mismatch between how things look from the
>>>> > "pure hw ignoring sw" perspective, and the "how sw and in particular
>>>> > userspace expects things" perspective.  Maybe it is less a problem in
>>>> > other subsystems, where bindings map to things that are only visible
>>>> > in the kernel, or well defined devices like uart or sata controller.
>>>> > But when given the choice, I'm going to err on the side of not
>>>> > confusing userspace and the large software stack that sits above
>>>> > drm/kms, over dt purity.
>>>> >
>>>> > Maybe it would be nice to have a sort of dt overlay that adds the bits
>>>> > needed to tie together hw blocks that should be assembled into a
>>>> > single logical device for linux and userspace (but maybe not some
>>>> > other hypothetical operating system).  But so far that doesn't exist.
>>>> > All we have is a hammer (devicetree), everything looks like a nail.
>>>> > End result is we end up adding some things in the bindings which
>>>> > aren't purely about the hw.  Until someone invents a screwdriver, I'm
>>>> > not sure what else to do.  In the end, other hypothetical OS is free
>>>> > to ignore those extra fields in the bindings if it doesn't need them.
>>>> > So meh?
>>>>
>>>> I thought we agreed a while back that these kind of "pull everything for
>>>> the logical device together" dt nodes which just have piles of phandles
>>>> are totally accepted? At least that's the point behind the component
>>>> helpers, and Eric even suggested to create dt-specific component helpers
>>>> to cut down a bit on the usual boilerplate. dt maintainers are also fine
>>>> with this approach afaik. From my understanding tegra with the host1x bus
>>>> really is the odd one out and not the norm.
>>>
>>> I agree that in many aspects Tegra is somewhat special. But the same
>>> principles that the host1x infrastructure uses could be implemented in a
>>> similar way for other DRM drivers. You can easily collect information
>>> about subdevices by walking the device tree and matching on known
>>> compatible strings. And you can also instantiate the top-level device
>>> from driver code rather than have it in DT. It should still be possible
>>> to make this work without an artificial device node in DT. The component
>>> and master infrastructure is largely orthogonal to that, and as far as I
>>> remember the only blocker is the need for a top-level device. I wonder
>>> if perhaps this could be made to work by binding the master to the top-
>>> level SoC device.
>>>
>>> Obviously adding the node in DT is easier, but to my knowledge easy has
>>> never been a good excuse for mangling DT. Perhaps that's different these
>>> days...
>>
>> I agree we should avoid the virtual node if possible. It is certainly
>> possible as I started out with one and removed it. At least in my
>> case, it essentially required the drm_device and crtc to be a single
>> driver rather than 2 components. However, I'm more concerned that we
>> are consistent from platform to platform where it makes sense than
>> whether we have a somewhat questionable node or not.
>>
> http://lists.freedesktop.org/archives/dri-devel/2013-July/041159.html
>
> So can we at least have some continuity of decision making,
> bikeshedding this every time we submit a driver isn't giving me any
> hope going forward.

As I said, whether we have a virtual node or not is a minor part of
having some consistency in bindings and was the only part Grant
discussed. We have though diverged from the specific problems with
this binding which is that it invents yet another way to describe the
relationship between components. The use of DRM component names in the
binding properties is the first clue. As to what is the "right" way,
well if that is known or documented I've seen no evidence. Defining
what that is and having the infrastructure in place to support it is
what I'm interested in.

Rob
