From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Mon, 9 May 2016 23:53:14 +0300
Subject: [PATCH 4/7] [media] ir-rx51: add DT support to driver
In-Reply-To: <20160509200657.GA3379@rob-hp-laptop>
References: <1462634508-24961-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1462634508-24961-5-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160509200657.GA3379@rob-hp-laptop>
Message-ID: <5730F8BA.5000402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On  9.05.2016 23:06, Rob Herring wrote:
> On Sat, May 07, 2016 at 06:21:45PM +0300, Ivaylo Dimitrov wrote:
>> With the upcoming removal of legacy boot, lets add support to one of the
>> last N900 drivers remaining without it. As the driver still uses omap
>> dmtimer, add auxdata as well.
>>
>> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>> ---
>>   .../devicetree/bindings/media/nokia,lirc-rx51         | 19 +++++++++++++++++++
>>   arch/arm/mach-omap2/pdata-quirks.c                    |  6 +-----
>>   drivers/media/rc/ir-rx51.c                            | 11 ++++++++++-
>>   3 files changed, 30 insertions(+), 6 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/media/nokia,lirc-rx51
>>
>> diff --git a/Documentation/devicetree/bindings/media/nokia,lirc-rx51 b/Documentation/devicetree/bindings/media/nokia,lirc-rx51
>> new file mode 100644
>> index 0000000..5b3081e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/nokia,lirc-rx51
>> @@ -0,0 +1,19 @@
>> +Device-Tree bindings for LIRC TX driver for Nokia N900(RX51)
>> +
>> +Required properties:
>> +	- compatible: should be "nokia,lirc-rx51".
>
> lirc is a Linux term. Also, nokia,rx51-... would be conventional
> ordering.
>

I used the driver name ("lirc_rx51") to not bring confusion. Also, it 
registers itself through lirc_register_driver() call, so having lirc in 
its name somehow makes sense.

I am not very good in inventing names, the best compatible I can think 
of is "nokia,rx51-ir". Is that ok?

> Is this anything more than a PWM LED?
>

It is an IR LED connected through a driver to McSPI2_SIMO pin of OMAP3, 
which pin can be configured as PWM or GPIO(there are other 
configurations, but they don't make sense). In theory it could be used 
for various things (like uni-directional serial TX, or stuff like that), 
but in practice it allows N900 to be act as an IR remote controller. I 
guess that fits in "nothing more than a PWM LED", more or less.

>> +	- pwms: specifies PWM used for IR signal transmission.
>> +
>> +Example node:
>> +
>> +	pwm9: dmtimer-pwm at 9 {
>> +		compatible = "ti,omap-dmtimer-pwm";
>> +		ti,timers = <&timer9>;
>> +		#pwm-cells = <3>;
>> +	};
>> +
>> +	ir: lirc-rx51 {
>> +		compatible = "nokia,lirc-rx51";
>> +
>> +		pwms = <&pwm9 0 26316 0>; /* 38000 Hz */
>> +	};

Thanks,
Ivo
