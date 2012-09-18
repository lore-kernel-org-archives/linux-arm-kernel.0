From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 18 Sep 2012 10:21:03 +0800
Subject: [PATCH v3] input: qt1070: Add device tree support
In-Reply-To: <5056EB60.8080100@atmel.com>
References: <1347358459-11598-1-git-send-email-voice.shen@atmel.com>
 <5056EB60.8080100@atmel.com>
Message-ID: <5057DA8F.70407@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On 9/17/2012 17:20, Nicolas Ferre wrote:
> On 09/11/2012 12:14 PM, Bo Shen :
>> Add qt1070 device tree support
>> Using device node to parse irq
>>
>> Test this on at91sam9x5ek board
>>
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>> ---
>> change since v2
>>    Using device node to parse irq,
>>    Remove gpio relative stuff
>>
>> change since v1
>>    Add gpio relative stuff, gpio_is_valid, gpio_request
>> ---
>>   .../devicetree/bindings/input/atmel-qt1070.txt     |   16 ++++++++++++++++
>>   drivers/input/keyboard/qt1070.c                    |    9 +++++++++
>>   2 files changed, 25 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/input/atmel-qt1070.txt
>>
>> diff --git a/Documentation/devicetree/bindings/input/atmel-qt1070.txt b/Documentation/devicetree/bindings/input/atmel-qt1070.txt
>> new file mode 100644
>> index 0000000..e1fc09e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/atmel-qt1070.txt
>> @@ -0,0 +1,16 @@
>> +Atmel qt1070 keyboard interface
>
> Nitpicking: there is usually a "*" at the beginning to give it a
> title-ish look ;-)
>
> Please tell that

OK, I will add it. Thanks.

>
>> +
>> +Required Properties:
>> +- compatible: Should be "atmel,qt1070"
>> +- reg: I2C slave address
>> +- interrupt-parent: Depends on SoC
>> +- interrupts: The interrupt pin number to the cpu, and trigger mode.
>> +
>> +Example:
>> +
>> +	qt1070 at 1b {
>
> I think that you need to replace by a generic name for the node name:
>
> qt1070: keyboard at 1b {
> 	compatible = "atmel,qt1070";
> 	[..]
> };
>
> I found "keyboard" to be the most appropriate in the ePAPR.

OK. I will modify it like this. Thanks.

>
>> +		compatible = "atmel,qt1070";
>> +		reg = <0x1b>;
>> +		interrupt-parent = <&pioA>;
>> +		interrupts = <7 0x0>;
>> +	};
>> diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
>> index ca68f29..60457dc 100644
>> --- a/drivers/input/keyboard/qt1070.c
>> +++ b/drivers/input/keyboard/qt1070.c
>> @@ -249,10 +249,19 @@ static const struct i2c_device_id qt1070_id[] = {
>>   };
>>   MODULE_DEVICE_TABLE(i2c, qt1070_id);
>>
>> +#ifdef CONFIG_OF
>> +static struct of_device_id atmel_qt1070_of_match[] = {
>> +	{ .compatible = "atmel,qt1070" },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, atmel_qt1070_of_match);
>> +#endif
>> +
>>   static struct i2c_driver qt1070_driver = {
>>   	.driver	= {
>>   		.name	= "qt1070",
>>   		.owner	= THIS_MODULE,
>> +		.of_match_table = of_match_ptr(atmel_qt1070_of_match),
>>   	},
>>   	.id_table	= qt1070_id,
>>   	.probe		= qt1070_probe,
>>
>
> Otherwise, looks good. So, if you agree on my comments and for next
> revision, you can add my:
>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>
> Bye,
>
