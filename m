From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 24 May 2013 21:24:26 +0900
Subject: [PATCH v4 15/21] ARM: shmobile: armadillo-reference: Move st1232
 reset GPIO to DT
In-Reply-To: <CACRpkdYUQjtmzFzQBES-bcjjT5iTTXifa2BQSusBzMdTCRtyiA@mail.gmail.com>
References: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1369138482-5871-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CACRpkdYUQjtmzFzQBES-bcjjT5iTTXifa2BQSusBzMdTCRtyiA@mail.gmail.com>
Message-ID: <CANqRtoTVjBcsKVP=2jJ7ThC0gXuF-Xd-iByo7db53YhK1x+-wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Fri, May 24, 2013 at 5:59 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, May 21, 2013 at 2:14 PM, Laurent Pinchart
> <laurent.pinchart+renesas@ideasonboard.com> wrote:
>
>> Reference the st1232 reset GPIO from the device tree and remove it from
>> board code.
>>
>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
>> +++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
>> @@ -43,6 +43,7 @@
>>                 interrupts = <2 0>; /* IRQ10: hwirq 2 on irqpin1 */
>>                 pinctrl-0 = <&st1232_pins>;
>>                 pinctrl-names = "default";
>> +               gpios = <&pfc 166 1>;
>
> Just as a random example this becomes:
>
> gpios = <&pfc 166 GPIO_ACTIVE_LOW>;
>
> Which is WAAAY more readable.

Yes, agreed, even grumpy me starts thinking this looks good. =)

>> +++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
>> @@ -158,7 +158,6 @@ clock_error:
>>   */
>>  static void __init eva_init(void)
>>  {
>> -
>>         r8a7740_clock_init(MD_CK0 | MD_CK2);
>>         eva_clock_init();
>>
>> @@ -171,12 +170,6 @@ static void __init eva_init(void)
>>
>>         r8a7740_add_standard_devices_dt();
>>
>> -       /*
>> -        * Touchscreen
>> -        * TODO: Move reset GPIO over to .dts when we can reference it
>> -        */
>> -       gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
>> -
>
> Not really my business but I guess the driver is already augmented to pick its
> GPIO from the device tree in this case? And are you willingly breaking
> non-DT boots or something?

Regarding dependency handing of driver and board code, I believe
Laurent has us covered.

As for breaking non-DT boot, under mach-shmobile the code for DT
"-reference" board support is DT only so judging by the file name this
kind of change should be fine.

Thanks,

/ magnus
