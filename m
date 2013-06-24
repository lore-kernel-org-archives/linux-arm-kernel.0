From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 24 Jun 2013 18:41:22 +0200
Subject: [PATCHv2 1/3] iio: Add Nuvoton NAU7802 ADC driver
In-Reply-To: <51C82169.1010203@free-electrons.com>
References: <1371754675-12242-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1371754675-12242-2-git-send-email-alexandre.belloni@free-electrons.com>
 <51C7EA23.1040707@metafoo.de> <51C82169.1010203@free-electrons.com>
Message-ID: <51C876B2.1050103@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2013 12:37 PM, Alexandre Belloni wrote:
> On 24/06/2013 08:41, Lars-Peter Clausen wrote:
>> On 06/20/2013 08:57 PM, Alexandre Belloni wrote:
>>> The Nuvoton NAU7802 ADC is a 24-bit 2-channels I2C ADC, with adjustable
>>> gain and sampling rates.
>>>
>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>> ---
>>>  .../bindings/iio/adc/nuvoton-nau7802.txt           |  17 +
>>>  drivers/iio/adc/Kconfig                            |   9 +
>>>  drivers/iio/adc/Makefile                           |   1 +
>>>  drivers/iio/adc/nau7802.c                          | 603 +++++++++++++++++++++
>>>  4 files changed, 630 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton-nau7802.txt
>>>  create mode 100644 drivers/iio/adc/nau7802.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton-nau7802.txt b/Documentation/devicetree/bindings/iio/adc/nuvoton-nau7802.txt
>>> new file mode 100644
>>> index 0000000..9bc4218
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton-nau7802.txt
>>> @@ -0,0 +1,17 @@
>>> +* Nuvoton NAU7802 Analog to Digital Converter (ADC)use
>>> +
>>> +Required properties:
>>> +  - compatible: Should be "nuvoton,nau7802"
>>> +  - reg: Should contain the ADC I2C address
>>> +
>>> +Optional properties:
>>> +  - nuvoton,vldo: Reference voltage in millivolts (integer)
>>> +  - interrupts: IRQ line for the ADC. If not used the driver will use
>>> +    polling.
>>> +
>>> +Example:
>>> +adc2: nau7802 at 2a {
>>> +	compatible = "nuvoton,nau7802";
>>> +	reg = <0x2a>;
>>> +	nuvoton,vldo = <3000>;
>> We usually use the regulator framework for specifying the reference voltage.
> 
> I followed what Jonathan said in his review of my first patch. Do we
> want to use the regulator framework to set the internal reference
> voltage of the ADC ? I agree that if you supply an external voltage, it
> will be necessary to use the regulator framework. Unfortunately, I can't
> test that here.
>

Ah, ok I missed that it is an internally generated voltage. It might makes
sense to add that to the properties documentation.

I guess ideally you'd also register a regulator for the internal regulator
and then use that. But I think that will unnecessarily complicate the code,
so I guess the current solution is fine.

There is one bug in probe though, if nuvoton,vldo is not set tmp will remain
uninitialized.


>>> +};
>> [...]
>>> diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
>>> new file mode 100644
>>> index 0000000..e1b6981
>>> --- /dev/null
>>> +++ b/drivers/iio/adc/nau7802.c
>>> @@ -0,0 +1,603 @@
>> [...]
>>> +static int nau7802_set_gain(struct nau7802_state *st, int gain)
>>> +{
>>> +	u8 data;
>>> +	int ret;
>>> +
>>> +	mutex_lock(&st->lock);
>>> +	st->conversion_count = 0;
>>> +
>>> +	data = i2c_smbus_read_byte_data(st->client, NAU7802_REG_CTRL1);
>>> +	if (data < 0)
>>> +		goto nau7802_sysfs_set_gain_out;
>> ret will be uninitialized if the goto above is taken
> 
> Right, bigger issue, data is u8 so it will never be negative. I'm fixing
> that !
> 
> 
>>> +	ret = i2c_smbus_write_byte_data(st->client, NAU7802_REG_CTRL1,
>>> +					(data & (~NAU7802_CTRL1_GAINS_BITS)) |
>>> +					gain);
>>> +
>>> +nau7802_sysfs_set_gain_out:
>>> +	mutex_unlock(&st->lock);
>>> +
>>> +	return ret ? ret : 0;
>>> +}
>> [...]
>>> +static int nau7802_read_irq(struct iio_dev *indio_dev,
>>> +			struct iio_chan_spec const *chan,
>>> +			int *val)
>>> +{
>>> +	struct nau7802_state *st = iio_priv(indio_dev);
>>> +	int ret;
>>> +
>>> +	INIT_COMPLETION(st->value_ok);
>>> +	enable_irq(st->client->irq);
>> Is it really necessary to enable/disable the IRQ or could you keep it
>> enabled all the time?
> 
> Fact is that the ADC doesn't really care if you are reading data or not
> so you will probably endd up in a situation were you will get 320 IRQ
> per second but not caring about the result. We have 3 ADCs on the board.
> so that amounts to 960 IRQ per second when we are only reading like once
> par second !

Ah, ok, makes sense.
