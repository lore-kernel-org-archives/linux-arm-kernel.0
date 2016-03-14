From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Mon, 14 Mar 2016 08:21:22 +0100
Subject: FW: [PATCH v5 0/8] Add MT8173 Video Encoder Driver and VPU Driver
In-Reply-To: <1457939579.32502.10.camel@mtksdaap41>
References: <D706F7FE148A8A429434F78C46336826048E7053@mtkmbs02n1>
 <1457939579.32502.10.camel@mtksdaap41>
Message-ID: <56E66672.9030307@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2016 08:12 AM, tiffany lin wrote:
> Hi Hans,
> 
> After change to use "v4l-utils.git master branch", "V4l2-compliance
> -d /dev/video1" fail on "fail: v4l2-test-buffers.cpp(555):
> check_0(crbufs.reserved, sizeof(crbufs.reserved))".
> 
> Check the source code and found
> 
> 	memset(&crbufs, 0xff, sizeof(crbufs));   -> crbufs to 0xff
>         node->g_fmt(crbufs.format, i);
>         crbufs.count = 0;
>         crbufs.memory = m;
>         fail_on_test(doioctl(node, VIDIOC_CREATE_BUFS, &crbufs));   
>         fail_on_test(check_0(crbufs.reserved, sizeof(crbufs.reserved)));
>         fail_on_test(crbufs.index != q.g_buffers());
> 
> crbufs is initialized to fill with 0xff and after VIDIOC_CREATE_BUFS,
> crbufs.reserved field should be 0x0. But v4l2_m2m_create_bufs and
> vb2_create_bufs do not process reserved filed.
> Do we really need to check reserved filed filled with 0x0? Or we need to
> change vb2_create_bufs to fix this issue?

The reserved field is zeroed in v4l_create_bufs() in v4l2-ioctl.c, so even before
vb2_create_bufs et al is called.

The fact that it is no longer zeroed afterwards suggests that someone is messing
with the reserved field.

You'll have to do a bit more digging, I'm afraid.

Regards,

	Hans
