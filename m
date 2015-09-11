From: yvo@apm.com (Y Vo)
Date: Fri, 11 Sep 2015 22:06:58 +0700
Subject: [PATCH 2/2] Documentation: gpio: Update description for X-Gene
 standby GPIO controller DTS binding
In-Reply-To: <3318725.Seeb48hirI@wuerfel>
References: <1441963332-13329-1-git-send-email-yvo@apm.com>
 <14280808.2Weay6QlT1@wuerfel>
 <CAL4ahLeF8qQJciam467P2ixrxtMPTK2J9OtaVvcjtPF=9to0BQ@mail.gmail.com>
 <3318725.Seeb48hirI@wuerfel>
Message-ID: <CAL4ahLeoeT79ct-M-Bd-O08K0Dmysas3HFmTfXUFGtHKJBRzsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 9:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 11 September 2015 21:23:31 Y Vo wrote:
>> >> /* Board-specific: exclude GPIO_DS8 to leave it as GPIO */
>> >> &sbgpio {
>> >>        interrupts =    <0x0 0x29 0x1>,         /* GPIO_DS9 */
>> >>                        <0x0 0x2a 0x1>,         /* GPIO_DS10 */
>> >>                        <0x0 0x2b 0x1>,         /* GPIO_DS11 */
>> >>                        <0x0 0x2c 0x1>,         /* GPIO_DS12 */
>> >>                        <0x0 0x2d 0x1>;         /* GPIO_DS13 */
>> >> }
>> >
>> > This would be a very unusual binding, because that requires the driver
>> > to know the contents of the properties in advance and the driver
>> > cannot derive the function of an irq from the position in the array.
>> >
>> > Please come up with another approach that is more like other drivers
>> > do this and that makes it possible to reuse the driver if the
>> > interrupt numbers change.
>> The GPIO standby doesn't support interrupt controller itself, it only
>> wires the GPIO line to the external IRQ of GIC. So it is not similar
>> to other driver. Each GPIO is fixed to GIC IRQ index, and never
>> change.
>
> That is not relevant here, what matters is just that each IRQ still
> has a very specific function, which is basically what every driver
> does.
>
>> Is that possible if we change to this approach:
>> - Keep all GPIO as GPIO mode by default.
>> - If anyone want to use them as interrupt, they must add the interrupt
>> node to DT specific-board below:
>>
>> Example to configure GPIO_DS11, 12, 13 as external irq:
>>
>> &sbgpio {
>>         interrupts = <0x0 0x2b 0x1>,         /* GPIO_DS11 */
>>                         <0x0 0x2c 0x1>,         /* GPIO_DS12 */
>>                         <0x0 0x2d 0x1>;         /* GPIO_DS13 */
>
> That is exactly the same as you have in your patch. You should
> always list all interrupts that the gpio controller is wired
> to, whether they are used or not.
>
> Ideally, the driver just decides at runtime how to wire that
> mux, based on how the gpio is configured by the client driver.
> If the client asks for an interrupt (with gpio_to_irq) and is
> it is configured as an input, then you connect it to the GIC,
> otherwise you leave it to be handled by the gpio chip itself.
> Any reason you can't do that?
>
As I just explained, the GPIO Standby doesn't support the interrupt.
Both interrupts are came from GIC, so if the client asks for an
interrupt, it will go to the GIC driver (not GPIO Standby driver), so
that's my trouble. We can not implement the code to configured the
GPIO standby at GIC driver.

>         Arnd
