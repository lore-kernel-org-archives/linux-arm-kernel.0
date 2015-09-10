From: phil@raspberrypi.org (Phil Elwell)
Date: Thu, 10 Sep 2015 18:02:47 +0100
Subject: [PATCH v5 0/6] bcm2835: auxiliar device support for spi
In-Reply-To: <8B777380-A2A1-475E-8A1C-942BF28EE160@martin.sperl.org>
References: <1441359711-2800-1-git-send-email-kernel@martin.sperl.org>
 <87h9n4weg8.fsf@eliezer.anholt.net> <55F1A651.5090102@tronnes.org>
 <8B777380-A2A1-475E-8A1C-942BF28EE160@martin.sperl.org>
Message-ID: <55F1B7B7.3050604@raspberrypi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Sending again in plain text ]
Noralf pointed me at fixed-factor-clock, and that works in our
(downstream) environment:

    soc: soc {
        ...
        uart1: uart at 7e215040 {
            compatible = "brcm,bcm2835-aux-uart", "ns16550";
            reg = <0x7e215040 0x40>;
            interrupts = <1 29>;
            clocks = <&clk_uart1>;
            reg-shift = <2>;
            no-loopback-test;
            status = "disabled";
            };
    };

    clocks: clocks {
        ...
        clk_core: clock at 2 {
            compatible = "fixed-clock";
            reg = <2>;
            #clock-cells = <0>;
            clock-output-names = "core";
            clock-frequency = <250000000>;
        };
        ...
        clk_uart1: clock at 6 {
            compatible = "fixed-factor-clock";
            clocks = <&clk_core>;
            #clock-cells = <0>;
            clock-div = <1>;
            clock-mult = <2>;
        };
    };

Phil

On 10/09/2015 16:57, Martin Sperl wrote:
>> On 10.09.2015, at 17:48, Noralf Tr?nnes <noralf@tronnes.org> wrote:
>>
>> This looks interesting.
>> But there's a challenge with the uart1 and the 8250 driver.
>>
>> Phil Elwell has this to say:
>> This means that that UART1 isn't an exact clone of a 8250 UART.
>> In a particular, the clock divisor is calculated differently.
>> A standard 8250 derives the baud rate as clock/(divisor16),
>> whereas the BCM2835 mini UART uses clock/(divisor8). This means
>> that if you want to use the standard driver then you need to lie
>> about the clock frequency, providing a value is twice the real
>> value, in order for a suitable divisor to be calculated.
>>
>> Ref: https://github.com/raspberrypi/linux/pull/1008#issuecomment-139234607
>>
>> So either we need a new uart1 driver or a doubled clock freq. somehow.
> Found out the same thing and communicated it to Eric - not 
> knowing about the different divider?
>
> Martin



On 10/09/2015 16:57, Martin Sperl wrote:
>> On 10.09.2015, at 17:48, Noralf Tr?nnes <noralf@tronnes.org> wrote:
>>
>> This looks interesting.
>> But there's a challenge with the uart1 and the 8250 driver.
>>
>> Phil Elwell has this to say:
>> This means that that UART1 isn't an exact clone of a 8250 UART.
>> In a particular, the clock divisor is calculated differently.
>> A standard 8250 derives the baud rate as clock/(divisor16),
>> whereas the BCM2835 mini UART uses clock/(divisor8). This means
>> that if you want to use the standard driver then you need to lie
>> about the clock frequency, providing a value is twice the real
>> value, in order for a suitable divisor to be calculated.
>>
>> Ref: https://github.com/raspberrypi/linux/pull/1008#issuecomment-139234607
>>
>> So either we need a new uart1 driver or a doubled clock freq. somehow.
> Found out the same thing and communicated it to Eric - not 
> knowing about the different divider?
>
> Martin
