From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Mar 2017 12:02:49 +0100
Subject: [PATCH v6 00/39] i.MX Media Driver
In-Reply-To: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170330110249.GF7909@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fails at step 1.  The removal of the frame interval support now
means my setup script fails when trying to set the frame interval on
the camera:

Enumerating pads and links
Setting up format SRGGB8_1X8 816x616 on pad imx219 0-0010/0
Format set: SRGGB8_1X8 816x616
Setting up frame interval 1/25 on pad imx219 0-0010/0
Frame interval set: 1/25
Setting up format SRGGB8_1X8 816x616 on pad imx6-mipi-csi2/0
Format set: SRGGB8_1X8 816x616
Setting up frame interval 1/25 on pad imx6-mipi-csi2/0
Unable to set frame interval: Inappropriate ioctl for device (-25)Unable to setup formats: Inappropriate ioctl for device (25)

This is because media-ctl tries to propagate it from the imx219 source
pad to the csi2 sink pad, and the csi2 now fails that ioctl.

This makes media-ctl return a failure code, which means that it's not
possible for a script to determine whether the failure was due to the
camera setup or something else.  So, we have to assume that the
whole command failed.

This is completely broken, and I'm even more convinced that those
arguing for this behaviour really have not thought it through well
enough before demanding that this code was removed.

As far as I'm concerned, the end result is completely broken and
unusable.  I'm going to be merging the frame interval support back
into my test tree, because that's the only sane thing to do.

If v4l2 people want to object to having frame interval support present
for all subdevs, then _they_ need to make sure that the rest of their
software conforms to what they're telling people to do.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
