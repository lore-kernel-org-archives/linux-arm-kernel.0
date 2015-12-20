From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun, 20 Dec 2015 04:14:19 +0200
Subject: [PATCH 2/3] arm: dts: phy3250: add SD fixed regulator
In-Reply-To: <20151219234848.GT8644@n2100.arm.linux.org.uk>
References: <1450567932-22994-1-git-send-email-vz@mleia.com>
 <1450567932-22994-3-git-send-email-vz@mleia.com>
 <20151219234848.GT8644@n2100.arm.linux.org.uk>
Message-ID: <56760EFB.9070406@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.12.2015 01:48, Russell King - ARM Linux wrote:
> On Sun, Dec 20, 2015 at 01:32:11AM +0200, Vladimir Zapolskiy wrote:
>> @@ -162,6 +171,7 @@
>>  				cd-gpios = <&gpio 3 1 0>;
>>  				cd-inverted;
>>  				bus-width = <4>;
>> +				vqmmc-supply = <&sd_reg>;
> 
> This looks wrong.  ios->power_mode controls the _card_ power (which is
> vmmc-supply), not the signalling power (which is vqmmc-supply):

>From drivers/mmc/host/mmci.c mmci_set_ios() manages both regulators,
mmc->supply.vmmc is changed on MMC_POWER_OFF and MMC_POWER_UP,
mmc->supply.vqmmc is changed on MMC_POWER_OFF and MMC_POWER_ON.

But I agree that vmmc-supply is the right choice here, GPIO regulator
controls an SD card power here, thanks for the finding.

> - vmmc-supply            : phandle to the regulator device tree node, mentioned
>                            as the VCC/VDD supply in the eMMC/SD specs.
> 
> - vqmmc-supply           : phandle to the regulator device tree node, mentioned
>                            as the VCCQ/VDD_IO supply in the eMMC/SD specs.
> 
> 

--
With best wishes,
Vladimir
