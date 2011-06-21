From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 21 Jun 2011 16:56:23 +0530
Subject: [PATCH 2/6] serial: samsung: Add device tree support for s5pv210
	uart driver
In-Reply-To: <BANLkTi=+FKz-uPtSv572y5ORorMeGR8Anw@mail.gmail.com>
References: <1308567752-13451-1-git-send-email-thomas.abraham@linaro.org>
	<1308567752-13451-3-git-send-email-thomas.abraham@linaro.org>
	<BANLkTi=+FKz-uPtSv572y5ORorMeGR8Anw@mail.gmail.com>
Message-ID: <BANLkTikNXfCXF1ZH=wTeeuSz2DC7BE_5Cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On 20 June 2011 22:13, Grant Likely <grant.likely@secretlab.ca> wrote:
>
> For custom properties, you should prefix the property name with 'samsung,'.
>
> This looks very much like directly encoding the Linux flags into the
> device tree. ?The binding should be completely contained within
> itself, and not refer to OS implementation details. ?It is fine to use
> the same values that Linux happens to use, but they need to still be
> explicitly documented as to what they mean. ?Also, a 'flags' property
> usually isn't very friendly to mere-mortals when the explicit
> behaviour can be enabled with the presence of a named property. ?For
> example; something like a "samsung,uart-has-rtscts" to enable rts/cts.

I will ensure that the next version of the patch do not have any linux
specific bindings.

>
>> +
>> +- has_fracval : Set to 1, if the controller supports fractional part of
>> + ? ? ? for the baud divisor, otherwise, set to 0.
>
> Boolean stuff often doesn't need a value. ?If the property is present,
> it is a '1'. ?If it isn't, then it is a '0'.
>
>> +
>> +- ucon_default : Default board specific setting of UCON register.
>> +
>> +- ulcon_default : Default board specific setting of ULCON register.
>> +
>> +- ufcon_default : Default board specific setting of UFCON register.
>
> I think I've commented on this before, but I do try to avoid direct
> coding registers into the DT. ?That said, sometimes there really isn't
> a nice human-friendly way of encoding things and direct register
> values is the best approach.

Instead of default register values, is it acceptable to include custom
properties like "samsung,txfifo-trig-level" and then convert it to
corresponding register settings?

>
>> +
>> +- uart_clksrc : One or more child nodes representing the clock sources that
>> + ? ? ? could be used to derive the buad rate. Each of these child nodes
>> + ? ? ? has four required properties.
>> +
>> + ? ? ? - name : Name of the parent clock.
>> + ? ? ? - divisor : divisor from the clock to the uart controller.
>> + ? ? ? - min_baud : Minimum baud rate for which this clock can be used.
>> + ? ? ? ? ? ? ? ? ? ? ? Set to zero, if there is no limitation.
>> + ? ? ? - max_buad : Maximum baud rate for which this clock can be used.
>
> typo: s/buad/baud/
>
>> + ? ? ? ? ? ? ? ? ? ? ? Set to zero, if there is no limitation.
>
> This looks to be directly encoding the current Linux implementation
> details into the device tree (it is a direct copy of the config
> structure members), and it doesn't use the common clock binding. ?It's
> fine to use sub nodes for each clock attachment, particularly because
> it looks like the uart is able to apply it's own divisor to the clock
> input, but I would definitely encode the data using the existing
> struct clock binding.
>
>> +
>> +Optional properties:
>> +- fifosize: Size of the tx/rx fifo used in the controller. If not specified,
>> + ? ? ? the default value of the fifosize is 16.
>> diff --git a/drivers/tty/serial/s5pv210.c b/drivers/tty/serial/s5pv210.c
>> index 3b2021a..9aacbda 100644
>> --- a/drivers/tty/serial/s5pv210.c
>> +++ b/drivers/tty/serial/s5pv210.c
>> @@ -18,6 +18,7 @@
>> ?#include <linux/init.h>
>> ?#include <linux/serial_core.h>
>> ?#include <linux/serial.h>
>> +#include <linux/of.h>
>>
>> ?#include <asm/irq.h>
>> ?#include <mach/hardware.h>
>> @@ -131,15 +132,39 @@ static struct s3c24xx_uart_info *s5p_uart_inf[] = {
>> ?/* device management */
>> ?static int s5p_serial_probe(struct platform_device *pdev)
>> ?{
>> - ? ? ? return s3c24xx_serial_probe(pdev, s5p_uart_inf[pdev->id]);
>> + ? ? ? const void *prop;
>> + ? ? ? unsigned int port = pdev->id;
>> + ? ? ? unsigned int fifosize = 16;
>> + ? ? ? static unsigned int probe_index;
>> +
>> + ? ? ? if (pdev->dev.of_node) {
>> + ? ? ? ? ? ? ? prop = of_get_property(pdev->dev.of_node, "fifosize", NULL);
>> + ? ? ? ? ? ? ? if (prop)
>> + ? ? ? ? ? ? ? ? ? ? ? fifosize = be32_to_cpu(*(u32 *)prop);
>
> Okay, this is getting ugly (not your fault, but this pattern has
> become too common. ?Can you craft and post a patch that adds the
> following functions to drivers/of/base.c and include/linux/of.h
>
> /* offset in cells, not bytes */
> int dt_decode_u32(struct *property, int offset, u32 *out_val)
> {
> ? ? ? ?if (!property || !property->value)
> ? ? ? ? ? ? ? ?return -EINVAL;
> ? ? ? ?if ((offset + 1) * 4 > property->length)
> ? ? ? ? ? ? ? ?return -EINVAL;
> ? ? ? ?*out_val = of_read_number(property->value + (offset * 4), 1);
> ? ? ? ?return 0;
> }
> int dt_decode_u64(struct *property, int offset, u64 *out_val)
> {
> ...
> }
> int dt_decode_string(struct *property, int index, char **out_string);
> {
> ...
> }
>
> Plus a set of companion functions:
> int dt_getprop_u32(struct device_node *np, char *propname, int offset,
> u32 *out_val)
> {
> ? ? ? ?return dt_decode_u32(of_find_property(np, propname, NULL),
> offset, out_val);
> }
> int dt_getprop_u64(struct *device_node, char *propname, int offset,
> u64 *out_val);
> {
> ...
> }
> int dt_getprop_string(struct *device_node, char *propname, int index,
> char **out_string);
> {
> ...
> }
>
> Then you'll be able to simply do the following to decode each
> property, with fifosize being left alone if the property cannot be
> found or decoded:
>
> dt_getprop_u32(pdev->dev.of_node, "samsung,fifosize", &fifosize);

Sure. I will write the above listed functions and submit a patch.

Thanks,
Thomas.
