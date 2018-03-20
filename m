From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 20 Mar 2018 18:00:29 +0100
Subject: 4.16-rc5 on Motorola Droid 4
In-Reply-To: <20180320140322.GU5799@atomide.com>
References: <20180318220418.GA22880@amd>
 <20180320140322.GU5799@atomide.com>
Message-ID: <20180320170029.rv3u5wlvqxfl7z2v@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 20, 2018 at 07:03:22AM -0700, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180318 22:05]:
> > I have the phone, I have safestrap installed, kexec seems to work
> > (crashes my system). But I can't get any output from the new kernel.
> > 
> > All the howtos assume serial connection, but I don't yet have
> > that. I'm really bad at soldering. IIRC display should work in the
> > latest kernels, maybe with some patches?
> 
> Yeah display related stuff is half merged in Linux next, backlight
> needs some binding changes from what I remember. I think the
> minimal set is something like this against v4.16-rc:

I have an updated lm355x backlight driver almost ready, that uses
an updated binding scheme and exposes the keyboard backlight
using the LED subsystem.

> backlight: add TI LMU backlight driver
> drm/omap: add framedone interrupt support
> drm/omap: add manual update detection helper
> drm/omap: add support for manually updated displays
> 
> Then also audio support is also half merged and need few patches
> if you check the mailing list archives for cpcap codec related
> patches.

I just noticed, that I missed Rob gave his Acked-by to the binding
already. I will prepare a PATCHv6 with the MFD changes this week.

> Maybe get somebody to help you locally with the debug cable
> soldering? :)

I suppose people from your hackerspace can help you. It's really
easy to do. Soldering can be avoided btw. You can just use a pair
of scissors to cut a USB -> Micro USB cable and use a knife to remove
isolation. Then screw each of the 4 wires into a terminal strip.
There are USB-TTL adapters available, that have an attached cable.
If you also cut the connector from such a cable and connect it to
the other side of the terminal strip you are done. No soldering
involved ;)

> > Could someone give me .config and git hash that works for him? Once I
> > get working display I should be able to continue easily. I'd really
> > like to get voice calls working...
> 
> You want to use omapdrm, below is what I'm using with loadable
> modules with Linux next based on omap2plus_defconfig. It has some
> extra debug options enabled too that you might want to ignore,
> I'll try to send the defconfig related patches out too.
> 
> Basically you need the CONFIG_MFD_TI_LMU, CONFIG_DRM_OMAP and
> CONFIG_DRM_OMAP_PANEL_DSI_CM related options.
> 
> > I took a brief look through dts, and I did not find anything that
> > could be easily used for debugging. (It seems that capslock LED and
> > keyboard backlight is not yet supported? Also volume down  seems to be
> > supported but not volume up, funny).
> 
> Oh I thought we had all the LEDs mapped already? Volume down is
> on the internal keypad, then volume up is on a GPIO controller.
> I guess to allow chords for the bootloader.

The keyboard backlight and lcd backlight are controlled by LM3552,
that's the driver mentioned above. The other LEDs (status rgb,
shift/capslock, and the android button backlight) are working.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180320/919883ea/attachment-0001.sig>
