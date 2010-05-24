From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Mon, 24 May 2010 11:58:31 +0300
Subject: [PATCH v2t2 00/17] omap: mailbox:
In-Reply-To: <20100524.093625.241440026.Hiroshi.DOYU@nokia.com>
References: <20100521221557.GM11042@n2100.arm.linux.org.uk>
	<AANLkTinMFJTlbXYiS9G87VSQyRuGxJfJGHkVejOEfgVQ@mail.gmail.com>
	<20100522.081415.258113387.Hiroshi.DOYU@nokia.com>
	<20100524.093625.241440026.Hiroshi.DOYU@nokia.com>
Message-ID: <AANLkTinVKTmI6PCwTFwfSgvkmv0K1QLATj1xwKEng4hD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 24, 2010 at 9:36 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
>>> Moreover, Tony says that anything that registers platform devices
>>> should be built-in, but omap3-iommu does register devices and is not
>>> built-in.
>>
>> It seems that this makes you confused. It should have been
>> build-in;). This is going to be integrated into omap hwmod framework
>> soon.
>
> For built-in part, it could be something like:
>
> From a09c2040e083f23a43232f97cb29b9aefc9c0d11 Mon Sep 17 00:00:00 2001
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> Date: Mon, 24 May 2010 09:35:11 +0300
> Subject: [PATCH 1/1] omap iommu: Make omap-iommu.o built-in
>
> This is a platform device registration.
>
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
> ?arch/arm/mach-omap2/Makefile | ? ?5 ++++-
> ?1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 7d2cf0f..4d754f6 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -89,7 +89,10 @@ obj-$(CONFIG_OMAP3_EMU) ? ? ? ? ? ? ? ? ? ? ?+= emu.o
> ?obj-$(CONFIG_OMAP_MBOX_FWK) ? ? ? ? ? ?+= mailbox_mach.o
> ?mailbox_mach-objs ? ? ? ? ? ? ? ? ? ? ?:= mailbox.o
>
> -obj-$(CONFIG_OMAP_IOMMU) ? ? ? ? ? ? ? := iommu2.o omap-iommu.o
> +obj-$(CONFIG_OMAP_IOMMU) ? ? ? ? ? ? ? := iommu2.o
> +
> +iommu-$(CONFIG_OMAP_IOMMU) ? ? ? ? ? ? := omap-iommu.o
> +obj-y ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?+= $(iommu-m) $(iommu-y)
>
> ?i2c-omap-$(CONFIG_I2C_OMAP) ? ? ? ? ? ?:= i2c.o
> ?obj-y                                 ?+= $(i2c-omap-m) $(i2c-omap-y)
> --

I would prefer this:
-obj-$(CONFIG_OMAP_IOMMU) ? ? ? ? ? ? ? := iommu2.o omap-iommu.o
+obj-$(CONFIG_OMAP_IOMMU) ? ? ? ? ? ? ? := iommu2.o
+
+ifneq ($(CONFIG_OMAP_IOMMU),)
+obj-y                                  += omap-iommu.o
+endif

Much clearer, and easier to understand.

-- 
Felipe Contreras
