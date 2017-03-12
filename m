From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 12 Mar 2017 21:13:24 +0000
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <20170312175923.6ad86dff@vento.lan>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170312194700.GR21222@n2100.armlinux.org.uk>
 <20170312175923.6ad86dff@vento.lan>
Message-ID: <20170312211324.GW21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 12, 2017 at 05:59:28PM -0300, Mauro Carvalho Chehab wrote:
> Yet, udev/systemd has some rules that provide an unique name for V4L
> devices at /lib/udev/rules.d/60-persistent-v4l.rules. Basically, it
> runs a small application (v4l_id) with creates a persistent symling
> using rules like this:
> 
> 	KERNEL=="video*", ENV{ID_SERIAL}=="?*", SYMLINK+="v4l/by-id/$env{ID_BUS}-$env{ID_SERIAL}-video-index$attr{index}"
> 
> Those names are stored at /dev/v4l/by-path.

This doesn't help:

$ ls -Al /dev/v4l/by-id/
total 0
lrwxrwxrwx 1 root root 13 Mar 12 19:54 usb-Sonix_Technology_Co.__Ltd._USB_2.0_Camera-video-index0 -> ../../video10
$ ls -Al /dev/v4l/by-path/
total 0
lrwxrwxrwx 1 root root 12 Mar 12 19:54 platform-2040000.vpu-video-index0 -> ../../video0
lrwxrwxrwx 1 root root 12 Mar 12 19:54 platform-2040000.vpu-video-index1 -> ../../video1
lrwxrwxrwx 1 root root 12 Mar 12 20:53 platform-capture-subsystem-video-index0 -> ../../video2
lrwxrwxrwx 1 root root 12 Mar 12 20:53 platform-capture-subsystem-video-index1 -> ../../video3
lrwxrwxrwx 1 root root 12 Mar 12 20:53 platform-capture-subsystem-video-index2 -> ../../video4
lrwxrwxrwx 1 root root 12 Mar 12 20:53 platform-capture-subsystem-video-index3 -> ../../video5
lrwxrwxrwx 1 root root 12 Mar 12 20:53 platform-capture-subsystem-video-index4 -> ../../video6
lrwxrwxrwx 1 root root 12 Mar 12 20:53 platform-capture-subsystem-video-index5 -> ../../video7
lrwxrwxrwx 1 root root 12 Mar 12 20:53 platform-capture-subsystem-video-index6 -> ../../video8
lrwxrwxrwx 1 root root 12 Mar 12 20:53 platform-capture-subsystem-video-index7 -> ../../video9
lrwxrwxrwx 1 root root 13 Mar 12 19:54 platform-ci_hdrc.0-usb-0:1:1.0-video-index0 -> ../../video10

The problem is the "platform-capture-subsystem-video-index" entries.
These themselves change order.  For instance, I now have:

- entity 72: ipu1_csi0 capture (1 pad, 1 link)
             type Node subtype V4L flags 0
             device node name /dev/video6

which means it's platform-capture-subsystem-video-index4.  Before, it
was platform-capture-subsystem-video-index2.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
