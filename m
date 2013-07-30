From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 30 Jul 2013 10:44:48 +0530
Subject: [PATCH 2/2] arm: omap: remove *.auto* from device names given
 in usb_bind_phy
In-Reply-To: <20130729175413.GC4964@radagast>
References: <1374829418-27503-1-git-send-email-kishon@ti.com>
 <1374829418-27503-3-git-send-email-kishon@ti.com>
 <20130729150638.GD3063@radagast> <51F68A56.8060805@ti.com>
 <20130729175413.GC4964@radagast>
Message-ID: <51F74BC8.7020903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 29 July 2013 11:24 PM, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Jul 29, 2013 at 08:59:26PM +0530, Kishon Vijay Abraham I wrote:
>>>> Previously MUSB wrapper (OMAP) device used PLATFORM_DEVID_AUTO while creating
>>>> MUSB core device. So in usb_bind_phy (binds the controller with the PHY), the
>>>> device name of the controller had *.auto* in it. Since with using
>>>> PLATFORM_DEVID_AUTO, there is no way to know the exact device name in advance,
>>>> the data given in usb_bind_phy became obsolete and usb_get_phy was failing.
>>>> So MUSB wrapper was modified not to use PLATFORM_DEVID_AUTO. Corresponding
>>>> change is done in board file here.
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>>  arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
>>>>  arch/arm/mach-omap2/board-3430sdp.c          |    2 +-
>>>>  arch/arm/mach-omap2/board-cm-t35.c           |    2 +-
>>>>  arch/arm/mach-omap2/board-devkit8000.c       |    2 +-
>>>>  arch/arm/mach-omap2/board-igep0020.c         |    2 +-
>>>>  arch/arm/mach-omap2/board-ldp.c              |    2 +-
>>>>  arch/arm/mach-omap2/board-omap3beagle.c      |    2 +-
>>>>  arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
>>>>  arch/arm/mach-omap2/board-omap3logic.c       |    2 +-
>>>>  arch/arm/mach-omap2/board-omap3pandora.c     |    2 +-
>>>>  arch/arm/mach-omap2/board-omap3stalker.c     |    2 +-
>>>>  arch/arm/mach-omap2/board-omap3touchbook.c   |    2 +-
>>>>  arch/arm/mach-omap2/board-overo.c            |    2 +-
>>>>  arch/arm/mach-omap2/board-rm680.c            |    2 +-
>>>>  arch/arm/mach-omap2/board-rx51.c             |    2 +-
>>>>  arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +-
>>>>  16 files changed, 16 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
>>>> index 244d8a5..17bb076 100644
>>>> --- a/arch/arm/mach-omap2/board-2430sdp.c
>>>> +++ b/arch/arm/mach-omap2/board-2430sdp.c
>>>> @@ -233,7 +233,7 @@ static void __init omap_2430sdp_init(void)
>>>>  	omap_hsmmc_init(mmc);
>>>>  
>>>>  	omap_mux_init_signal("usb0hs_stp", OMAP_PULL_ENA | OMAP_PULL_UP);
>>>> -	usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
>>>> +	usb_bind_phy("musb-hdrc.0", 0, "twl4030_usb");
>>>
>>> how about moving usb_bind_phy() calls to omap2430.c ?
>>>
>>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
>>> index f44e8b5..b6abc1a 100644
>>> --- a/drivers/usb/musb/omap2430.c
>>> +++ b/drivers/usb/musb/omap2430.c
>>> @@ -544,6 +544,9 @@ static int omap2430_probe(struct platform_device *pdev)
>>>  
>>>  		pdata->board_data	= data;
>>>  		pdata->config		= config;
>>> +	} else {
>>> +		/* bind the PHY */
>>> +		usb_bind_phy(dev_name(&musb->dev), 0, "twl4030_usb");
>>
>> This looks like a hack IMHO to workaround the usb phy library. otherwise it is
>> similar to get_phy_by_name.
> 
> actually, this is a workaround to the fact that we're not creating all
> platform_devices in arch/arm/mach-omap2/ :-)
> 
> If we had the musb allocation there, we could easily handle
> usb_bind_phy()
> 
>>> so that's temporary. It might be better than to reintroduce the IDR in
>>> musb_core.c.
>>
>> that?s needed for generic phy framework anyway :-s
> 
> right, but generic phy framework can handle everything just fine, the
> only problem is that names are changing.

right. But if the names change, PHY framework wouldn't be able to return the
reference to the PHY.

Thanks
Kishon
