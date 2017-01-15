From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 15 Jan 2017 16:44:20 +0100
Subject: [RFT PATCH] ARM64: dts: meson-gxbb: Add reserved memory zone and
 usable memory range
In-Reply-To: <90d5b5a3-6dd8-aab2-8701-112a10e3364c@gmx.de>
References: <20161212101801.28491-1-narmstrong@baylibre.com>
 <09bb78ed-c8ec-d21f-d464-16e55c481d4e@gmx.de>
 <56869b90-6bee-f6ae-a7b1-884b4c0d72c0@baylibre.com>
 <2ac01237-a7f8-5b3b-0f97-dd49ce6623fb@gmx.de>
 <90d5b5a3-6dd8-aab2-8701-112a10e3364c@gmx.de>
Message-ID: <612bc7bc-4ee4-51c0-d7ac-06151854ac03@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 23.12.2016 um 10:42 schrieb Heinrich Schuchardt:
> it really makes a difference if we write
> 
>  	memory at 0 {
>  		device_type = "memory";
>  		linux,usable-memory = <0x0 0x1000000 0x0 0x7f000000>;
>  	};
> 
> or
> 
>  	memory at 0 {
>  		device_type = "memory";
>  		reg = <0x0 0x1000000 0x0 0x7f000000>;
>  	};
> 
> The second version leads to failure of the Odroid C2.
> 
> When I looked at /sys/firmware/fdt I saw this difference:
> 
> --- fails
> +++ works
> 
>         memory at 0 {
> -               device_type = "memory";
>                 reg = <0x0 0x0 0x0 0x78000000>;
> +               device_type = "memory";
> +               linux,usable-memory = <0x0 0x1000000 0x0 0x7f000000>;
>         };
> 
> I found the following sentence in the NXP forum:
> In case you want to overwrite the memory usage passed from u-boot, you
> can use "linux,usable-memory".
> https://community.nxp.com/thread/382284

The Odroid-C2 is in mainline U-Boot. Please submit a patch to U-Boot
instead of forcing the creation of unnecessary new .dts files onto
everyone due to hardcoded linux,usable-memory properties. In fact, it
already reserves 0x1000000, so it seems you are merely using an older
U-Boot.

http://git.denx.de/?p=u-boot.git;a=blob;f=arch/arm/mach-meson/board.c;h=f159cbf849f75ab046e6f3a025bbc97c0bcfd59d;hb=HEAD#l39

I would bet that the upper limit is unrelated here.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
