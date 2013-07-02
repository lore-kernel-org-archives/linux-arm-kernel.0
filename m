From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Jul 2013 19:23:27 +0100
Subject: [PATCH RFC 1/3] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20130702180155.GP5004@intel.com>
References: <20130629225210.GF3353@n2100.arm.linux.org.uk>
 <E1Ut41C-0000wl-Ff@rmk-PC.arm.linux.org.uk>
 <20130630115941.GG18285@phenom.ffwll.local>
 <20130630125238.GH3353@n2100.arm.linux.org.uk>
 <CAKMK7uFcsbxciq-J_HLCm61kOtGpeAK0Tg2=2AOWSa9YYc4TeA@mail.gmail.com>
 <20130702180155.GP5004@intel.com>
Message-ID: <20130702182327.GE24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 02, 2013 at 09:01:55PM +0300, Ville Syrj?l? wrote:
> On Sun, Jun 30, 2013 at 07:29:27PM +0200, Daniel Vetter wrote:
> > On Sun, Jun 30, 2013 at 2:52 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > | Default Colorimetry
> > > |
> > > | ...
> > > |
> > > | 480p, 480i, 576p, 576i, 240p and 288p
> > > |
> > > | The default colorimetry for all 480-line, 576-line, 240-line, and 288-line
> > > | video formats described in CEA-861-D is based on SMPTE 170M.
> > > |
> > > | 1080i, 1080p and 720p
> > > |
> > > | The default colorimetry for high-definition video formats (1080i, 1080p and
> > > | 720p) described in CEA-861-D is based on ITU-R BT.709-5.
> 
> I think this was pretty much copy pasted from CEA-861-D which is very
> vague.
> 
> CEA-861-E is a bit better, and more clearly states that if the sink can
> receive YCbCr, then the source should use it by default for CE formats,
> and the default colorimetry depends on whether it's SD or HD. It also
> states that when transmitting IT or CE formats as RGB, the color space
> is the one defined in the EDID. CEA-861-D only made that statement for
> IT formats, and left the RGB CE format case out in the cold.

Actually, what I'm doing there is probably wrong when you consider
what is going on:

 Overlay (YUV) -> YUV->RGB colorspace conversion
                              |
                              v
 Graphic (RGB) -----------(colorkey)--------------------> HDMI

These bits control the YUV->RGB colorspace conversion.  The "is it 601
or 709 colorspace" question applies more to the colorspace of the
overlay image.  As far as I can tell, that is unspecified within our
normal video playback programs - there's provision to communicate that
information (they certainly don't seem to look for any kind of Xv
attribute).

The "is it computer or studio RGB" question (I think - I can't say
because the documentation is hellishly poor, and you now have as much
information on this as I do) refers to the colorspace of the RGB side.

So, maybe I should move the YUV colorspace setting to be a drm_plane
property?  But then how do we know what format it is supposed to be?
Do we just pick one and hope it's right?  Do we try to autodetect it
from the size of the drm_plane framebuffer?  What if something
downscales a HD YUV framebuffer to something smaller because the
display is smaller?

What I can say is that I've watched many hours of content with my driver
and at 720p output resolution, I prefer it converting the YUV between
709 to studio RGB - otherwise the blacks are too black and I find that
I have to adjust the brightness/contrast to bring the black levels up
compared to a standard TV broadcast.

> Oh and the other thing someone should do is fix the intel Xv code to
> use BT.709 CSC matrix for HD content. I believe that code is hardcoded
> for BT.601 currently, which may explain the last weirdness reported in
> that CEA bug or ours.

How do you propose to switch between the two?
