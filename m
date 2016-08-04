From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Aug 2016 13:23:29 +0100
Subject: [PATCH 2/2 v16] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <CAKMK7uEkUOq1CB3tj_1Qx50fBpw9B39+c3asX6MPNexT=dv9fA@mail.gmail.com>
References: <1464861445-11086-1-git-send-email-jitao.shi@mediatek.com>
 <1464861445-11086-2-git-send-email-jitao.shi@mediatek.com>
 <CACvgo53002XCPLufbJHQLC1uL1nNS7_0gh=napedetmvT6FoSw@mail.gmail.com>
 <CAGS+omDsDS5tx=+Efq8LWNd3-asU4r2h=-AE6vdKgfG-p6vdAA@mail.gmail.com>
 <CAKMK7uEkUOq1CB3tj_1Qx50fBpw9B39+c3asX6MPNexT=dv9fA@mail.gmail.com>
Message-ID: <20160804122329.GT1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2016 at 12:13:52PM +0200, Daniel Vetter wrote:
> Might be better to just do a request_firmware on driver load, and
> simply proceed if it's not there.

That is almost never a good idea - if the driver is built-in, then
the request_firmware call happens before the real rootfs is mounted,
which makes it complicated to get the firmware delivered to the
driver.

Sure, it works nicely if the drivers are built as modules, but not
everyone wants to deal with modules and initramfs images.

If we're wanting to just update the firmware, that should be an
explicit administrative decision requiring an explicit action by the
system administrator, and not done by placing a file in some magic
location so that request_firmware() can find it, which then gets
picked up at boot time/driver load time.  Consider what could happen
if linux-firmware picks up the file and places it in the appropriate
location by default.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
