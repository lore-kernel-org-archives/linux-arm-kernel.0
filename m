From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 24 Feb 2017 16:42:31 -0300
Subject: [PATCH 2/2] media: s5p-mfc: fix MMAP of mfc buffer during reqbufs
In-Reply-To: <1481888915-19624-3-git-send-email-pankaj.dubey@samsung.com>
References: <1481888915-19624-1-git-send-email-pankaj.dubey@samsung.com>
 <1481888915-19624-3-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <81c11e69-b7eb-ccb5-a377-2848ec551274@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Pankaj,

On 12/16/2016 08:48 AM, Pankaj Dubey wrote:
> From: Smitha T Murthy <smitha.t@samsung.com>
> 
> It has been observed on ARM64 based Exynos SoC, if IOMMU is not enabled
> and we try to use reserved memory for MFC, reqbufs fails with below
> mentioned error
> ---------------------------------------------------------------------------
> V4L2 Codec decoding example application
> Kamil Debski <k.debski@samsung.com>
> Copyright 2012 Samsung Electronics Co., Ltd.
> 
> Opening MFC.
> (mfc.c:mfc_open:58): MFC Info (/dev/video0): driver="s5p-mfc" \
> bus_info="platform:12c30000.mfc0" card="s5p-mfc-dec" fd=0x4[
> 42.339165] Remapping memory failed, error: -6
> 
> MFC Open Success.
> (main.c:main:711): Successfully opened all necessary files and devices
> (mfc.c:mfc_dec_setup_output:103): Setup MFC decoding OUTPUT buffer \
> size=4194304 (requested=4194304)
> (mfc.c:mfc_dec_setup_output:120): Number of MFC OUTPUT buffers is 2 \
> (requested 2)
> 
> [App] Out buf phy : 0x00000000, virt : 0xffffffff
> Output Length is = 0x300000
> Error (mfc.c:mfc_dec_setup_output:145): Failed to MMAP MFC OUTPUT buffer
> -------------------------------------------------------------------------
> This is because the device requesting for memory is mfc0.left not the parent mfc0.
> Hence setting of alloc_devs need to be done only if IOMMU is enabled
> and in that case both the left and right device is treated as mfc0 only.
> 

I see, so likely you were facing the issue described in patch 1/2 after this
patch since the driver doesn't set alloc_devs when IOMMU is disabled, right?

In any case, I guess these patches have been superseded by Marek's series[0]
so they are no longer needed?

[0]: https://www.spinics.net/lists/linux-media/msg111156.html

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
