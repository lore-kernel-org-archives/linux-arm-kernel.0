From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Oct 2013 14:17:58 +0100
Subject: imx-drm: Add HDMI support
In-Reply-To: <20131021123652.GN17165@S2101-09.ap.freescale.net>
References: <52602EEA.6060402@prisktech.co.nz>
 <20131017193948.GT25034@n2100.arm.linux.org.uk>
 <1382039535.976669051@f130.i.mail.ru>
 <20131017203545.GV25034@n2100.arm.linux.org.uk>
 <20131019121218.GH25034@n2100.arm.linux.org.uk>
 <20131021091259.GB9716@S2101-09.ap.freescale.net>
 <20131021093448.GX25034@n2100.arm.linux.org.uk>
 <20131021123652.GN17165@S2101-09.ap.freescale.net>
Message-ID: <20131021131758.GA25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 08:36:55PM +0800, Shawn Guo wrote:
> On Mon, Oct 21, 2013 at 10:34:48AM +0100, Russell King - ARM Linux wrote:
> > However, the IPU is more stable with switching to bypass while it relocks
> > than not.
> 
> As far as I know, FSL kernel has always been doing relock without
> switching to bypass, and I haven't heard unstable IPU issue from their
> testing.  Do you have a case that I can set up here to see the issue?

export DISPLAY=:0
while :; do
  xrandr -s 1280x720 -r 50
  sleep 5
  xrandr -s 1280x720 -r 60
  sleep 5
done

is one way.  Another way is to switch between all possible resolutions
supported by the connected device, keeping each resolution for 30 seconds
a time.  Normally after one or two run-throughs, the IPU will be deader
than the parrot in Monty Python's parrot sketch, requiring a reboot to
get it working again.

As I've said previously, when it gets into this state, all the status
registers I can find report that all FIFOs in the IPU are sitting in
their empty state.  The TMDS clock is correct, and the frame composer
in the HDMI block is working, but it's not producing any sync signals or
pixel data.
