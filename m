From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Jun 2015 15:49:34 +0100
Subject: [PATCH 00/13] Discover and probe dependencies
In-Reply-To: <5582C437.4030108@samsung.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
 <55829269.2090309@samsung.com>
 <20150618103615.GC14071@sirena.org.uk>
 <5582C437.4030108@samsung.com>
Message-ID: <20150618144934.GM7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 03:14:31PM +0200, Andrzej Hajda wrote:
> Lets look at more real example: we have HDMI encoder which can
> use some video and audio resources provided by some video and audio
> drivers. If we know that our machine will work without sound we can
> disable audio drivers but we can expect video should still work, ie
> HDMI driver should successfully probe even if audio resources are
> not available.

That already happens today, if you structure the driver appropriately.
I really don't buy into the crap argument that "all struct device must
be created by DT" - it is perfectly acceptable for a device driver to
declare and register its own sub-devices where it's appropraite for it
to do so.

Since audio _requires_ video on HDMI to work (audio fundamentally
depends on a working video setup), it is perfectly acceptable for a
HDMI video driver to register a struct device for its audio driver,
and to pass details that the audio driver may need.

What is not acceptable is to duplicate the HDMI drivers device_node
into the child devices: this creates a situation where the generic
device model can match the HDMI driver with its child device.  So
this is a big no no.

The model I refer to above is something which I have, and others have
implemented for HDMI devices, and it's a completely reasonable model.

Remember, DT is about describing the hardware.  If you have a HDMI
encoder, that's one hardware block, and there should be one entry
describing it in DT.  Just because in Linux we may decide to separate
them into two separate drivers, and therefore two separate struct
device's is an implementation detail, and is not a reason to medle
with the hardware model in DT.

I think you may need to pick a better example to illustrate your point. :)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
