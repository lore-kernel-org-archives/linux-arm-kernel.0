From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 8 Mar 2016 09:42:24 -0700
Subject: [PATCH 2/5] ARM: bcm2835: Replace alt0/i2s_alt[02] with standard
 groups.
In-Reply-To: <CACRpkdYzSt=R7j9GLSY39CsyMKLjqRYnP_31ti5jWiGngJacqA@mail.gmail.com>
References: <1456510756-15337-1-git-send-email-eric@anholt.net>
 <1456510756-15337-3-git-send-email-eric@anholt.net>
 <CACRpkdYzSt=R7j9GLSY39CsyMKLjqRYnP_31ti5jWiGngJacqA@mail.gmail.com>
Message-ID: <56DF00F0.3080801@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2016 01:24 AM, Linus Walleij wrote:
> On Sat, Feb 27, 2016 at 1:19 AM, Eric Anholt <eric@anholt.net> wrote:
>
>> Since all of these pins were documented, we can use their names to
>> explain what's going on.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>
>> +       pinctrl-0 = <&i2c0_gpio0
>> +                    &i2c1_gpio2
>> +                    &gpclk0_gpio4
>> +                    &gpclk1_gpio5
>> +                    &spi0_gpio7
>> +                    &pcm_gpio18
>> +                    &pwm0_gpio40
>> +                    &pwm1_gpio45
>> +                    &gpioout
>> +                    &alt3>;
>
> Why are all of these done as hogs instead of being in pinctrl-0
> "default" for the device that is using them? i2c1, gpclk0,
> etc?
>
> The only reason I see would be if they are unused or something.

I think it makes sense to have the pinctrl driver (or even FW before the 
kernel boots) set up everything at once where possible. That's the 
easiest way to ensure there are never any conflicts in the pinmux table 
(i.e. that two different pins don't end up being both muxed to SPI1's 
MISO signal at the same time for a while before all the drivers probe). 
Putting pinctrl entries into individual devices only makes sense to me 
when one of:

a) That device needs to dynamically change the pinmux at run-time, e.g. 
to switch between different states, so needs definitions of those 
different states.

or:

b) The initial pinmux is guaranteed set up to a safe non-conflicting 
state that enables very little, and we need to defer enabling various 
peripherals until a later time when we know the peripheral is in use, 
e.g. when loading a DT overlay from user-space.

On the RPi there are certain peripherals that fall into each category, 
e.g. SD card is always used, I2S only optionally used.
