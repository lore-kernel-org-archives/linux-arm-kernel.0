From: boojin.kim@samsung.com (Boojin Kim)
Date: Tue, 16 Aug 2011 18:20:39 +0900
Subject: [PATCH] amba: consolidate PrimeCell magic
In-Reply-To: <CACRpkdZ=cPen0KvK3__iabu8Xwhz8Yjcb-ev-qLe_AY4jaYACA@mail.gmail.com>
References: <1313402104-27024-1-git-send-email-linus.walleij@stericsson.com>
	<001601cc5be9$275a5200$760ef600$%kim@samsung.com>
	<CACRpkdZ=cPen0KvK3__iabu8Xwhz8Yjcb-ev-qLe_AY4jaYACA@mail.gmail.com>
Message-ID: <000101cc5bf5$c38bdca0$4aa395e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij [mailto:linus.walleij at linaro.org] wrote:
> Sent: Tuesday, August 16, 2011 5:36 PM
> To: Boojin Kim
> Cc: Linus Walleij; linux-arm-kernel at lists.infradead.org; Lee Jones;
> Kukjin Kim; Viresh Kumar
> Subject: Re: [PATCH] amba: consolidate PrimeCell magic
>
> On Tue, Aug 16, 2011 at 9:50 AM, Boojin Kim <boojin.kim@samsung.com>
> wrote:
>
> > diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
> > index 2b3b8b3..af6d96d 100644
> > --- a/arch/arm/common/pl330.c
> > +++ b/arch/arm/common/pl330.c
> > @@ -1822,6 +1822,8 @@ int pl330_add(struct pl330_info *pi)
> > ? ? ? ?struct pl330_dmac *pl330;
> > ? ? ? ?int i, ret;
> > ? ? ? ?u32 cid, pid;
> > + ? ? ? struct amba_device *adev = container_of(pi->dev,
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct amba_device, dev);
> >
> > ? ? ? ?if (!pi || !pi->dev)
> > ? ? ? ? ? ? ? ?return -EINVAL;
> > @@ -1841,8 +1843,8 @@ int pl330_add(struct pl330_info *pi)
> > ? ? ? ?cid = amba_get_cid(pi->base, PCELL_SIZE);
> > ? ? ? ?pid = amba_get_pid(pi->base, PCELL_SIZE);
> > ? ? ? ?if (cid != AMBA_CID ||
> > - ? ? ? ? ? amba_manf(pid) != AMBA_VENDOR_ARM ||
> > - ? ? ? ? ? amba_part(pid) != PART) {
> > + ? ? ? ? ? amba_manf(adev) != AMBA_VENDOR_ARM ||
> > + ? ? ? ? ? amba_part(adev) != PART) {
> > ? ? ? ? ? ? ? ?dev_err(pi->dev, "PID: 0x%x, CID: 0x%x !\n", pid, cid);
> > ? ? ? ? ? ? ? ?return -EINVAL;
> > ? ? ? ?}
>
> Ah! If I can access the adev from here it must have probed
> earlier, and then the entire check is superfluous, since the AMBA
> probe has already checked this in drivers/amba/bus.c.
>
> I guess it should just be deleted then?
Actually, I tested this patch after applying my patches that uses
'dma-pl330' driver instead of the samsung specific 's3c-pl330' driver.
'dma-pl330' driver is registered as 'amba_device'. So, this has already
checked on 'drivers/amba/bus.c' as your notice.
But, 's3c-pl330' driver is registered as 'platform_device'. So, This check
is required.
In my opinion, This check can be deleted if caller device is registered as
'amba_device'.

>
> Linus
