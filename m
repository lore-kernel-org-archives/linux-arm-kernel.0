From: minghsiu.tsai@mediatek.com (Minghsiu Tsai)
Date: Mon, 19 Jun 2017 18:03:27 +0800
Subject: [PATCH v2] [media] mtk-mdp: Fix g_/s_selection capture/compose
 logic
In-Reply-To: <a180f2fc-1dce-3630-ed48-25c247eff79a@xs4all.nl>
References: <1494556970-12278-1-git-send-email-minghsiu.tsai@mediatek.com>
 <a180f2fc-1dce-3630-ed48-25c247eff79a@xs4all.nl>
Message-ID: <1497866607.25194.14.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Hans,

On Fri, 2017-06-16 at 12:42 +0200, Hans Verkuil wrote:
> On 05/12/17 04:42, Minghsiu Tsai wrote:
> > From: Daniel Kurtz <djkurtz@chromium.org>
> > 
> > Experiments show that the:
> >  (1) mtk-mdp uses the _MPLANE form of CAPTURE/OUTPUT
> 
> Please drop this, since this no longer applies to this patch.
> 

I will remove it next version


> >  (2) CAPTURE types use CROP targets, and OUTPUT types use COMPOSE targets
> 
> Are you really certain about this?
> 
> For m2m devices the output (i.e. memory to hardware) typically crops from memory
> and the capture side (hardware to memory) composes into memory.
> 
> I.e.: for the output side you crop the part of the memory buffer that you want
> to process and on the capture side you compose the result into a memory buffer:
> i.e. the memory buffer might be 1920x1080, but you compose the decoder output
> into a rectangle of 640x480 at offset 128x128 within that buffer (just an example).
> 
> CAPTURE using crop would be if, before the data is DMAed, the hardware decoder
> output is cropped. E.g. if the stream fed to the decoder is 1920x1080, but you
> want to only DMA a subselection of that, then that would be cropping, and it
> would go to a memory buffer of the size of the crop selection.
> 
> OUTPUT using compose is highly unlikely: that means that the frame you give
> is composed in a larger internal buffer with generated border data around it.
> Very rare and really only something that a compositor of some sort would do.
> 

That's strange. In v4l2-ioctl.c, v4l_g_crop()
OUTPUT is using COMPOSE
CAPTURE is using CROP

static int v4l_g_crop(const struct v4l2_ioctl_ops *ops,
				struct file *file, void *fh, void *arg)
...
	/* crop means compose for output devices */
	if (V4L2_TYPE_IS_OUTPUT(p->type))
		s.target = V4L2_SEL_TGT_COMPOSE_ACTIVE;
	else
		s.target = V4L2_SEL_TGT_CROP_ACTIVE;

	ret = ops->vidioc_g_selection(file, fh, &s);


> What exactly does the hardware do? Both for the encoder and for the decoder
> case. Perhaps if I knew exactly what that is, then I can advise.
> 

NV12M/YUV420M/MT21 -> MDP -> NV12M/YUV420M

The usage would be like this:
For decoder:
decoder -> MT21 -> MDP -> NV12M/YUV420M

For encoder:
NV12M/YUV420M -> MDP -> NV12M/YUV420M -> encoder



> Regards,
> 
> 	Hans
> 
