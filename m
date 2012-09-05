From: javier.martin@vista-silicon.com (javier Martin)
Date: Wed, 5 Sep 2012 10:22:44 +0200
Subject: [PATCH] ARM : i.MX27 : split code for allocation of ressources of
 camera and eMMA
In-Reply-To: <5047013E.30508@gmail.com>
References: <1346763398-13536-1-git-send-email-gcembed@gmail.com>
 <CACKLOr0PO1jbxrfRoEwEAGFNkNkAFUA-oB2vLZpw1kDxEYPBQw@mail.gmail.com>
 <5047013E.30508@gmail.com>
Message-ID: <CACKLOr1RipM3QVJBaTjXHFotqSMdrCsWLkBsgiiuauTWpxR6EQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 September 2012 09:37, Ga?tan Carlier <gcembed@gmail.com> wrote:
> Hi Javier,
> This is because I will send a patch to add support of eMMA-PP. eMMA-PrP is
> not only used for soc-camera. It can also be used as stand-alone driver and
> now to be able to use eMMA-PrP module, IMX_HAVE_PLATFORM_MX2_CAMERA must be
> set.

Do you mean the following stand-alone driver I submitted some time
ago? Are you working on some improvements to it?
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=drivers/media/video/mx2_emmaprp.c;h=5f8a6f5b98f91c3af4e1bdbd06654e7b496d8d65;hb=HEAD

This driver can be used without applying your patch. Please take a
look at the following patch which is pending to get merged in
linux-media tree:
https://patchwork.kernel.org/patch/1347921/


> And if I follow this logic, I have to put declaration of eMMA-PP with imx-fb
> and eMMA-PP can only be enabled if IMX_HAVE_PLATFORM_IMX_FB.
> Of course, eMMA-PrP is almost always used with soc-camera and eMMA-PP with
> LCDC (imx-fb) but eMMA can be used to do HW accelarated colorspace
> conversion.

Agree, there is already one driver supporting this feature.

> It is not a problem for me to keep eMMA-PrP and mx2-camera together. It was
> just to have a more independant eMMA driver.

I won't oppose to it, for me it is just aesthetic. However, you must
do it properly without breaking existing boards such as Visstrim_M10.

> For the Visstrim_M10 board, I don't think that it is needed to set
> IMX_HAVE_PLATFORM_MX2_EMMA because there is no reference to m2m-emmaprp and
> mx2-camera embeds handling of eMMA-PrP without using eMMA-PrP driver.

The following patch was sent to the list in Agust the 20th and will be
merged in the linux-media tree. This patch does reference m2m-emmaprp
in Visstrim_M10
https://patchwork.kernel.org/patch/1347921/

So, please, since you have to fix the wrong chunk and have to send a
v2 anyways I strongly encourage you to add the flag
IMX_HAVE_PLATFORM_MX2_EMMA to Visstrim_M10. This way nothing will be
broken no matter your patch gets merged after or before mine.

> It seems that eMMA-PrP embeded in mx2camera handles more case than
> stand-alone eMMA-PrP driver. Maybe eMMA-PrP driver needs some review to
> handle all In/Out image formats ?

eMMa-PrP is currently used in two drivers:

1. http://git.linuxtv.org/media_tree.git/blob/refs/heads/staging/for_v3.7:/drivers/media/platform/soc_camera/mx2_camera.c
Where it is used as a substitute to a DMA that moves data between the
CSI and RAM apart from providing more features like format conversion,
etc... This is a soc_camera video capture driver.

2. http://git.linuxtv.org/media_tree.git/blob/refs/heads/staging/for_v3.7:/drivers/media/platform/mx2_emmaprp.c
This is a stand-alone mem2mem v4l2 driver that can get YUYV 422 in the
input and transform it to YUV 420. Of course, the driver can be
extended to support more kinds of conversions.

Regards.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
