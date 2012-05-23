From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 23 May 2012 10:37:58 +0200
Subject: [PATCH 1/2] DRM: add Freescale i.MX LCDC driver
In-Reply-To: <20120523074710.GP30400@pengutronix.de>
References: <1337344032-25431-1-git-send-email-s.hauer@pengutronix.de>
 <1337344032-25431-2-git-send-email-s.hauer@pengutronix.de>
 <CAF6AEGuhyRpMo+bsFDwq7A0YOD5BstUtA-z7dRWwwxPK9ru6bg@mail.gmail.com>
 <20120523074710.GP30400@pengutronix.de>
Message-ID: <4FBCA1E6.9050604@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
>>> +
>>> +static int imx_drm_gem_mmap_buffer(struct file *filp,
>>> +               struct vm_area_struct *vma)
>>> +{
>>> +       struct drm_gem_object *obj = filp->private_data;
>>> +       struct imx_drm_gem_obj *imx_drm_gem_obj = to_imx_drm_gem_obj(obj);
>>> +       struct imx_drm_buf_entry *entry;
>>> +       unsigned long pfn, vm_size;
>>> +
>>> +       vma->vm_flags |= VM_IO | VM_RESERVED;
>>> +
>>> +       vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>>
>> pgprot_writecombine()?
> 
> copied from the exynos driver. The exynos driver recently gained support
> for different cache attribute flags and I could do the same. I would
> prefer not to even have to think about it by using some generic code
> here instead of duplicating other peoples bugs.
> 
> Do you think it's possible to share this code as suggested by Lars?
> Every SoC not having a IOMMU could share the same code here, it's just
> not clear to me how we can put this in a form that is acceptable
> upstream.

I may have missed this in the previous discussion. But why can't we put the
gem handling code in the toplevel drm folder, give it a config symbol and
let drivers which want to use the code select the config symbol? I think the
main concern was about introducing a new intermediate layer, but the
"simple" gem support would really just a set of helper functions.

Thanks,
- Lars
