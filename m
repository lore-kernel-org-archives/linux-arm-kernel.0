From: daniel@ffwll.ch (Daniel Vetter)
Date: Thu, 13 Jun 2013 14:58:27 +0200
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <CAF6AEGs_Jf+R4qytC3odGa5yXX=Q5UWidjokHSh9S-a2GoFVnw@mail.gmail.com>
References: <CAF6AEGvAqF=SbxW=D_ymbW+w9SEqfouxPsVZEsctdk-iM79L5w@mail.gmail.com>
 <CAPM=9twJGgYiXxQyaXCnYd+bUPFv+P92qGdmJ39_4z29==4F2g@mail.gmail.com>
 <20130610233611.GK18614@n2100.arm.linux.org.uk>
 <CAPM=9tz6p2rhjNUg7ednT09A+dztbYskF32QkZeaCi_qrH8ipw@mail.gmail.com>
 <20130612134845.GQ18614@n2100.arm.linux.org.uk>
 <CAF6AEGs4GLkBePQUd_Bh4z_Hwv8kacaEQSMSVSj4rw=ezQA66Q@mail.gmail.com>
 <20130612164914.GT18614@n2100.arm.linux.org.uk>
 <20130612170512.GU18614@n2100.arm.linux.org.uk>
 <20130612194021.GX18614@n2100.arm.linux.org.uk>
 <20130612230057.GY18614@n2100.arm.linux.org.uk>
 <20130613111903.GA18614@n2100.arm.linux.org.uk>
 <CAF6AEGs_Jf+R4qytC3odGa5yXX=Q5UWidjokHSh9S-a2GoFVnw@mail.gmail.com>
Message-ID: <CAKMK7uHXkSEBpxmYULUSGZDxLS0W5zDjS5EKYhB6D6fm4ZQ9LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 2:52 PM, Rob Clark <robdclark@gmail.com> wrote:
> most of the embedded drivers should ignore the old_fb.. the API is a
> bit odd but the purpose is to help drivers that need to pin/unpin the
> gem objects backing the fb.  The ones that do, do something like:
>
>   foo_pin(new_fb);
>   foo_unpin(old_fb);
>
> if the two are the same, it works out.
>
> Note that even for the non error paths, new_fb and old_fb could be the same.
>
> Possibly something worth clarifying in the docs.

One implication this has is that the crtc helper assumes that the
driver modeset callbacks only fail before the driver internally has
done the pin/unpin dance. If the new fb is already the one which
should be unpinned and the modeset fails after that point, then we'll
leak stuff.

So drivers need to ensure that they undo any pin/unpins (and other fb
refcounted resource handling) if they're ->modeset callback fails.

In the new shiny drm/i915 modeset helper code we've flipped around
those semantics, but imo for the crtc helper it does fit into the
larger assumptions of the crtc helper code:
- crtc helper code assumes that all ->disable callbacks are stateless
- hence it can put the _new_ requested state into the sw tracking
structures before the modeset starts so that ->mode_fixup callbacks
could e.g. check the pixel format of the new fb.

Flipping that around would remove one of the cornerstones of the crtc
helpers, so imo doesn't make much sense. But as i915.ko demonstrates
with a bit of effort it's no problem to have a completely different
modeset sequence driver infrastructure.
-Daniel
--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
