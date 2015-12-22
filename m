From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 22 Dec 2015 15:04:19 +0100
Subject: [PATCH 2/2] ARM: mvebu: use regulator-boot-on on Armada 388 GP
In-Reply-To: <87fuyur7t3.fsf@free-electrons.com> (Gregory CLEMENT's message of
 "Tue, 22 Dec 2015 13:23:20 +0100")
References: <1450708916-15966-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1450708916-15966-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <87fuyur7t3.fsf@free-electrons.com>
Message-ID: <87bn9ir34s.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mar., d?c. 22 2015, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Thomas,
>  
>  On lun., d?c. 21 2015, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
>
>> Really, what we meant by regulator-always-on is that the regulators
>> are already turned on by the bootloader, for which regulator-boot-on
>> is a better description.
>>
>
> What happened if the bootloader do not turn the regulator on?
> I fear that in this case the regulator won't be turned on at all.
>
>> A net advantage of using regulator-boot-on is that the regulator is
>> not touched at boot time by the kernel, which avoids having the hard
>> drives spinning down and then up again, taking several (~5) seconds of
>> additional boot time.

I tested your patch, I didn't see so much time lost in boot time: with
one hdd the difference was only about 0.3s. But with a second hdd it was
around 1.9 (so 1.6s more for the second hhd). It looks like it really
depends on the hdd. However, the most annoying point with the
regulator-always-on for the SATA it turns the power down and up for the
hdd during boot which is not very nice for the hdd. So, at least for
this, it is useful.

For the USB part the regulators are completely disabled:
usb3-vbus: disabling
v5.0-vbus0: disabling
v5.0-vbus1: disabling

And indeed the USB does not work with your patch applied.

Could you send a new version with the changes only done for the SATA
regulator nodes?

Thanks,

Gregory

>>
>> In addition, there is no need to have such properties on the child
>> regulators used for SATA. Having it on the parent regulator that
>> really controls the GPIO is sufficient.
>>
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> ---
>>  arch/arm/boot/dts/armada-388-gp.dts | 24 ++++++++----------------
>>  1 file changed, 8 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
>> index d8dab0f..1ef6cc6 100644
>
>>  
>> @@ -309,7 +309,7 @@
>>  		regulator-min-microvolt = <5000000>;
>>  		regulator-max-microvolt = <5000000>;
>>  		enable-active-high;
>> -		regulator-always-on;
>> +		regulator-boot-on;
>>  		gpio = <&expander0 4 GPIO_ACTIVE_HIGH>;
>>  	};
> This node had been removed by a patch you sent few days ago:
> "ARM: mvebu: remove duplicated regulator definition in Armada 388 GP"
>
> Thanks,
>
> Gregory
>
> -- 
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
