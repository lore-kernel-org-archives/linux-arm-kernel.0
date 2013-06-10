From: robdclark@gmail.com (Rob Clark)
Date: Mon, 10 Jun 2013 19:12:10 -0400
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20130610223254.GC18614@n2100.arm.linux.org.uk>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
 <E1UllJC-00058C-59@rmk-PC.arm.linux.org.uk>
 <CAF6AEGs+=56nntyJfy6cMHsehmhzFGcfGUC53RgNW=HfFW=qRA@mail.gmail.com>
 <20130610170648.GX18614@n2100.arm.linux.org.uk>
 <CAF6AEGuGuCtYQo_W3RVJ_69iDxq17s3y_y7eNmWRCw41YUvZmg@mail.gmail.com>
 <CAKMK7uHSCigrTvKENjZRgEsgtA0BeaORcj15n7JFW_uQoNp37Q@mail.gmail.com>
 <20130610223254.GC18614@n2100.arm.linux.org.uk>
Message-ID: <CAF6AEGtfgS-HW-OS0nWqmwe_G2hNaqkPCpEDU55BWZS_WvAEBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 6:32 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jun 11, 2013 at 12:01:59AM +0200, Daniel Vetter wrote:
>> On Mon, Jun 10, 2013 at 9:59 PM, Rob Clark <robdclark@gmail.com> wrote:
>> > On Mon, Jun 10, 2013 at 1:06 PM, Russell King - ARM Linux
>> > <linux@arm.linux.org.uk> wrote:
>> >> On Mon, Jun 10, 2013 at 11:57:32AM -0400, Rob Clark wrote:
>> >>> On Sun, Jun 9, 2013 at 3:29 PM, Russell King
>> >>> <rmk+kernel@arm.linux.org.uk> wrote:
>> >>> > This patch adds support for the pair of LCD controllers on the Marvell
>> >>> > Armada 510 SoCs.  This driver supports:
>> >>> > - multiple contiguous scanout buffers for video and graphics
>> >>> > - shm backed cacheable buffer objects for X pixmaps for Vivante GPU
>> >>> >   acceleration
>> >>> > - dual lcd0 and lcd1 crt operation
>> >>> > - video overlay on each LCD crt
>> >>>
>> >>> Any particular reason for not exposing the overlays as drm_plane's?
>> >>> That is probably something that should change before merging the
>> >>> driver.
>> >>
>> >> Only through not understanding much of DRM when I started this.
>> >> Provided DRM planes can do everything that I'm already doing with
>> >> the overlay support, then yes.  Otherwise, I want to stick with this
>> >> which is modelled after the i915 overlay interface.
>>
>> Oh i915 overlays aren't a good reason ;-) I've done those way back
>> when drm didn't have any plane infrastructure and pretty much as my
>> very contribution. So totally lacked any clue.
>>
>> If I can scrap together a bit of time I want to port the legacy
>> overlay code over to drm planes (and remap the current ioctl interface
>> to the drm plane interface for backwards compat). But atm that's
>> crushed under a giant pile of other todo items.
>
> Aren't we all :(  The amount of time I have to touch this has reduced
> substantially over the last couple of months, which is why there's been
> a few weeks between the RFC's for this.
>
> The issue here is that with the overlay interface, all I have to do
> with one of these pass-by-phys-address things which the X server gets
> is to:
>
> 1. associate the phys address with a gem object
> 2. pass it in via the overlay interface
>
> With the DRM plane stuff, this gets more complicated:
>
> 1. associate the phys address with a gem object
> 2. call another driver private ioctl to bind the gem object to a framebuffer
>    (there is no support for this in the generic ioctl API afaics) which
>    has to allocate and setup a framebuffer
> 3. use setplane to update the plane
>
> That all increases the expense of overlay, and adds further memory
> allocations to the path (and frees when the previous framebuffer is
> discarded.)
>
> That all makes for higher load due to more CPU expense.

Nothing prevents you from having a driver private ioctl on top of drm
plane to combine this all into one ioctl in addition to supporting the
standard plane interface

BR,
-R
