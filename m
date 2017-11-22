From: yong.deng@magewell.com (Yong)
Date: Wed, 22 Nov 2017 09:33:06 +0800
Subject: [PATCH v2 1/3] media: V3s: Add support for Allwinner CSI.
In-Reply-To: <20171121154827.5a35xa6zlqrrvkxx@flea.lan>
References: <1501131697-1359-1-git-send-email-yong.deng@magewell.com>
 <1501131697-1359-2-git-send-email-yong.deng@magewell.com>
 <20171121154827.5a35xa6zlqrrvkxx@flea.lan>
Message-ID: <20171122093306.d30fe641f269d62daa1f66b4@magewell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Nov 2017 16:48:27 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Hi,
> 
> On Thu, Jul 27, 2017 at 01:01:35PM +0800, Yong Deng wrote:
> > Allwinner V3s SoC have two CSI module. CSI0 is used for MIPI interface
> > and CSI1 is used for parallel interface. This is not documented in
> > datasheet but by testing and guess.
> > 
> > This patch implement a v4l2 framework driver for it.
> > 
> > Currently, the driver only support the parallel interface. MIPI-CSI2,
> > ISP's support are not included in this patch.
> > 
> > Signed-off-by: Yong Deng <yong.deng@magewell.com>
> 
> Thanks again for this driver.
> 
> It seems like at least this iteration is behaving in a weird way with
> DMA transfers for at least YU12 and NV12 (and I would assume YV12).
> 
> Starting a transfer of multiple frames in either of these formats,
> using either ffmpeg (ffmpeg -f v4l2 -video_size 640x480 -framerate 30
> -i /dev/video0 output.mkv) or yavta (yavta -c80 -p -F --skip 0 -f NV12
> -s 640x480 $(media-c tl -e 'sun6i-csi')) will end up in a panic.
> 
> The panic seems to be generated with random data going into parts of
> the kernel memory, the pattern being in my case something like
> 0x8287868a which is very odd (always around 0x88)
> 
> It turns out that when you cover the sensor, the values change to
> around 0x28, so it really seems like it's pixels that have been copied
> there.
> 
> I've looked quickly at the DMA setup, and it seems reasonable to
> me. Do you have the same issue on your side? Have you been able to
> test those formats using your hardware?

I had tested the following formats with BT1120 input:
V4L2_PIX_FMT_NV12		-> NV12
V4L2_PIX_FMT_NV21		-> NV21
V4L2_PIX_FMT_NV16		-> NV16
V4L2_PIX_FMT_NV61		-> NV61
V4L2_PIX_FMT_YUV420		-> YU12
V4L2_PIX_FMT_YVU420		-> YV12
V4L2_PIX_FMT_YUV422P		-> 422P
And they all work fine.

> 
> Given that they all are planar formats and YUYV and the likes work
> just fine, maybe we can leave them aside for now?

V4L2_PIX_FMT_YUV422P and V4L2_PIX_FMT_YUYV is OK, and V4L2_PIX_FMT_NV12
is bad? It's really weird.

What's your input bus code format, type and width?

> 
> Thanks!
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com


Thanks,
Yong
