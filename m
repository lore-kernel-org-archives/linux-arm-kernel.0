From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jan 2014 22:51:27 +0000
Subject: [PATCH v3 17/24] drm/i2c: tda998x: get a better status of the
 connection
In-Reply-To: <20140119195844.202f021b@armhf>
References: <cover.1390153344.git.moinejf@free.fr>
 <20140119195844.202f021b@armhf>
Message-ID: <20140122225127.GN15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 07:58:44PM +0100, Jean-Francois Moine wrote:
> This patch refines the connection status testing both bits RXSENS and
> HPD of the CEC register giving the connection level.

Can you explain why this is necessary?

I believe this is not necessary for the following reason:

HDMI cables are required to mate in a certain order:
- First to mate is the shell.
- Second are all pins with the exception of the +5V line.
- Third is the +5V line.

Sinks are not permitted to assert the HPD line until the EDID memory is
ready to be read, and +5V is indicated from the source.

Hence, HPD will not be asserted until the connector is fully mated, and
there are receivers available on the line.

This doesn't indicate whether the sink is powered and able to display
a picture - it merely means that the sink is present and valid EDID is
available to be read.  That's all that we really need here.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
