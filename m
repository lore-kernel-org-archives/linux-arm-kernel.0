From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 02 Jul 2013 19:21:52 +0200
Subject: [RFC] Add .dts file for Netgear ReadyNAS 102
References: <87fvvzfh70.fsf@natisbad.org>
 <20130702124639.GI19937@titan.lakedaemon.net>
Message-ID: <87vc4sho7j.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Jason Cooper <jason@lakedaemon.net> writes:

>>  - G762 PWM fan controller on I2C bus: it requires G762 driver which
>>    is *currently sitting in hwmon maintainer tree* and will be available
>>    in 3.11. Jason, as a side note I have a short patch for available for
>>    ReadyNAS Duo v2 .dts file (the device also has a G762). I can hold
>>    it until rc cycle if you prefer.
>
> Nope, post patches when you have them ready.  I am capable of holding
> them until -rc1 drops ;-)

That's the one I sent yesterday (the patch tagged RESEND, i.e. w/o the
fixes for space issue in .dts file)


>> Jason, the tests were done against your for-next branch (with all the
>> fixes which accumulated in Linux tree from rc7). I will work directly
>> against Linus tree as soon as the rc- cycle for 3.11 starts. 
>
> hmmm, my latest for-next (20130623) is based against v3.10-rc7, are you
> using that?


Yes, but with just your tree I got some freezes during boot and applying
the additional commits available in Linux tree, this fixed the issue. I
did not spend much the time but I think this is related to
PJ4B_ERRATA_4742 which you do not have in your for-next branch: 

commit 3e0a07f8c401bb43e0f964c5f1285b2cb2028645
Author: Gregory CLEMENT <gregory.clement@free-electrons.com>
Date:   Sun Jun 23 10:17:11 2013 +0100

    ARM: 7773/1: PJ4B: Add support for errata 4742
    
    This commit fixes the regression on Armada 370 (the kernal hang during
    boot) introduced by the commit: "ARM: 7691/1: mm: kill unused
    TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP instead".

    ...


>>  [snip]
>>
>> +
>> +			/* Waiting for NAND support to appear in armada-370.dtsi
>
> I would just leave this out until we get the driver sorted.

ok, will do that in next versions.


>> +			i2c at 11000 {
>> +				compatible = "marvell,mv64xxx-i2c";
>> +				clock-frequency = <100000>;
>> +				status = "okay";
>> +
>> +				isl12057: isl12057 at 68 {
>> +					compatible = "isil,isl12057";
>> +					reg = <0x68>;
>> +					wakeup-source;
>> +				};

My main question is for ISL12057 RTC chip: I guess it's just pointless to
push the .dts file for the RN102 w/o a working RTC clock?

Cheers,

a+
