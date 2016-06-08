From: liviu.dudau@arm.com (liviu.dudau at arm.com)
Date: Wed, 8 Jun 2016 11:42:09 +0100
Subject: HDLCD crashes with 6d910bfa809e
In-Reply-To: <69f6ce7f-2c60-319a-fa65-b52a74db5460@samsung.com>
References: <5756B8A8.8000902@arm.com>
 <20160607133535.GA1165@e106497-lin.cambridge.arm.com>
 <5756D602.4090305@arm.com>
 <20160607143425.GE1165@e106497-lin.cambridge.arm.com>
 <3c4d34f5-a924-587e-5956-c21d528f24bf@samsung.com>
 <20160608090507.GG1165@e106497-lin.cambridge.arm.com>
 <69f6ce7f-2c60-319a-fa65-b52a74db5460@samsung.com>
Message-ID: <20160608104209.GH1165@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 12:01:20PM +0200, Marek Szyprowski wrote:
> Hi Liviu,

Hi Marek,

[HDLCD bug report content removed]

> >>>OK, the problem is that commit 59ce4039727ef40 has changed the behaviour from when
> >>>there is no "memory-region" phandle in the DT: before it used to return -ENODEV, now
> >>>it returns -EINVAL.
> >>>
> >>>Marek, I quite liked the old behaviour to detect if the DT had the optional (from
> >>>my driver's point of view) "memory-region" phandle. Plus the check for dev is superfluous
> >>>when using of_reserved_mem_device_init() as that uses dev->of_node for np so it would
> >>>crash before the check anyway. Maybe move the check there?
> >>>
> >>>Until then I suggest reverting the 59ce4039727ef40 commit.
> >>I've just send a fix for this issue. I'm sorry for the regression. I hope
> >>the fix fill
> >>quickly get into next to solve your problem.
> >Thanks for the patch, however I have some comments to it.
> >
> >>The additional check for null dev make sense, because the new function
> >>of_reserved_mem_device_init_by_idx can be called with any device and node
> >>pointer not
> >>embedded with it, so I would like to keep it safe.
> >And I have to admit I find that scary. Why do you accept any node that is *not* related to
> >the device? If you want just the ability to parse multiple "memory-region" phandles (where
> >are the bindings defined for that?) I would have modified of_reserved_mem_device_init() to
> >the the parsing and accept either the single entry style or a node with multiple
> >"memory-region" phandles in it. Otherwise I can steal the "memory-region" of another device
> >and that device would have no idea that I have done this.
> 
> The idea is not to steal memory region from another device, but to let
> driver to use multiple
> regions assigned to the supported device with dma-mapping api. To use them
> with dma-mapping
> subsystem, one needs separate struct device for each reserved region. The
> idea is to create
> child devices of the device, which has memory-region property. Then for each
> such child
> device, driver can call of_reserved_mem_device_init_by_idx() to enable usage
> of dma-mapping
> api based on the selected reserved region. Such approach was already used
> for long time in
> the media/platform/s5p-mfc driver and now it has been converted to use
> generic reserved
> memory regions.
> 
> If you feel scary about this approach, maybe a check if the device provided
> to
> of_reserved_mem_device_init_by_idx() function is one of the successors of
> the device hidden
> behind the provided node pointer (or points to the same device)?

That would not hurt to have.

> 
> >Can you point me to the latest thread where this patch has been discussed?
> 
> This patch is a part of "Exynos: MFC driver: reserved memory cleanup and
> IOMMU support" thread
> and has been around for a while:
> https://www.mail-archive.com/linux-media at vger.kernel.org/msg97645.html

Thanks! I'm not subscribed to linux-media and way behind a lot of other MLs, so
I have not noticed it.

I've had a look at the patchset, found one case where you might leak some memory.

I also think you could've had an of_reserved_mem_device_init_list() function
that inits all the "memory-region" nodes and returns a list struct reserved_mem*
that the driver can then assign to whatever internal variables it has. That
way you can validate that all the "memory-region" phandles are used by the same
parent device.

Best regards,
Liviu


> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
