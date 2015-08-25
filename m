From: treding@nvidia.com (Thierry Reding)
Date: Tue, 25 Aug 2015 11:12:48 +0200
Subject: [PATCH v3 06/14] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <CAL_JsqKZYMMzV9Sc2r3K_rnM0FNuyb1TyJEhjGq1Hf7dTiWFKQ@mail.gmail.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <1439995834-18363-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqLz+8RtBucctUj4euXZ3Ac0DvB52N9ONpAerh5T9BiTJg@mail.gmail.com>
 <20150824125758.GA7557@n2100.arm.linux.org.uk>
 <CAL_JsqKZYMMzV9Sc2r3K_rnM0FNuyb1TyJEhjGq1Hf7dTiWFKQ@mail.gmail.com>
Message-ID: <20150825091246.GA14034@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 09:48:27AM -0500, Rob Herring wrote:
> On Mon, Aug 24, 2015 at 7:57 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Sun, Aug 23, 2015 at 06:23:14PM -0500, Rob Herring wrote:
> >> On Wed, Aug 19, 2015 at 9:50 AM, Yakir Yang <ykk@rock-chips.com> wrote:
> >> > +       -analogix,color-depth:
> >> > +               number of bits per colour component.
> >> > +                       COLOR_6 = 0, COLOR_8 = 1, COLOR_10 = 2, COLOR_12 = 3
> >>
> >> This seems pretty generic. Just use 6, 8, 10, or 12 for values. And
> >> drop the vendor prefix.
> >
> > Please think about this some more.  What does "color-depth" mean?  Does it
> > mean the number of bits per colour _component_, or does it mean the total
> > number of bits to represent a particular colour.  It's confusing as it
> > stands.
> 
> Then "component-color-bpp" perhaps?

There should be no need to have this in DT at all. The BPC is a property
of the attached panel and it should come from the panel (either the
panel driver or parsed from EDID if available).

> > When we adopted the graph bindings for iMX DRM, I thought exactly at that
> > time "it would be nice if this could become the standard for binding DRM
> > components together" but I don't have the authority from either the DT
> > perspective or the DRM perspective to mandate that.  Neither does anyone
> > else.  That's the _real_ problem here.
> >
> > I've seen several DRM bindings go by which don't use the of-graph stuff,
> > which means that they'll never be compatible with generic components
> > which do use the of-graph stuff.
> 
> It goes beyond bindings IMO. The use of the component framework or not
> has been at the whim of driver writers as well. It is either used or
> private APIs are created. I'm using components and my need for it
> boils down to passing the struct drm_device pointer to the encoder.
> Other components like panels and bridges have different ways to attach
> to the DRM driver.

I certainly support unification, but it needs to be reasonable. There
are cases where a different structure for the binding work better than
another and I think this always needs to be evaluated on a case by case
basis.

Because of that I think it makes sense to make all these framework bits
opt-in, otherwise we could easily end up in a situation where drivers
have to be rearchitected (or even DT bindings altered!) in order to be
able to reuse code.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150825/6154bc96/attachment.sig>
