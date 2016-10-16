From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 16 Oct 2016 21:49:43 +0200
Subject: [PATCH v2] ARM: dts: rockchip: temporarily remove emmc hs200
 speed from rk3288-veyron-speedy.
In-Reply-To: <87twd1vzc5.fsf@aikidev.net>
References: <87twd1vzc5.fsf@aikidev.net>
Message-ID: <1476647383.3885.3.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le mardi 27 septembre 2016 ? 13:53 -0700, Vagrant Cascadian a ?crit?:
> This essentially mimics what was done with rk3288-veyron-minnie in
> commit 984926781122f034d5bc9962815d135b6c4a8e1d.
> 
> The eMMC of the speedy Chromebook also appears to need the same tuning
> workaround, as it frequently fails to recognize the eMMC without it.

I have a device where (without this patch) eMMC sometimes fails, with:
[????3.561010] dwmmc_rockchip ff0f0000.dwmmc: Successfully tuned phase to 175
[????3.571742] mmc2: new HS200 MMC card at address 0001
[????3.571943] mmcblk2: mmc2:0001 HAG2e 14.7 GiB?
[????3.572026] mmcblk2boot0: mmc2:0001 HAG2e partition 1 4.00 MiB
[????3.572107] mmcblk2boot1: mmc2:0001 HAG2e partition 2 4.00 MiB
[????3.572181] mmcblk2rpmb: mmc2:0001 HAG2e partition 3 4.00 MiB
[????3.685647] mmcblk2: error -110 transferring data, sector 0, nr 8, cmd response 0x900, card status 0x0

And sometimes works, with:
[????3.451058] dwmmc_rockchip ff0f0000.dwmmc: Successfully tuned phase to 176
[????3.491093] mmc2: new HS200 MMC card at address 0001
[????3.491277] mmcblk2: mmc2:0001 HAG2e 14.7 GiB?
[????3.491345] mmcblk2boot0: mmc2:0001 HAG2e partition 1 4.00 MiB
[????3.491409] mmcblk2boot1: mmc2:0001 HAG2e partition 2 4.00 MiB
[????3.491474] mmcblk2rpmb: mmc2:0001 HAG2e partition 3 4.00 MiB
[????3.493548]??mmcblk2: p1 p2

However, with this change, it always fails, with:
[????3.322129] mmc_host mmc2: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
[????3.333174] mmc2: error -110 whilst initialising MMC card

I don't have so much time to investigate this issue, but it's clear that this
patch doesn't fix the issue (and actually worsens it) for my device.

Cheers!

> Signed-off-by: Vagrant Cascadian <vagrantc@aikidev.net>
> ---
> Changes in v2:
> ?- Added Signed-off-by.
> 
> ?arch/arm/boot/dts/rk3288-veyron-speedy.dts | 5 +++++
> ?1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
> b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
> index a0d033f..500fd18 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
> +++ b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
> @@ -124,6 +124,11 @@
> ????????????&sdmmc_bus4>;
> ?};
> 
> +
> +&emmc {
> +???????/delete-property/mmc-hs200-1_8v;
> +};
> +
> ?&vcc_5v {
> ????enable-active-high;
> ????gpio = <&gpio7 21 GPIO_ACTIVE_HIGH>;
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
-- 
Paul Kocialkowski, developer of free digital technology at the lower levels

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161016/6ae8dfd0/attachment.sig>
