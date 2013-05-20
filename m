From: alexdeucher@gmail.com (Alex Deucher)
Date: Mon, 20 May 2013 09:36:02 -0400
Subject: [RFC 0/8] rmk's Dove DRM/TDA19988 Cubox driver
In-Reply-To: <20130519085920.GO18614@n2100.arm.linux.org.uk>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <20130517133345.7c1368f5@armhf>
 <20130517120115.GF18614@n2100.arm.linux.org.uk>
 <20130517194023.0c385ea0@armhf>
 <20130519085920.GO18614@n2100.arm.linux.org.uk>
Message-ID: <CADnq5_Pajy4jxLdd9QGBrUooWYFjfQRQgdbvbu9UDE8-7Tmm8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 19, 2013 at 4:59 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, May 17, 2013 at 07:40:23PM +0200, Jean-Francois Moine wrote:
>> Maybe I did not explain correctly: the colored cursor maybe RGB888 +
>> transparency (64x64) or full ARGB (64x32 or 32x64). I coded the first
>> case. And, yes, I better like a hardware cursor: it asks for less
>> computation, and I get it immediately at graphic starting time!
>
> Having looked at this now, using the RGB+transparency is less than ideal
> because we're having to reduce an alpha channel down to a simple on/off
> transparency.  X cursors really are alphablended components!
>
> So, the options here are:
> (a) use "software" rendered cursor
>     + correct and expected cursor size
>     + correct rendering
>     + possible to use the GPU (I believe mine does)
>     - maybe time consuming as it has to be removed/replaced on the screen
> (b) use RGB+transparency for 64x64 hardware cursor
>     + correct and expected cursor size
>     + does not have to be removed/replaced when screen contents change
>     - incorrect rendering due to reducing the alpha channel to a simple
>       on/off transparency mask
>     - has to be reloaded when the pointer is close to the edges of the
>       screen which is CPU intensive
>     - cursor image data passed into DRM is required to be ARGB (I've
>       discussed this with David Airlie last night.)  This means we have
>       to do translation to RGB+T in the kernel which is *not* nice.
> (c) use ARGB 32x64 or 64x32 hardware cursor
>     + does not have to be removed/replaced when screen contents change
>     + correct rendering of cursor
>     - unexpected cursor size; user clients do not expect to be restricted
>       to 32 rows or 32 lines of cursor
>     - can only select maximum cursor size on initialization of hardware
>       cursor; can't dynamically switch between 32x64 and 64x32 sizes
>     - has to be reloaded when the pointer is close to the edges of the
>       screen which is CPU intensive

You can tell the xserver what size cursor you support when you call
xf86_cursors_init() in the ddx.  Just expose a 32x64 or 64x32 ARGB
cursor.  Most apps don't use a 64x64 cursor anyway.  I've used
hardware with non-64x64 cursors and haven't run into any problems yet.

Alex
