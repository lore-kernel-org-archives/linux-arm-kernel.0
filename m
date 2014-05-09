From: pekon@ti.com (Gupta, Pekon)
Date: Fri, 9 May 2014 10:32:02 +0000
Subject: [RFC 13/47] mtd: nand: stm_nand_bch: provide Device Tree support
In-Reply-To: <20140509100304.GR5767@lee--X1>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
 <1395735604-26706-14-git-send-email-lee.jones@linaro.org>
 <20980858CB6D3A4BAE95CA194937D5E73EAB5C83@DBDE04.ent.ti.com>
 <20140430125406.GN29462@lee--X1>
 <20980858CB6D3A4BAE95CA194937D5E73EACA3F0@DBDE04.ent.ti.com>
 <20140509100304.GR5767@lee--X1>
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EACBC8F@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From: Lee Jones [mailto:lee.jones at linaro.org]
>
>> >> >+	of_property_read_u32(np, "st,bch-bitflip-threshold",
>> >> >+			     &pdata->bch_bitflip_threshold);
>> >> >+
>> >> mtd->bitflip_threshold is by default set to ecc.strength (unless a driver initializes it).
>> >> And then can be re-configured for each MTD partition separately
>> >> 	/sys/class/mtd/mtdX/bitflip_threshold
>> >> 	Refer: $kernel/Documentation/ABI/testing/sysfs-class-mtd
>> >> So, I don't think this is a HW parameter, and so should not be passed from DT.
>> >
>> >I think the bit-flip threshold is/can be chip specific, and as we know
>> >which chip we're likely to be booting on, we can specify this via the
>> >hardware description.  Thus, I think it's perfectly viable for an
>> >option to pass through DT to exist.
>> >
>> I don't think that?s the correct interpretation of bitflip_threshold.
>>
>> (1) bitflip_threshold is dependent on ecc.strength (ECC scheme) of your driver.
>> MTD layers uses bitflip_threshold to warn above layers that number of
>> correctable bit-flips have reached a dangerous level beyond which driver's
>> ECC scheme may not be able to correct them. So above layers should start
>> taking additional corrective action like scrubbing.
>> 	@@drivers/mtd/mtdcore.c: mtd_read()
>> 		return ret_code >= mtd->bitflip_threshold ? -EUCLEAN : 0;
>>
>> (2) Also, user-space may control it based on how your device ages on field.
>> A fresh silicon may not show too many bitflips. But as device ages the
>> probability of simultaneous bitflips will increase. So user-space may lower
>> the bitflip_threshold to avoid accumulation of bitflips in a single page.
>>
>> Thus, bitflip_threshold should not be passed via DT.
>> It's neither a hardware parameter, nor it?s a static constant.
>
>Ah, I see.  I will fixup, thanks for the explanation.
>

Please wait, I'll review your [v2] series also, then you can further
send all fixes together. I'm bit caught in other commitments for 3.16,
so hopefully I'll be able to review your patches by next week.


with regards, pekon
