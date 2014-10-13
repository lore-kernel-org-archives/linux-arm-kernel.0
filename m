From: carlo@caione.org (Carlo Caione)
Date: Mon, 13 Oct 2014 12:44:54 +0200
Subject: [PATCH] ARM: meson: Fix UART compatible
In-Reply-To: <20141013101337.GB14739@leverpostej>
References: <1413141624-8949-1-git-send-email-carlo@caione.org>
 <20141013101337.GB14739@leverpostej>
Message-ID: <CAOQ7t2ZYYLVAJ8XG-PdeBZJC1YoTdAzt6bdbFxoUwDZaSF_dhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 13, 2014 at 12:13 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Sun, Oct 12, 2014 at 08:20:24PM +0100, Carlo Caione wrote:
>> Fix the compatible for the UART to make it consistent with the other
>> compatibles for Meson6 and Meson8 and to avoid problems when the
>> meson8b will be introduced with a different UART driver.
>
> I don't follow why this would cause problems -- you simply wouldn't use
> the "amlogic,meson-uart" string for a Meson8b UART because it's not
> compatible with the programming model of the other UARTs.

I know it isn't really a _real_ problem. I just want to avoid any
confusion in the future and I'm pretty sure that changing it at this
stage of development doesn't cause any trouble (I wouldn't have asked
otherwise).

>> Signed-off-by: Carlo Caione <carlo@caione.org>
>> ---
>>  arch/arm/boot/dts/meson.dtsi    | 8 ++++----
>>  drivers/tty/serial/meson_uart.c | 4 ++--
>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
>> index e6539ea..a0d34ee 100644
>> --- a/arch/arm/boot/dts/meson.dtsi
>> +++ b/arch/arm/boot/dts/meson.dtsi
>> @@ -76,7 +76,7 @@
>>               };
>>
>>               uart_AO: serial at c81004c0 {
>> -                     compatible = "amlogic,meson-uart";
>> +                     compatible = "amlogic,meson6-uart";
>>                       reg = <0xc81004c0 0x14>;
>>                       interrupts = <0 90 1>;
>>                       clocks = <&clk81>;
>> @@ -84,7 +84,7 @@
>>               };
>>
>>               uart_A: serial at c81084c0 {
>> -                     compatible = "amlogic,meson-uart";
>> +                     compatible = "amlogic,meson6-uart";
>>                       reg = <0xc81084c0 0x14>;
>>                       interrupts = <0 90 1>;
>>                       clocks = <&clk81>;
>> @@ -92,7 +92,7 @@
>>               };
>>
>>               uart_B: serial at c81084dc {
>> -                     compatible = "amlogic,meson-uart";
>> +                     compatible = "amlogic,meson6-uart";
>>                       reg = <0xc81084dc 0x14>;
>>                       interrupts = <0 90 1>;
>>                       clocks = <&clk81>;
>> @@ -100,7 +100,7 @@
>>               };
>>
>>               uart_C: serial at c8108700 {
>> -                     compatible = "amlogic,meson-uart";
>> +                     compatible = "amlogic,meson6-uart";
>>                       reg = <0xc8108700 0x14>;
>>                       interrupts = <0 90 1>;
>>                       clocks = <&clk81>;
>> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
>> index 15c7497..4c3de09 100644
>> --- a/drivers/tty/serial/meson_uart.c
>> +++ b/drivers/tty/serial/meson_uart.c
>> @@ -590,7 +590,7 @@ static int meson_uart_remove(struct platform_device *pdev)
>>
>>
>>  static const struct of_device_id meson_uart_dt_match[] = {
>> -     { .compatible = "amlogic,meson-uart" },
>> +     { .compatible = "amlogic,meson6-uart" },
>
> If this is already in a mainline release, we shouldn't be changing the
> string unless we're absolutely certain no-one is adversely affected by
> the removal. We can deprecate the old string while maintaining
> compatibility, however.

I doubt anybody else is using mainline kernel on Meson SoCs but me and
Beniamino. IMO better change it now that the development is at an
early stage.

> There doesn't seem to be a binding document. Please could you add one?

Right. Actually the documentation[1] was submitted together with the
driver but it seems that it was lost during mainlining

[1] https://patchwork.ozlabs.org/patch/388369/

-- 
Carlo Caione
