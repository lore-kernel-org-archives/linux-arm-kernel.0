From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Tue, 18 Feb 2014 22:20:52 +0530
Subject: [PATCH v3 1/3] dma: Support multiple interleaved frames with
 non-contiguous memory
In-Reply-To: <CA+mB=1KdZZpTmpA0Xp_c4mhgFbjRZ6urYrCwdvoTCmcugQMDUA@mail.gmail.com>
References: <1392465619-27614-1-git-send-email-sthokal@xilinx.com>
 <1392465619-27614-2-git-send-email-sthokal@xilinx.com>
 <CAJe_Zhc_GNNSDWNFuk+cMHEqxfSCJB_ey=Bf+SwJK-nS=u9ceg@mail.gmail.com>
 <CA+mB=1KdZZpTmpA0Xp_c4mhgFbjRZ6urYrCwdvoTCmcugQMDUA@mail.gmail.com>
Message-ID: <CAJe_ZhdOmu3k9gbPdQzPteyzwsMA8OzWHdhHnXudbF=X7JMhVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 February 2014 16:58, Srikanth Thokala <sthokal@xilinx.com> wrote:
> On Mon, Feb 17, 2014 at 3:27 PM, Jassi Brar <jaswinder.singh@linaro.org> wrote:
>> On 15 February 2014 17:30, Srikanth Thokala <sthokal@xilinx.com> wrote:
>>> The current implementation of interleaved DMA API support multiple
>>> frames only when the memory is contiguous by incrementing src_start/
>>> dst_start members of interleaved template.
>>>
>>> But, when the memory is non-contiguous it will restrict slave device
>>> to not submit multiple frames in a batch.  This patch handles this
>>> issue by allowing the slave device to send array of interleaved dma
>>> templates each having a different memory location.
>>>
>> How fragmented could be memory in your case? Is it inefficient to
>> submit separate transfers for each segment/frame?
>> It will help if you could give a typical example (chunk size and gap
>> in bytes) of what you worry about.
>
> With scatter-gather engine feature in the hardware, submitting separate
> transfers for each frame look inefficient. As an example, our DMA engine
> supports up to 16 video frames, with each frame (a typical video frame
> size) being contiguous in memory but frames are scattered into different
> locations. We could not definitely submit frame by frame as it would be
> software overhead (HW interrupting for each frame) resulting in video lags.
>
IIUIC, it is 30fps and one dma interrupt per frame ... it doesn't seem
inefficient at all. Even poor-latency audio would generate a higher
interrupt-rate. So the "inefficiency concern" doesn't seem valid to
me.

Not to mean we shouldn't strive to reduce the interrupt-rate further.
Another option is to emulate the ring-buffer scheme of ALSA.... which
should be possible since for a session of video playback the frame
buffers' locations wouldn't change.

Yet another option is to use the full potential of the
interleaved-xfer api as such. It seems you confuse a 'video frame'
with the interleaved-xfer api's 'frame'. They are different.

Assuming your one video frame is F bytes long and Gk is the gap in
bytes between end of frame [k] and start of frame [k+1] and  Gi != Gj
for i!=j
In the context of interleaved-xfer api, you have just 1 Frame of 16
chunks. Each chunk is Fbytes and the inter-chunk-gap(ICG) is Gk  where
0<=k<15
So for your use-case .....
  dma_interleaved_template.numf = 1   /* just 1 frame */
  dma_interleaved_template.frame_size = 16  /* containing 16 chunks */
   ...... //other parameters

You have 3 options to choose from and all should work just as fine.
Otherwise please state your problem in real numbers (video-frames'
size, count & gap in bytes).

-Jassi
