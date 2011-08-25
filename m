From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 26 Aug 2011 01:07:17 +0200 (CEST)
Subject: [PATCH 2/2] V4L: mx3-camera: prepare to support multi-size buffers
In-Reply-To: <201108251857.16865.laurent.pinchart@ideasonboard.com>
References: <1314211292-10414-1-git-send-email-g.liakhovetski@gmx.de>
	<Pine.LNX.4.64.1108251838090.17190@axis700.grange>
	<Pine.LNX.4.64.1108251843350.17190@axis700.grange>
	<201108251857.16865.laurent.pinchart@ideasonboard.com>
Message-ID: <Pine.LNX.4.64.1108260100330.17190@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Aug 2011, Laurent Pinchart wrote:

> Hi Guennadi,
> 
> On Thursday 25 August 2011 18:46:03 Guennadi Liakhovetski wrote:
> > Prepare the mx3_camera friver to support the new VIDIOC_CREATE_BUFS and
> > VIDIOC_PREPARE_BUF ioctl()s. The .queue_setup() vb2 operation must be
> > able to handle buffer sizes, provided by the caller, and the
> > .buf_prepare() operation must not use the currently configured frame
> > format for its operation, which makes it superfluous for this driver.
> > Its functionality is moved into .buf_queue().
> 
> You're moving the ichan->dma_chan.device->device_prep_slave_sg() call from 
> .buf_prepare() to .buf_queue(). Is that call cheap ? Otherwise it would be 
> better to keep the .buf_prepare() callback.

But only if (buf->state == CSI_BUF_NEEDS_INIT), i.e., only on the first 
invocation. In any case, look at idmac_prep_slave_sg() - it is cheap. To 
do this in .buf_prepare I'd have to store the frame format from the 
.queue_setup() with a list of indices, to which it applies, and then use 
it in .buf_prepare()...

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
