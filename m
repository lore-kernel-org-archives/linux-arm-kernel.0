From: lukas@mntmn.com (Lukas F. Hartmann)
Date: Mon, 17 Jul 2017 16:58:38 +0200
Subject: Debugging i.MX6QP HDMI Output on Mainline Kernel 
Message-ID: <87d18z3yap.fsf@irata-debian.mntnas>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm trying, for several days full-time, to get HDMI Output working with
the mainline kernel (first 4.12, now 4.13-rc1) on a board called TinyRex
Ultra (incl. development baseboard), which has an i.MX6QP SoC and 4GB
RAM. The HDMI output works with freescale-linux 4.1 but not with
mainline. I'm willing to invest significant effort to make this work,
and I appreciate some direction from experts on the subject.

I ported the DTS/DTSI files (mostly differing pinctrls) from the
third-party tinyrexultra DTS/DTSI. I modified the imx6qp-sabresd files
for this (attached). With this, most features of the board work fine,
e.g. SATA, USB, ethernet. I boot a debian-unstable userland from it.

When starting a program that uses DRM, e.g. Xorg, the program will pause
for 10 second intervals and DRM will log:

[ 127.831760] [drm:drm_atomic_helper_commit_cleanup_done] *ERROR* [CRTC:27:crtc-0] flip_done timed out
[ 138.711740] [drm:drm_atomic_helper_commit_cleanup_done] *ERROR* [CRTC:27:crtc-0] flip_done timed out
[ 148.951738] [drm:drm_atomic_helper_commit_cleanup_done] *ERROR*
[CRTC:27:crtc-0] flip_done timed out

As far as I understand this is:
wait_for_completion_interruptible_timeout(&stall_commit->flip_done,
10*HZ); in gpu/drm/drm_atomic_helper.c. In gpu/drm/imx/ipuv3-crtc.c
there is a function ipu_irq_handler(int irq, void *dev_id). Putting a
printk statement there reveals that this is never called. The interrupt
is requested as ipu_idmac_channel_irq(ipu_plane->ipu, ipu_plane->ipu_ch,
IPU_IRQ_EOF).

Thus, IRQ_EOF interrupts are never triggered. If I understand correctly,
this points to a problem with IPU setup or maybe clocks/CCM? I traced
register writes of the HDMI TX driver and they seem mostly sane / very
similar to what the freescale kernel does, but I don't know how to best
trace what is happening with IPU.

If anyone has an idea of how I could track down the cause for this
problem or a checklist of places to double-check, I would be very
thankful.

I've tried to communicate with NXP on this issue and they pointed me to
this list. https://community.nxp.com/message/924230

Cheers
Lukas F. Hartmann / mntmn
http://mntmn.com

-------------- next part --------------
A non-text attachment was scrubbed...
Name: imx6qdl-tinyrex2.dtsi
Type: application/octet-stream
Size: 11944 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170717/c19778f1/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: imx6-tinyrexultra.dts
Type: application/octet-stream
Size: 602 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170717/c19778f1/attachment-0001.obj>
