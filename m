From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Mar 2017 13:29:30 +0000
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <179aca0a-deb5-7937-f955-26cc6d93afba@xs4all.nl>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170318192258.GL21222@n2100.armlinux.org.uk>
 <aef6c412-5464-726b-42f6-a24b7323aa9c@mentor.com>
 <20170319103801.GQ21222@n2100.armlinux.org.uk>
 <9b3311a8-34a7-2b5b-9bc7-836371e1e0a4@gmail.com>
 <179aca0a-deb5-7937-f955-26cc6d93afba@xs4all.nl>
Message-ID: <20170320132930.GJ21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 02:01:58PM +0100, Hans Verkuil wrote:
> On 03/19/2017 06:54 PM, Steve Longerbeam wrote:
> > 
> > 
> > On 03/19/2017 03:38 AM, Russell King - ARM Linux wrote:
> >> What did you do with:
> >>
> >> ioctl(3, VIDIOC_REQBUFS, {count=0, type=0 /* V4L2_BUF_TYPE_??? */, memory=0 /* V4L2_MEMORY_??? */}) = -1 EINVAL (Invalid argument)
> >>                  test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> >> ioctl(3, VIDIOC_EXPBUF, 0xbef405bc)     = -1 EINVAL (Invalid argument)
> >>                  fail: v4l2-test-buffers.cpp(571): q.has_expbuf(node)
> 
> This is really a knock-on effect from an earlier issue where the compliance test
> didn't detect support for MEMORY_MMAP.

So why does it succeed when I fix the compliance errors with VIDIOC_G_FMT?
With that fixed, I now get:

        Format ioctls:
                test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
                test VIDIOC_G/S_PARM: OK
                test VIDIOC_G_FBUF: OK (Not Supported)
                test VIDIOC_G_FMT: OK
                test VIDIOC_TRY_FMT: OK
                test VIDIOC_S_FMT: OK
                test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
                test Cropping: OK (Not Supported)
                test Composing: OK (Not Supported)
                test Scaling: OK (Not Supported)

        Buffer ioctls:
                test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
                test VIDIOC_EXPBUF: OK

The reason is, if you look at the code, VIDIOC_G_FMT populates a list
of possible buffer formats "node->valid_buftypes".  If the VIDIOC_G_FMT
test fails, then node->valid_buftypes is zero.

This causes testReqBufs() to only check for the all-zeroed VIDIOC_REQBUFS
and declare it conformant, without creating any buffers (it can't, it
doesn't know which formats are supported.)

This causes node->valid_memorytype to be zero.

We then go on to testExpBuf(), and valid_memorytype zero, claiming (falsely)
that MMAP is not supported.  The reality is that it _is_ supported, but
it's just the non-compliant VICIOC_G_FMT call (due to the colorspace
issue) causes the sequence of tests to fail.

> Always build from the master repo. 1.10 is pretty old.

It's what I have - remember, not everyone is happy to constantly replace
their distro packages with random new stuff.

> >> In any case, it doesn't look like the buffer management is being
> >> tested at all by v4l2-compliance - we know that gstreamer works, so
> >> buffers _can_ be allocated, and I've also used dmabufs with gstreamer,
> >> so I also know that VIDIOC_EXPBUF works there.
> 
> To test actual streaming you need to provide the -s option.
> 
> Note: v4l2-compliance has been developed for 'regular' video devices,
> not MC devices. It may or may not work with the -s option.

Right, and it exists to verify that the establised v4l2 API is correctly
implemented.  If the v4l2 API is being offered to user applications,
then it must be conformant, otherwise it's not offering the v4l2 API.
(That's very much a definition statement in itself.)

So, are we really going to say MC devices do not offer the v4l2 API to
userspace, but something that might work?  We've already seen today
one user say that they're not going to use mainline because of the
crud surrounding MC.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
