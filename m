From: robdclark@gmail.com (Rob Clark)
Date: Mon, 10 Jun 2013 17:01:18 -0400
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20130610200839.GY18614@n2100.arm.linux.org.uk>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
 <E1UllJC-00058C-59@rmk-PC.arm.linux.org.uk>
 <CAF6AEGs+=56nntyJfy6cMHsehmhzFGcfGUC53RgNW=HfFW=qRA@mail.gmail.com>
 <20130610170648.GX18614@n2100.arm.linux.org.uk>
 <CAF6AEGuGuCtYQo_W3RVJ_69iDxq17s3y_y7eNmWRCw41YUvZmg@mail.gmail.com>
 <20130610200839.GY18614@n2100.arm.linux.org.uk>
Message-ID: <CAF6AEGsfzvdiGXqAu56rc-G_ZhhE_vnNbC6kpBmRtd-8Sh_uOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 4:08 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jun 10, 2013 at 03:59:34PM -0400, Rob Clark wrote:
>> On Mon, Jun 10, 2013 at 1:06 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > ARMADA_GEM_CREATE_PHYS is to deal with creating a gem buffer object for
>> > a chunk of physical memory allocated by other means (eg, the Vmeta stuff.)
>> > This allows my X server to remain compatible with the XF86 Dove driver,
>> > which permits the passing of the physical address of the video frame to
>> > the X server (otherwise we're into rewriting a whole load more code than
>> > is really desirable - and I really don't have time to rewrite bits of
>> > gstreamer and other stuff.)
>>
>> ahh, gotcha.. and, ugg, that is even worse..
>>
>> I'm not hugely a fan of giving userspace a way to dma into arbitrary
>> phys addresses (ie. create_phys + put_image).  But I don't need to
>> explain what you already know ;-)
>>
>> Is there a pre-defined carveout pool that you can at least bounds
>> check against?  Otherwise put this ioctl inside a #if
>> CONFIG_CRAZY_SOC_VENDOR_HOLE_TO_DRIVE_A_TRUCK_THROUGH / #endif..
>
> This driver is _not_ about supporting the GPU natively as part of the DRM,
> but providing the foundations for:
>
> (a) a properly functional interface to HDMI TVs (fbdev doesn't hack that)
>     with hotplug
> (b) providing sufficient infrastructure to allow video playback to work.

sure, but even omitting the phys ioctls gives you (a), which seems
like it is useful on it's own.  And would, I expect, be pretty useful
for the etnaviv folks working on r/e the gpu.

> What this is not about is fixing the crappy userspace GPU libraries and
> video decoding so that it's "secure" - not only is that way beyond my
> abilities, it would also be a violation of the closed source license to
> reverse engineer them so that were possible.

yeah, once you add the vendor gpu/etc drivers, if they are also giving
you a way to pass a phys addr, then plugging the holes in the drm/kms
driver won't do any good.  But in a way that is some other
non-upstream driver's problem.

> It is something that continues to be a problem and I'm making no claims
> that I'm fixing that.  So no, I will not put such a config option around
> it for the simple reason that by doing so, turning such an option off
> renders userspace utterly useless and the driver might as well not exist.
>
> If that means you want to NACK the patch, then fine; I'll just maintain
> it out of tree.  I did the driver mostly for my own personal benefit to
> get the Cubox to the point where I can boot it with or without the TV
> connected and have it work.  But it would be a shame if that meant
> that others could not benefit from about 8 solid months of my work on
> this and have to put up with crappy a fbdev driver.

I would like to get at least some of the driver upstream.  I'd hate
for it to have to live completely out of tree.  I can think of a
couple possibilities.

1) the best would be, if there was some way for the drm driver to know
the upper/lower bounds of the carveout, then it could bounds-check
against this.  And then in worst case, userspace can just screw up
other "graphics" buffers

2) if #1 weren't possible, then maybe just keep the phys ioctls as a
small patch on top of upstream.  The at least out of the box you get
modesetting.  I had to do something like this w/ omapdrm for gluing it
together w/ sgx/pvr stuff.  I re-arranged the code a bit to group all
the non-upstream bits together to avoid merge/rebase conflicts.

BR,
-R
