From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jul 2015 11:14:27 +0100
Subject: [PATCH v2 3/5] drm/rockchip: vop: support plane scale
In-Reply-To: <CAAFQd5B3NnUQRqdaXUz6BGCn-5rh1iXnfZXnQRDK3=nF_Ya7SA@mail.gmail.com>
References: <1435313249-4549-1-git-send-email-mark.yao@rock-chips.com>
 <1435313249-4549-4-git-send-email-mark.yao@rock-chips.com>
 <CAAFQd5A2j7MXrzOMVnsJr_WUKAFPaicv+r9LgwHccLim4fRk8g@mail.gmail.com>
 <55965344.5050502@rock-chips.com>
 <CAAFQd5B3NnUQRqdaXUz6BGCn-5rh1iXnfZXnQRDK3=nF_Ya7SA@mail.gmail.com>
Message-ID: <20150703101427.GT7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 03, 2015 at 06:58:44PM +0900, Tomasz Figa wrote:
> On Fri, Jul 3, 2015 at 6:17 PM, Mark yao <mark.yao@rock-chips.com> wrote:
> >> Aren't the scl_modes for CbCr planes always the same as for Y plane?
> >
> >
> > No, such as src(1920 x 1080) -> dst(1280x800), yuv format is NV12.
> > so Y plane horizontal and vertical is scale down.
> >
> > but src_w = 1920 / 2 = 960 < 1280
> >       src_h = 1080 / 2 = 540 < 800.
> >
> > So Cbcr horizontal and vertical is scale up.
> 
> Sorry, I don't follow.
> 
> If we scale down Y plane in NV12 from 1920x1080 to 1280x800, then
> original CbCr plane will be 960x540 and destination CbCr plane will be
> 640x400 (because CbCr plane of NV12 is subsampled 2x2, which is half
> the width and half the height of Y plane), so both planes are being
> scaled down.

This is about displaying a NV12 image with arbitary scaling, right?
If so, think about what happens when you want to display such an image.
You don't display the raw NV12 image, the image gets converted to an
appropriate format first (be that RGB or YUV with no sub-sampling.)

What that means is that you need to scale each component to be the
same resolution.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
