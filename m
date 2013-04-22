From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 22 Apr 2013 14:11:12 +0530
Subject: Multiple issues with omap4 panda es in linux next
In-Reply-To: <20130419171318.GK10155@atomide.com>
References: <20130419171318.GK10155@atomide.com>
Message-ID: <5174F7A8.7070308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 19 April 2013 10:43 PM, Tony Lindgren wrote:
> Hi all,
>
> Here's a list of breakage I've noticed so far while trying to
> use linux next on my pandaboard es. Probably similar issues exist
> on other boards as well.
>
> Ideally we would not have any breakage by the merge window, so
> let's try to get these fixed ASAP:
>
> 1. Serial console broken on panda es booting with DT
>
> The symptoms are dmesg output stopping after few lines
> and only continuing after pressing a key. Does not seem to
> happen on blaze with DT for some reason. And does not happen
> on panda es with legacy booting.
>
> 2. MUSB fails with legacy booting and DT on panda es
>
> With both legacy and DT booting I get something like:
>
> HS USB OTG: no transceiver configured
> musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517

The dt should work fine with https://patchwork.kernel.org/patch/2423061/.

But non-dt has got a real issue. We were using usb_bind_phy() for 
binding the controller with the PHY (we use device names). But in 
linux-next the device names have changed because of using 
PLATFORM_DEVID_AUTO. We can modify the usb_bind_phy() calls to use the 
new device names, But I suspect the device names can change again. Not 
sure what we can do here :-(

Thanks
Kishon
