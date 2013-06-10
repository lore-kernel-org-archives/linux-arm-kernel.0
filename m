From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Jun 2013 21:08:39 +0100
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <CAF6AEGuGuCtYQo_W3RVJ_69iDxq17s3y_y7eNmWRCw41YUvZmg@mail.gmail.com>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
 <E1UllJC-00058C-59@rmk-PC.arm.linux.org.uk>
 <CAF6AEGs+=56nntyJfy6cMHsehmhzFGcfGUC53RgNW=HfFW=qRA@mail.gmail.com>
 <20130610170648.GX18614@n2100.arm.linux.org.uk>
 <CAF6AEGuGuCtYQo_W3RVJ_69iDxq17s3y_y7eNmWRCw41YUvZmg@mail.gmail.com>
Message-ID: <20130610200839.GY18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 03:59:34PM -0400, Rob Clark wrote:
> On Mon, Jun 10, 2013 at 1:06 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > ARMADA_GEM_CREATE_PHYS is to deal with creating a gem buffer object for
> > a chunk of physical memory allocated by other means (eg, the Vmeta stuff.)
> > This allows my X server to remain compatible with the XF86 Dove driver,
> > which permits the passing of the physical address of the video frame to
> > the X server (otherwise we're into rewriting a whole load more code than
> > is really desirable - and I really don't have time to rewrite bits of
> > gstreamer and other stuff.)
> 
> ahh, gotcha.. and, ugg, that is even worse..
> 
> I'm not hugely a fan of giving userspace a way to dma into arbitrary
> phys addresses (ie. create_phys + put_image).  But I don't need to
> explain what you already know ;-)
> 
> Is there a pre-defined carveout pool that you can at least bounds
> check against?  Otherwise put this ioctl inside a #if
> CONFIG_CRAZY_SOC_VENDOR_HOLE_TO_DRIVE_A_TRUCK_THROUGH / #endif..

This driver is _not_ about supporting the GPU natively as part of the DRM,
but providing the foundations for:

(a) a properly functional interface to HDMI TVs (fbdev doesn't hack that)
    with hotplug
(b) providing sufficient infrastructure to allow video playback to work.

What this is not about is fixing the crappy userspace GPU libraries and
video decoding so that it's "secure" - not only is that way beyond my
abilities, it would also be a violation of the closed source license to
reverse engineer them so that were possible.

It is something that continues to be a problem and I'm making no claims
that I'm fixing that.  So no, I will not put such a config option around
it for the simple reason that by doing so, turning such an option off
renders userspace utterly useless and the driver might as well not exist.

If that means you want to NACK the patch, then fine; I'll just maintain
it out of tree.  I did the driver mostly for my own personal benefit to
get the Cubox to the point where I can boot it with or without the TV
connected and have it work.  But it would be a shame if that meant
that others could not benefit from about 8 solid months of my work on
this and have to put up with crappy a fbdev driver.
