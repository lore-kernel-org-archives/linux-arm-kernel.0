From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Oct 2013 13:50:34 +0100
Subject: [PATCH 3/5] DRM: Armada: Add support for ARGB 32x64 or 64x32
 hardware cursors
In-Reply-To: <20131007152915.352cc4b2@i7>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwWS-0000i7-4f@rmk-PC.arm.linux.org.uk> <20131007110141.27f1ac25@armhf>
 <20131007094008.GH12758@n2100.arm.linux.org.uk>
 <20131007120922.47df03b6@armhf>
 <20131007103250.GJ12758@n2100.arm.linux.org.uk> <20131007152915.352cc4b2@i7>
Message-ID: <20131007125034.GO12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 03:29:15PM +0300, Siarhei Siamashka wrote:
> On Mon, 7 Oct 2013 11:32:50 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > However, what you're suggesting is dangerous.  What do you do when you're
> > presented with a cursor which is 64x64 ?  Do you:
> > 
> > (a) not display it
> > (b) crash the X server
> > 
> > There isn't a fallback to using software cursors available in the X server
> > because there's no error reporting for a failed hardware cursor update.
> 
> Hmm, maybe I'm missing something, but doesn't returning FALSE from
> UseHWCursorARGB just make the X server fallback to using a software
> cursor?
> 
> https://github.com/ssvb/xf86-video-fbturbo/blob/689c08256555/src/sunxi_disp_hwcursor.c#L72
> 
> I'm just doing this. And also have hooks to notify the DRI2 code about
> the status of the cursor. In the case if the hardware cursor is not
> enabled, hardware overlays can't be safely used with the software
> cursor and we need to fallback to CPU/GPU copy instead of zero-copy
> buffers swapping.
> 
> And I fully agree that it is the responsibility of the kernel to expose
> as much of the hardware capabilities as possible (without compromising
> reliability and/or security).

If you wish to go in below the level presented by
hw/xfree86/modes/xf86Cursors.c (as you are doing), then yes you can do
this, and it's something which maybe should be looked into.  You have a
good reason to do this (due to your hardware cursor being incompatible
with overlays).

We have no such restriction - the only issue here is the "odd" size of
cursors.  Practically, choosing one or other of 64x32 or 32x64 works
fine for the cases I've seen.  I haven't seen any cursors which are
64x64 yet.  I'm not saying they don't exist though!  I can imagine that
some accessibility options might want to display a large cursor.

Now, the way I handle this is that the kernel allows _either_ a
(1 to 32)x(1 to 64) or (1 to 64)x(1 to 32) cursor.  Both width and
height larger than 32 gets rejected with -EINVAL:

+               /* maximum size is 64x32 or 32x64 */
+               if (w > 64 || h > 64 || (w > 32 && h > 32))
+                       return -ENOMEM;

which is quite reasonable for this hardware.  However, there is no way
to export this from DRM - adding maximum cursor size properties wouldn't
really represent this.

The only question is whether DRM should export some capabilities to
indicate what's possible with the cursor, so that X knows about this
quirk of this hardware.  Overall, I suspect that it's just rare and
not worth the effort.  I think it's just easier to pick one of these
and stick with it, and if we happen to encounter a cursor larger than
our chosen dimentions, XFree86 will already automatically fall back
to s/w cursor.
