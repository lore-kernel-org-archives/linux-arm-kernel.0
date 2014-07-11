From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 11 Jul 2014 18:17:14 +0800
Subject: [BUG] usb: gadget: rndis: atmel_usba_udc: probe of 500000.gadget
 failed with error -2
In-Reply-To: <53BFAEE4.3060009@aksignal.cz>
References: <53BF8890.9020409@aksignal.cz> <53BF998B.2070006@atmel.com>
 <53BFAEE4.3060009@aksignal.cz>
Message-ID: <53BFB9AA.5080404@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jiri,

On 07/11/2014 05:31 PM, Ji?? Prchal wrote:
>
>
> Dne 11.7.2014 10:00, Bo Shen napsal(a):
>> Hi Jiri Prchal,
>>
>> On 07/11/2014 02:47 PM, Ji?? Prchal wrote:
>>> Hi,
>>> I discovered bug when I try to use RNDIS gadget driver on SAM9G25 with
>>> version 3.16.0-rc4. In version 3.14.0-rc4 it was OK.
>>> If I plug pc to device port on my board I expect to establish ethernet
>>> connection, instead of this it looks like it behave like host port. If I
>>> look at all messages I found some problem during boot:
>>> [    1.585937] atmel_usba_udc: probe of 500000.gadget failed with
>>> error -2
>>
>> I tested OK with Linux kernel v3.16-rc4 (latest commit is:
>> 4f440cd534359f689cb577c68f8491d1eddf0b76) on sam9g25.
>>
>> Best Regards,
>> Bo Shen
>>
> I just cloned git
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git and
> still same problem. There is some other commit.
> Couldn't be the problem in at91sam9x5.dtsi not defines clocks?
> In ohci they are:
>          usb0: ohci at 00600000 {
>              compatible = "atmel,at91rm9200-ohci", "usb-ohci";
>              reg = <0x00600000 0x100000>;
>              interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
>              clocks = <&usb>, <&uhphs_clk>, <&udphs_clk>,
>                   <&uhpck>;
>              clock-names = "usb_clk", "ohci_clk", "hclk", "uhpck";
>              status = "disabled";
>          };
> But in gadget not:
>              usb2: gadget at f803c000 {
>                  #address-cells = <1>;
>                  #size-cells = <0>;
>                  compatible = "atmel,at91sam9rl-udc";
>                  reg = <0x00500000 0x80000
>                         0xf803c000 0x400>;
>                  interrupts = <23 IRQ_TYPE_LEVEL_HIGH 0>;
>                  status = "disabled";

Thanks for reporting it. Using at91_dt_defconfig won't reproduce this 
issue. However, only enable at91sam9x5 and CCF will reproduce this issue.

I will send out the patch to fix it.

Thanks again.

> Best Regards,
> Jiri

Best Regards,
Bo Shen
