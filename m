From: christian.koenig@amd.com (=?UTF-8?Q?Christian_K=c3=b6nig?=)
Date: Wed, 11 Apr 2018 11:17:04 +0200
Subject: [PATCH V2] drm/amdgpu: limit DMA size to PAGE_SIZE for
 scatter-gather buffers
In-Reply-To: <20180411062602.GA29109@hr-amur2>
References: <1523394001-4615-1-git-send-email-okaya@codeaurora.org>
 <20180411062602.GA29109@hr-amur2>
Message-ID: <6f99b01f-2f3c-7263-9df8-f8a73f4a9372@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 11.04.2018 um 08:26 schrieb Huang Rui:
> On Tue, Apr 10, 2018 at 04:59:55PM -0400, Sinan Kaya wrote:
>> Code is expecing to observe the same number of buffers returned from
>> dma_map_sg() function compared to sg_alloc_table_from_pages(). This
>> doesn't hold true universally especially for systems with IOMMU.
>>
>> IOMMU driver tries to combine buffers into a single DMA address as much
>> as it can. The right thing is to tell the DMA layer how much combining
>> IOMMU can do.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Sinan, I guess Christian's suggestion is to add amdgpu_device_init function
> like here:

Yes, exactly. Looks like Sinan just tried to place the call next to 
pci_set_dma_mask()/pci_set_consistent_dma_mask().

Not necessary a bad idea, but in this case not optimal.

Sinan please refine your patch as Rui suggested and resend.

Thanks,
Christian.

>
> 8<-------
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0e798b3..9b96771 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2339,6 +2339,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>          /* init the mode config */
>          drm_mode_config_init(adev->ddev);
>
> +       dma_set_max_seg_size(adev->dev, PAGE_SIZE);
> +
>          r = amdgpu_device_ip_init(adev);
>          if (r) {
>                  /* failed in exclusive mode due to timeout */
> 8<-------
>
> After that, we don't do it in each generation.
>
> Thanks,
> Ray
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
