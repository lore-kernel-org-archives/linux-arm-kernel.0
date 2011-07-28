From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 28 Jul 2011 14:57:03 +0200
Subject: [RFC/PATCH 2/7] OMAP3: beagle: don't touch omap_device internals
In-Reply-To: <20110728055346.GA11921@foobar>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<1311292338-11830-4-git-send-email-khilman@ti.com>
	<20110722085716.GI32058@legolas.emea.dhcp.ti.com>
	<20110728055346.GA11921@foobar>
Message-ID: <4E315C9F.1030801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nishanth,

On 7/28/2011 7:53 AM, Menon, Nishanth wrote:
> On 11:57-20110722, Felipe Balbi wrote:
> [...]
>>>   	/* Custom OPP enabled for all xM versions */
>>>   	if (cpu_is_omap3630()) {
>>> -		struct omap_hwmod *mh = omap_hwmod_lookup("mpu");
>>> -		struct omap_hwmod *dh = omap_hwmod_lookup("iva");
>>> -		struct device *dev;
>>> +		struct device *mpu_dev, *iva_dev;
>>>
>>> -		if (!mh || !dh) {
>>> +		mpu_dev = omap2_get_mpuss_device();
>>> +		iva_dev = omap2_get_iva_device();
>>
>> out of curiosity again, nothing to do with this patch.
>>
>> Maybe it would be nicer to have an api such as:
>>
>> omap2_get_device(name);
>>
>> there are already four devices to be gotten, if that number grows any
>> bigger, so will the number of helper functions.
> I agree, in fact, on a different topic, I hit the same requirement
> here is the patch I had done:
>  From 9f226def811bd50e4bac02f427604034cef77706 Mon Sep 17 00:00:00 2001
> From: Nishanth Menon<nm@ti.com>
> Date: Wed, 27 Jul 2011 15:02:32 -0500
> Subject: [PATCH] OMAP: hwmod: add omap_hwmod_to_device
>
> omap_hwmod_to_device is useful for drivers when they need to
> look up the device associated with a hwmod name to map back
> into the device structure pointers. These ideally should
> be used by drivers in mach directory. This could in effect
> replace apis such as omap2_get_mpuss_device,
> omap2_get_iva_device, omap2_get_l3_device, omap4_get_dsp_device
> etc..
>
> Signed-off-by: Nishanth Menon<nm@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c             |   33 ++++++++++++++++++++++++++
>   arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
>   2 files changed, 35 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 293fa6c..77d01a2 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -142,6 +142,7 @@
>   #include "powerdomain.h"
>   #include<plat/clock.h>
>   #include<plat/omap_hwmod.h>
> +#include<plat/omap_device.h>

I'd rather put that code inside the omap_device.c instead of here.
The omap_device layer is on top of the omap_hwmod.
In order to minimize the dependencies from the low HW description layer 
to the omap_device layer, you should maybe define a 
omap_device_from_hwmod() function or something similar.

That being said, do we really need to get the device from the hwmod 
name? Cannot we use the device name instead?
I do not know all the usecases, that why I'm asking.

Regards,
Benoit
