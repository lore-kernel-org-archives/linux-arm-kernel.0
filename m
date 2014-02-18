From: sthokal@xilinx.com (Srikanth Thokala)
Date: Tue, 18 Feb 2014 16:58:04 +0530
Subject: [PATCH v3 1/3] dma: Support multiple interleaved frames with
 non-contiguous memory
In-Reply-To: <CAJe_Zhc_GNNSDWNFuk+cMHEqxfSCJB_ey=Bf+SwJK-nS=u9ceg@mail.gmail.com>
References: <1392465619-27614-1-git-send-email-sthokal@xilinx.com>
 <1392465619-27614-2-git-send-email-sthokal@xilinx.com>
 <CAJe_Zhc_GNNSDWNFuk+cMHEqxfSCJB_ey=Bf+SwJK-nS=u9ceg@mail.gmail.com>
Message-ID: <CA+mB=1KdZZpTmpA0Xp_c4mhgFbjRZ6urYrCwdvoTCmcugQMDUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 3:27 PM, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> On 15 February 2014 17:30, Srikanth Thokala <sthokal@xilinx.com> wrote:
>> The current implementation of interleaved DMA API support multiple
>> frames only when the memory is contiguous by incrementing src_start/
>> dst_start members of interleaved template.
>>
>> But, when the memory is non-contiguous it will restrict slave device
>> to not submit multiple frames in a batch.  This patch handles this
>> issue by allowing the slave device to send array of interleaved dma
>> templates each having a different memory location.
>>
> How fragmented could be memory in your case? Is it inefficient to
> submit separate transfers for each segment/frame?
> It will help if you could give a typical example (chunk size and gap
> in bytes) of what you worry about.

With scatter-gather engine feature in the hardware, submitting separate
transfers for each frame look inefficient. As an example, our DMA engine
supports up to 16 video frames, with each frame (a typical video frame
size) being contiguous in memory but frames are scattered into different
locations. We could not definitely submit frame by frame as it would be
software overhead (HW interrupting for each frame) resulting in video lags.

By this approach, it will allow slave device to submit multiple frames at
once.

Srikanth

>
> Thanks,
> Jassi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
