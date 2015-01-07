From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 07 Jan 2015 10:33:29 +0100
Subject: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
In-Reply-To: <54AC93E0.8010705@samsung.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <1417514366.21830.22.camel@collabora.co.uk> <54818768.3080303@samsung.com>
 <CABxcv=n=eNqbyBbOk1Wb87tCnnLZAJQurmCdeTOSqMZMbNaSHw@mail.gmail.com>
 <54AC93E0.8010705@samsung.com>
Message-ID: <54ACFD69.1020500@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Joonyoung,

On 01/07/2015 03:03 AM, Joonyoung Shim wrote:
> On 01/06/2015 06:49 PM, Javier Martinez Canillas wrote:
>> 
>> Also I tried forcing the kernel to not disable unused power domains by
>> passing the pd_ignore_unused parameter to the kernel command line. I
>> see on the kernel log a "genpd: Not disabling unused power domains"
>> message but HDMI output still has the stripes that Sjoerd mentioned.
>> Do you know if Exynos DRM HDMI in mainline is supposed to work without
>> SysMMU / IOMMU support?
>> 
> 
> I don't think iommu support and power domain issue are related. I also
> get displaying stripes via hdmi but it is just power domain issue
> regardless iommu support.
> 
> I observed 8th bit from 0x1445000C register of mixer is set to 1 with
> displaying stripes. It means "The graphic layer0 line buffer underflow".
> There was same underflow issue on Exynos4 based boards. As Marek said,
> because LCD0 power domain was turned off.
>

Interesting, thanks a lot for sharing this information.
 
> I just tried to turn off DISP1 power domain at u-boot and DISP1 power
> domain is turned on from kernel hdmi and mixer driver on odroid xu3 
> board. As the result, i can see displaying penguin logo from hdmi.
>

Can you share the patches you are using to turn on the DISP1 power domain
since AFAIU the kernel does not know about the DISP1 power domain after
commit d51cad7df871 ("ARM: dts: remove display power domain for exynos5420").

I tried reverting that commit before so the kernel knows about the DISP1
power domain and booting with pd_ignore_unused but still had the stripes.
 
> But the problem exists still because it is failed to control on/off of
> DISP1 power domain more than twice from kernel hdmi and mixer driver.[0]
>

Something that is not clear to me is how display panel is working on the
Peach boards if this is a power domain issue since according to the manual
both the modules used for display (LCD controller and DP) and the modules
used for HDMI (MIXER and HDMI) belong to the same power domain (DISP1).

Or am I misunderstanding something? 

Thanks a lot for your help and best regards,
Javier
