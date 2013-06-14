From: daniel@ffwll.ch (Daniel Vetter)
Date: Fri, 14 Jun 2013 21:50:22 +0200
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20130614144251.GN18614@n2100.arm.linux.org.uk>
References: <20130612134845.GQ18614@n2100.arm.linux.org.uk>
 <CAF6AEGs4GLkBePQUd_Bh4z_Hwv8kacaEQSMSVSj4rw=ezQA66Q@mail.gmail.com>
 <20130612164914.GT18614@n2100.arm.linux.org.uk>
 <20130612170512.GU18614@n2100.arm.linux.org.uk>
 <20130612194021.GX18614@n2100.arm.linux.org.uk>
 <20130612230057.GY18614@n2100.arm.linux.org.uk>
 <20130613111903.GA18614@n2100.arm.linux.org.uk>
 <20130613115016.GB18614@n2100.arm.linux.org.uk>
 <20130613130339.GD18614@n2100.arm.linux.org.uk>
 <CAKMK7uHgAe=05RFLxqSTz5R+myU9-nvuk=RMZym2k-tjzbC+2w@mail.gmail.com>
 <20130614144251.GN18614@n2100.arm.linux.org.uk>
Message-ID: <CAKMK7uEzC8rCaAB_8VCwyox2Be9JZ=+OWSk0+BLyfug7G5=18A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 4:42 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jun 14, 2013 at 04:23:22PM +0200, Daniel Vetter wrote:
>> On Thu, Jun 13, 2013 at 3:03 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > There's a bigger issue here - if it's possible for drm_crtc_helper_set_config()
>> > to be called with set->fb set but set->mode NULL, then we overwrite
>> > set->fb to NULL.  Again, that results in a lost reference.
>> >
>> > For the time being, I'm using this patch, which solves my dropped
>> > refcount problem, and marks the other possible dropped reference.
>> > Either that check needs to be removed or it needs to properly drop
>> > the refcount on the fb before 'losing' the reference to it.
>>
>> Scrap my other mail, I see now where the leaking happens. One of them
>> is interface abuse which is now fixed (and i915 has a bunch of BUG_ONs
>> to enforce them). The other one is indeed a real case that eluded me
>> when I've done the refcountification for drm_framebuffers. I'll hack
>> up some patches, since this seems to be a good excuse to port some of
>> the i915 modeset improvements back to the crtc helpers.
>
> If you're happy with the patch I supplied, that's probably the minimal fix
> which should go to stable kernels (I'm using 3.9 here) - this also counts
> as a "user visible bug".  It's something I've tripped over which causes
> exhausts memory and can prevent the X server from starting up.
>
> If you want me to package the patch up with a commit message and sign-off..

Your patch doesn't fix drm/i915 (since we don't use the crtc helpers
any more). And I don't think it's good to have the refcounting
partially in the drm core and partially in drivers. I've also thrown a
few more things on top just to port a few of the i915 cleanups to the
crtc helper. I'll submit my patches asap (need to test them a bit more
first).
-Daniel
--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
