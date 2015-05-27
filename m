From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 May 2015 22:44:40 +0100
Subject: [PATCH 13/13] drm: bridge/dw_hdmi-ahb-audio: parse ELD from HDMI
 driver
In-Reply-To: <CAKMK7uFgqyHR4b+Q=_55S2Ojt-9+B-BRM4pKCRNwbRZ7kskpfA@mail.gmail.com>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1yD-0006lK-RC@rmk-PC.arm.linux.org.uk>
 <20150527104308.GA8341@phenom.ffwll.local>
 <20150527173125.GS2067@n2100.arm.linux.org.uk>
 <CAKMK7uFgqyHR4b+Q=_55S2Ojt-9+B-BRM4pKCRNwbRZ7kskpfA@mail.gmail.com>
Message-ID: <20150527214439.GW2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 11:29:52PM +0200, Daniel Vetter wrote:
> The only issue that might be
> there with your sw approach is that a concurrent probe/hotplug in drm
> might free the edid and hence the eld, while the snd side is trying to
> copy that.

Talking only about the particular case of dw-hdmi-ahb-audio...

The worst that may happen is that the ELD will be overwritten with an
update on hotplug - it won't be freed unless the underlying connector
is freed, as the eld is stored as an array inside struct drm_connector.
Before the DRM connector is freed, we pull the audio driver's struct
device, which will destroy the ALSA device.

Hopefully ALSA already copes gracefully with the removal of an in-use
device... it should do, it's no different from having a USB audio device
and you pull it out of the USB socket while the device is in-use.

(It's also worth noting as we're talking about this, that as the audio
struct device is a child of the HDMI device, any PM activity will be
correctly ordered: the child gets suspended before the parent... the
audio device gets suspended before the video, and resume is of course
the reverse order.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
