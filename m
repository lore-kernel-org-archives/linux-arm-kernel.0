From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sat, 7 Jan 2012 17:12:26 +0100
Subject: [PATCH v4 1/4] OMAP3: hwmod data: add mmu data for iva and isp
In-Reply-To: <CAB-zwWgZ5QBFBBRQNYrpbcVo4QaZ8MYLVCMDsvAe7scHQSBBKw@mail.gmail.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
 <201112252208.20148.laurent.pinchart@ideasonboard.com>
 <CAB-zwWgZ5QBFBBRQNYrpbcVo4QaZ8MYLVCMDsvAe7scHQSBBKw@mail.gmail.com>
Message-ID: <201201071712.28142.laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Omar,

On Thursday 05 January 2012 20:24:25 Ramirez Luna, Omar wrote:
> On Sun, Dec 25, 2011 at 3:08 PM, Laurent Pinchart wrote:
> >> > I'm not sure how this clock stuff works, but I'm guessing the device
> >> > is supposed to go to sleep at some points in time, and with your patch
> >> > "OMAP3/4: iommu: adapt to runtime pm" it won't, as long as the module
> >> > is loaded, unless I'm missing something.
> >> 
> >> The device should be able to be put to sleep at anytime when it is NOT
> >> being used. AFAIK there is no mechanism for the main processor (the
> >> one running the kernel) to know when the other iommus are not being
> >> used, given that they are in independent processors/subsystems, at
> >> least for the ones in the DSP or M3 processors. Once the user releases
> >> its iommu resource it means it is no longer using it, at that point
> >> the device can be put to sleep.
> > 
> > How should the OMAP3 ISP driver proceed to make sure that its IOMMU is
> > clocked off when it doesn't need it ?
> 
> If there is an specific scenario where the iommu should be disabled,
> iommu_detach_device can be called to release the iommu resource. On
> suspend/resume scenarios runtime pm callbacks should still be able to
> put the device in idle.

Runtime PM might indeed be a better option. The OMAP3 ISP doesn't need to 
IOMMU until video streams are started, so we should keep it powered down in 
that case.

-- 
Regards,

Laurent Pinchart
