From: kernel@martin.sperl.org (Martin Sperl)
Date: Sat, 16 Jan 2016 17:47:50 +0100
Subject: [PATCH V2 2/3] ARM: bcm2835: I2S: use new register-range and
 clock framework
In-Reply-To: <569A6134.6070504@lategoodbye.de>
References: <1452602149-5875-1-git-send-email-kernel@martin.sperl.org>
 <1452602149-5875-3-git-send-email-kernel@martin.sperl.org>
 <569A6134.6070504@lategoodbye.de>
Message-ID: <25D01EDB-5DD2-4604-B42E-97BB1D186EBD@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 16.01.2016, at 16:26, Stefan Wahren <info@lategoodbye.de> wrote:
> 
> Hi Martin,
> 
> [add Mike and Remi]
> 
> Am 12.01.2016 um 13:35 schrieb kernel at martin.sperl.org:
>> From: Martin Sperl <kernel@martin.sperl.org>
>> 
>> Since the move to the new clock framework with commit 94cb7f76caa0
>> ("ARM: bcm2835: Switch to using the new clock driver support.")
>> the bcm2835-i2s driver was no longer working.
>> 
>> This patch fixes the address ranges:
>> * remove the PCM clock register range that is owned by the clockmanager
>> * fix the length, which did not include the last register of this device
>> 
>> It also adds the required pcm-clock.
>> 
>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>> ---
>>  arch/arm/boot/dts/bcm2835.dtsi |    5 ++---
> 
> this won't apply, because the file has been renamed to bcm283x.dtsi.

Well - this "rename? was and still is not merged upstream, so it is an
unfortunate circumstance as I am going on vacation and can not create a
new patchset until I return. So please take it as a template
when applying it.

> 
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
>> index aef64de..83d9787 100644
>> --- a/arch/arm/boot/dts/bcm2835.dtsi
>> +++ b/arch/arm/boot/dts/bcm2835.dtsi
>> @@ -120,9 +120,8 @@
>> 
>>  		i2s: i2s at 7e203000 {
>>  			compatible = "brcm,bcm2835-i2s";
>> -			reg = <0x7e203000 0x20>,
>> -			      <0x7e101098 0x02>;
>> -
>> +			reg = <0x7e203000 0x24>;
>> +			clocks = <&clocks BCM2835_CLOCK_PCM>;
> 
> After applying clk series ([PATCH V4 0/7] clk: bcm2835: add clocks and add MASH support) and this series the pcm clock is an orphan.
> 
> Do we need to add "assigned-clocks" to the i2s node just like for pwm [1]?

In my experience it is not needed for PCM, as the clock is set by the
bcm2835-i2s driver, so I left it out.

As I do not know how the orphan PWM clock would be used I can not comment
if this is really needed with PWM or not - it would just set the default
clock if it got referenced in the DT.

Thanks,
	Martin
