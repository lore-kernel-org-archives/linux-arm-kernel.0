From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 7 Feb 2014 10:30:16 +0800
Subject: [PATCH v2] pwm: add CSR SiRFSoC PWM driver
In-Reply-To: <201402061627.17086.arnd@arndb.de>
References: <1391061145-2078-1-git-send-email-21cnbao@gmail.com>
 <201401311623.56902.arnd@arndb.de>
 <CAGsJ_4xmtt2Pg_mHJmvt9uc3Y4gN7KUT1UOJhbr6FQYdiAH3qw@mail.gmail.com>
 <201402061627.17086.arnd@arndb.de>
Message-ID: <CAGsJ_4z8nKUF7+quo6VRyHqr9Z_MiM9TnQt4Vz0Xhh+qWQoupA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-02-06 23:27 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 06 February 2014, Barry Song wrote:
>> > How about modeling  that other source as a fixed-rate clock in DT
>> > then?
>>
>> sirfsoc clock drivers have a clock node for OSC whose index is "1".
>> do you think the following is the right way to handle?
>>
>> in dts, put both pwm controller clock and OSC
>> 672                         pwm: pwm at b0130000 {
>> 673                                 compatible = "sirf,prima2-pwm";
>> 674                                 #pwm-cells = <2>;
>> 675                                 reg = <0xb0130000 0x10000>;
>> 676                                 clocks = <&clks 21>,  <&clks 1>;
>> 677                                 clock-names = "pwmc", "osc";
>> 678                         };
>>
>> and in pwm-sirf.c driver, use
>> clk = clk_get(dev, "osc");
>> clk_get_rate(clk);
>>
>> to get the rate in probe()?
>
> Ah, if that's the right clock, it sounds great, yes.
>
> Just make sure that the clock-names values make sense from the
> point of view of the pwm node, rather than referring to the
> name given in the clock provider.

from the point of clock provider, it is "osc", from the view of pwm,
it is the clock source of PWM waves.
so i guess "clk_pwm_source" is preferred?

>
>         Arnd

-barry
