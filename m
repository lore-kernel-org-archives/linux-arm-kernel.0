From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 30 Apr 2013 14:46:20 +0300
Subject: [PATCH V2] video: implement a simple framebuffer driver
In-Reply-To: <201304301228.42245.arnd@arndb.de>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <517F7245.2050606@iki.fi> <201304301228.42245.arnd@arndb.de>
Message-ID: <517FAF0C.1060901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2013 01:28 PM, Arnd Bergmann wrote:
> On Tuesday 30 April 2013, Tomi Valkeinen wrote:
> 
>> The bootloader would init the display hardware, the bootfb would give an
>> early /dev/fb0 for the kernel and userspace, and when the real display
>> driver is loaded, the bootfb would be unbound and the real driver would
>> take over.
> 
> I think that's a great idea. What I'm not sure about is how that
> infrastructure for switching frame buffers would work and how hard
> it's to write.

I don't have any clear ideas either, just some vague ones:

I think the simplest option would be for the userspace to just unbind
the fbcon, then the bootfb device/driver, and then load the real driver.
I don't see why that would not work, but it's far from optimal. The fb
memory would become unallocated for a while, and the user could see
garbage on the display.

A proper hand-over would be more complex. So, I don't know... Maybe the
bootfb driver could have custom API for this. When the real driver is
loaded, it'd call the bootfb to get the fb memory, and to unbind the bootfb.

Would there be issues with passing the fb memory? If one uses dma_alloc,
the device is linked to the allocated memory, so I presume you can't
just pass that around and remove the original device.

Then again, dma_alloc would not be used here, as bootfb needs the fb
memory from a particular location, so I guess bootmem is needed here.

I think it would be reasonable to have a restriction of only a single
bootfb instance, so one could just use static global variables/funcs to
manage the hand-over.

All this, of course, presumes that nobody else than fbcon is using the
fb. But I think it's also a reasonable restriction that the fb device is
not used (mmapped) by anyone.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130430/e4dd2bce/attachment-0001.sig>
