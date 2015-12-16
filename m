From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Wed, 16 Dec 2015 14:47:52 +0100
Subject: [PATCH v2 6/8] [Media] vcodec: mediatek: Add Mediatek V4L2 Video
 Encoder Driver
In-Reply-To: <1450271857.6730.26.camel@mtksdaap41>
References: <1449827743-22895-1-git-send-email-tiffany.lin@mediatek.com>
 <1449827743-22895-7-git-send-email-tiffany.lin@mediatek.com>
 <566EBAFC.3010408@xs4all.nl> <1450187460.21350.35.camel@mtksdaap41>
 <567020F1.1000204@cisco.com> <1450271857.6730.26.camel@mtksdaap41>
Message-ID: <56716B88.7090301@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/16/15 14:17, tiffany lin wrote:
> Hi Hans,
> 
> 
> On Tue, 2015-12-15 at 15:17 +0100, Hans Verkuil wrote:
>>
>> On 12/15/15 14:51, tiffany lin wrote:
>>> We are not familiar with v4l2-compliance utility, we will check how to
>>> use it.
>>
>> It's part of v4l-utils.git (http://git.linuxtv.org/v4l-utils.git/). There is a
>> fairly decent man page. It does exhaustive compliance tests for V4L2 devices.
>>
>> That said, the support for memory-to-memory codec devices is not great, so I wouldn't
>> trust any failures it reports when using the streaming tests (i.e. the --stream*
>> options). By default just run 'v4l2-compliance -d /dev/videoX' to do the compliance
>> test.
>>
>> Note: before I accept this driver I do want to see that compliance test output!
>>
> Got it. We will provide it in next version.
> Now our driver is developed and run base on kernel v3.18.
> V4L2 and vb2 have some difference between Linux 4.4-rc1 and 3.18 kernel.
> Is it ok we provided test output base on v3.18 or we need to base on
> 4.4-rc1?

I'm actually not sure if the latest v4l2-compliance test suite will work with a 3.18
kernel. so either you have to go back to an older version of v4l2-compliance that
works with 3.18 (go back to commit 4a57509a8334aca6ca8e81cd3beb08d5be397dac, that
might do the trick) or (and that's what I recommend) go with the latest kernel.

For the media tree that is http://git.linuxtv.org/media_tree.git/log/.

The final version of the patch has to be against that kernel anyway.

>>>>> +}
>>>>> +
>>>>> +int m2mctx_venc_queue_init(void *priv, struct vb2_queue *src_vq,
>>>>> +			   struct vb2_queue *dst_vq)
>>>>> +{
>>>>> +	struct mtk_vcodec_ctx *ctx = priv;
>>>>> +	int ret;
>>>>> +
>>>>> +	src_vq->type		= V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
>>>>> +	src_vq->io_modes	= VB2_DMABUF | VB2_MMAP | VB2_USERPTR;
>>>>
>>>> You're using videobuf2-dma-contig, so VB2_USERPTR is generally useless in that
>>>> case. I would drop it.
>>>>
>>> Sorry, I don't get it. 
>>> We are using videobuf2-dma-contig, but we also using VB2_USERPTR.
>>
>> ???? In that case the user pointer you pass in must point to physically contiguous
>> memory. Which means you got it through some magic. Typically what should be used
>> are dmabuf handles to pass buffers around between different subsystems.
>>
>> The use of VB2_USERPTR for that purpose is deprecated.
>>
>> Or am I misunderstanding you as well?
>>
> Our encoder support all three modes.
> In case that A driver + Encode driver flow, OUTPUT buffer will be
> VB2_DMABUF from A driver.
> In case that read YCbCr frame data from file and encode them to bit
> stream flow, we use VB2_USERPTR and VB2_MMAP.
> In VB2_USERPTR case, videobuf2-dma-contig will help us get continuous
> dma address.
> Our chip has IOMMU and M4U that help us get continuous phy address for
> encode HW.
> 
> http://lists.infradead.org/pipermail/linux-mediatek/2015-October/002525.html

Ah, OK. Have you tested this with malloc()ed buffers? Just asking :-)

Regards,

	Hans
