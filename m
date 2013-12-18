From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 18 Dec 2013 18:03:11 +0200
Subject: OMAP display subsystem - does it work?
In-Reply-To: <20131218152927.GC32243@n2100.arm.linux.org.uk>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk>
 <52B1A922.6020901@ti.com> <20131218152927.GC32243@n2100.arm.linux.org.uk>
Message-ID: <52B1C73F.40604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-12-18 17:29, Russell King - ARM Linux wrote:
> On Wed, Dec 18, 2013 at 03:54:42PM +0200, Tomi Valkeinen wrote:
>> On 2013-12-18 14:00, Russell King - ARM Linux wrote:
>>> For the SDP4430, it used to detect the displays, even though nothing has
>>> ever been displayed on them.  Now it just spits out this:
>>
>> Those particular LCDs are supposed to be updated manually using custom ioctl,
>> so normal software using fb won't put anything on the display. For testing
>> purposes, a SW based automatic update (~20 fps) can be enabled by kernel
>> cmdline parameter "omapfb.auto_update" or via sysfs:
>>
>> echo 1 > /sys/class/graphics/fb0/update_mode
> 
> I'm confused.  How then can the original kernel which came with the board
> run two gstreamer videos on these displays by just talking to the
> framebuffers and play it back smoothly given that we're talking about
> video at normal fps settings?
> 
> When I received the board, that's exactly what it did at boot up - it
> played back two different video trailers, one on each LCD, and the
> playback was smooth, just like you'd expect from watching a DVD on your
> TV.  No missing frames, which is what you'd get if you tried to update
> at 20fps.

We once had auto-update support in omapdss in the early versions. It was
removed quite a while ago, as it was a burden to maintain. Either the
kernel you talk about had the auto-update support, or the userspace has
support for manual-update displays.

The thing is, these LCDs are not meant to be used in auto-update mode.
The main point with LCDs with their own framebuffer is that they are
only updated when needed. So a production device would not need
auto-update support. Furthermore, as these LCDs are quite rare, and
4430SDP is the only one we support having these displays, and that board
itself is not exactly a common one, it was decided that the maintenance
burden is not worth it.

I have been thinking of improving the auto-update in omapfb, but it has
never been on the top of my list (or even middle). The current code
basically does just queue_delayed_work() 20 times per second, so it's
just a hack for testing.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131218/e518498b/attachment.sig>
