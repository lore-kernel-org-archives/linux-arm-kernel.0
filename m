From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Jun 2015 21:41:54 +0100
Subject: mx6 hdmi resolution behaviour
In-Reply-To: <CAOMZO5BjuOGgqsUNG6K6N-QU1a4oWTdynxsoAECYLeQK_9Kk9g@mail.gmail.com>
References: <CAOMZO5AbC8PCo7J7ovw4izPBK08UkDgKGG++d+9xty4GJ0SzKQ@mail.gmail.com>
 <20150623164443.GC7557@n2100.arm.linux.org.uk>
 <CAOMZO5BjuOGgqsUNG6K6N-QU1a4oWTdynxsoAECYLeQK_9Kk9g@mail.gmail.com>
Message-ID: <20150623204154.GD7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 23, 2015 at 01:52:50PM -0300, Fabio Estevam wrote:
> On Tue, Jun 23, 2015 at 1:44 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > If you have no connected connectors, then you get 1024x768:
> >
> > imx-drm display-subsystem: No connectors reported connected with modes
> > [drm] Cannot find any crtc or sizes - going 1024x768
> >
> > as that's what DRM defaults to when it has no other timing information
> > available.
> 
> Agreed, but after the cable is connected we could try to find a more
> suitable timing?
> 
> >> [   16.310548] imx-ipuv3 2400000.ipu: videomode adapted for IPU restrictions
> >
> > I don't see this message booting on a Hummingboard with HDMI
> > disconnected.
> 
> I see this message in the following case:
> 
> - Boot the board with HDMI disconnected
> 
> - Connect the HDMI cable and then such message is displayed.

I've just tried this (the HBi1 was booted previously with the HDMI socket
disconnected).  Just now, I turned the TV on, and then connected it to
the HDMI.

The TV reported a resolution of 1024x768, and the kernel log was silent.

My guess would be that your HDMI sink is reporting slightly non-standard
1024x768 timings, which cause the IPU restrictions to be violated.  Maybe
dumping the EDID of the HDMI device would reveal this?

# edid-decode < /sys/class/drm/card0-HDMI-A-1/edid

might provide some hints?

-- 
FTTC broadband for 0.8mile line: currently@10.5Mbps down 400kbps up
according to speedtest.net.
