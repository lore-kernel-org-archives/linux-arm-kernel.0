From: vigneshr@ti.com (R, Vignesh)
Date: Mon, 23 May 2016 16:48:40 +0530
Subject: [RFC PATCH 1/2] Input: rotary-encoder- Add support for absolute
 encoder
In-Reply-To: <20160522102606.GB23704@pengutronix.de>
References: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
 <1463648641-6931-2-git-send-email-vigneshr@ti.com>
 <20160522102606.GB23704@pengutronix.de>
Message-ID: <5742E710.9@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/22/2016 3:56 PM, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Thu, May 19, 2016 at 02:34:00PM +0530, Vignesh R wrote:
>> There are rotary-encoders where GPIO lines reflect the actual position
>> of the rotary encoder dial. For example, if dial points to 9, then four
>> GPIO lines connected to the rotary encoder will read HLLH(1001b = 9).
>> Add support for such rotary-encoder.
>> The driver relies on rotary-encoder,absolute-encoder DT property to
>> detect such encoders.
>> Since, GPIO IRQs are not necessary to work with
>> such encoders, optional polling mode support is added using
> 
> I don't understand this. It's necessary in the same way as with the
> already supported devices. I.e. you want to trigger an irq when the
> encoder is moved and then check for it's position in the handler.
> 

Unlike already supported device, there is no need to count steps or
determine the direction of rotation. Hence, IRQ is not a requirement,
periodically polling the gpio lines is more than sufficient. With
absolute encoder, you are able to determine the current position at any
time just by looking at the gpio inputs.
Suppose we poll device at t=0ms and see gpio values are LLLH(1), if we
again poll device at t=500ms(which is what input_poll_dev helps to do)
and see that gpio values is LLHH(3), then we know that rotary encoder
has changed to 3. This can be done w/o IRQ for absolute encoders.

>> diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
>> index 6c9f0c8a846c..9c928dbd1500 100644
>> --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
>> +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
>> @@ -12,6 +12,10 @@ Optional properties:
>>  - rotary-encoder,relative-axis: register a relative axis rather than an
>>    absolute one. Relative axis will only generate +1/-1 events on the input
>>    device, hence no steps need to be passed.
>> +- rotary-encoder,absolute-encoder: support encoders where GPIO lines
>> +  reflect the actual position of the rotary encoder dial. For example,
>> +  if dial points to 9, then four GPIO lines read HLLH(1001b = 9).
>> +  In this case, rotary-encoder,steps-per-period needed not be defined.
> 
> IMHO this is wrong, I'd formalize this device as:
> 
> 	{
> 		compatible = "rotary-encoder";
> 		gpios = <&gpio 19 1>, <&gpio 20 0>, <...>, <...>;
> 		rotary-encoder,encoding = "binary";
> 		rotary-encoder,steps = <16>;
> 		rotary-encoder,steps-per-period = <16>;

The above bindings essential means quarter_period device. I would not
like to bother with all the logic in rotary_encoder_quarter_period_irq()
when we can know encoder->pos by directly reading state of gpio lines.

> 		rotary-encoder,rollover;
> 	}
> 
> and support this with a v4 of
> 
> 	http://thread.gmane.org/gmane.linux.kernel.input/48892
> 
>

IMHO, there needs to be separate IRQ handler for absolute encoders so
that the driver logic is greatly simplified.
