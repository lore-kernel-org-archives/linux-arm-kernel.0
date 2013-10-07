From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Mon, 7 Oct 2013 15:29:15 +0300
Subject: [PATCH 3/5] DRM: Armada: Add support for ARGB 32x64 or 64x32
 hardware cursors
In-Reply-To: <20131007103250.GJ12758@n2100.arm.linux.org.uk>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwWS-0000i7-4f@rmk-PC.arm.linux.org.uk>
 <20131007110141.27f1ac25@armhf>
 <20131007094008.GH12758@n2100.arm.linux.org.uk>
 <20131007120922.47df03b6@armhf>
 <20131007103250.GJ12758@n2100.arm.linux.org.uk>
Message-ID: <20131007152915.352cc4b2@i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Oct 2013 11:32:50 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Mon, Oct 07, 2013 at 12:09:22PM +0200, Jean-Francois Moine wrote:
> > On Mon, 7 Oct 2013 10:40:08 +0100
> > Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > 
> > > > > This patch adds ARGB hardware cursor support to the DRM driver for the
> > > > > Marvell Armada SoCs.  ARGB cursors are supported at either 32x64 or
> > > > > 64x32 resolutions.  
> > > > 	[snip]
> > > > 
> > > > I don't see the interest of such cursors. Actually, most often, the
> > > > cursors are 64x64 and 'A' is either 0 or 0xff. As the Armada 510
> > > > supports 64x64 cursors with transparency, it would be more useful to
> > > > implement these ones...  
> > > 
> > > Sorry, you're completely wrong there.  Xorg uses an alphablended cursor.
> > > This patch is a result of trialling each of the Armada's cursor options
> > > and this is the only one which results in a reasonable looking cursor.
> > 
> > Strange. I am using the 64x64 cursor with transparency of the 510 for
> > many months and I never saw any problem.
> 
> When I tried it, all cursors had variable alpha, and converting the
> alpha to a single transparency bit made the cursor look rubbish against
> certain backgrounds.
> 
> > If you absolutely want to have all transparency shades, you should
> > accept 64x64 cursors and test if they may be rendered as 64x32 or
> > 32x64, i.e. test that there is only pure transparency in the non-
> > rendered rectangles...
> 
> That is policy, and that is something which can be done by the X server
> rather than the kernel.  The kernel exposes the hardware capabilities,
> which are to allow a 64x32 or a 32x64 cursor.  Userspace can make the
> decision dynamically which it wishes to use.
> 
> However, what you're suggesting is dangerous.  What do you do when you're
> presented with a cursor which is 64x64 ?  Do you:
> 
> (a) not display it
> (b) crash the X server
> 
> There isn't a fallback to using software cursors available in the X server
> because there's no error reporting for a failed hardware cursor update.

Hmm, maybe I'm missing something, but doesn't returning FALSE from
UseHWCursorARGB just make the X server fallback to using a software
cursor?

https://github.com/ssvb/xf86-video-fbturbo/blob/689c08256555/src/sunxi_disp_hwcursor.c#L72

I'm just doing this. And also have hooks to notify the DRI2 code about
the status of the cursor. In the case if the hardware cursor is not
enabled, hardware overlays can't be safely used with the software
cursor and we need to fallback to CPU/GPU copy instead of zero-copy
buffers swapping.

And I fully agree that it is the responsibility of the kernel to expose
as much of the hardware capabilities as possible (without compromising
reliability and/or security).

-- 
Best regards,
Siarhei Siamashka
