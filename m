From: daniel@zonque.org (Daniel Mack)
Date: Tue, 2 Feb 2016 14:14:49 +0100
Subject: [PATCH v2 0/3] Input: rotary-encoder - use more than two gpios
In-Reply-To: <20160202125602.GW13664@pengutronix.de>
References: <1454408678-6011-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <56B09C27.8070009@zonque.org> <20160202125602.GW13664@pengutronix.de>
Message-ID: <56B0ABC9.10107@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/2016 01:56 PM, Uwe Kleine-K?nig wrote:
> Hello Daniel,
> 
> On Tue, Feb 02, 2016 at 01:08:07PM +0100, Daniel Mack wrote:
>> On 02/02/2016 11:24 AM, Uwe Kleine-K?nig wrote:
>>> Some time ago I sent a v1 of this, now after testing the changes more
>>> deeply patch 3 changed a bit. The old series started with
>>>
>>> 	Date: Wed,  2 Dec 2015 11:07:11 +0100
>>> 	From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>>> 	Subject: [PATCH RFC 0/3] input: rotary_encoder: use more than two gpios as input
>>> 	Message-Id: <1449050834-31779-1-git-send-email-u.kleine-koenig@pengutronix.de>
>>>
>>> The two first patches are just preparation for the third patch.
>>>
>>> There is an obvious improvement that allows detection of quick changes
>>> more reliably with >2 gpios, but I didn't implement this yet. (With 4
>>> GPIOs you can distinguish a counter clockwise movement of three states
>>> from a clock wise movement of a single state. Still the patch is useful
>>> as it makes these devices work at all.
>>>
>>> My test device looks as follows:
>>>
>>>         rotary at 0 {
>>>                 compatible = "rotary-encoder";
>>>                 gpios = <&gpio4 12 GPIO_ACTIVE_HIGH>, <&gpio4 11 GPIO_ACTIVE_HIGH>, <&gpio4 10 GPIO_ACTIVE_HIGH>, <&gpio4 9 GPIO_ACTIVE_HIGH>;
>>>
>>>                 rotary-encoder,steps = <16>;
>>> 		rotary-encoder,steps-per-period = <16>;
>>>         };
>>>
>>> While Daniel Mack and Rojhalat Ibrahim agreed that this device is an
>>> absolute encoder and should be supported by a simpler logic, I still
>>> consider it worthwhile to get these patches in as a first step. Also the
>>> binding looks right, so IMHO the comments shouldn't stop this series
>>> from going in.
>>
>> I still don't understand why this is implemented that way, rather than
>> going for a much simpler logic of interpretation that also allows users
>> to read out the absolute position.
>>
>> The code to read the value would be really just as simple as reading all
>> GPIOs and or-ing their values into the result, and skip the state
>> machine completely. This code would be active if a new attribute
>> (something like 'rotary-encoder,hardware-absolute') is set, or even
>> implicitly, when more than 2 GPIOs are specified.
>>
>> Is there any reason for not doing that?
> 
> Currently the reason is lack of time. And when implementing
> rotary-encoder,hardware-absolute something similar would be the result
> for the relative reporting anyhow. So the problem is only that I don't
> have absolute support yet, but the patches as is would be the base for
> that anyhow.

Because you would support relative support for such 4-pin encoders as
well? I would have thought that absolute encoders would report absolute
values only, but I guess you have a point here. Just to make sure we're
on the same page: For more than 2 GPIOs, and an absent
"rotary-encoder,relative-axis", the driver would switch to a mode in
which it bypasses the state machine, right?

If you're planning to implement that eventually, I'm fine with the
patches for now :)

Dmitry, if you are apply them, feel free to add my

  Acked-by: Daniel Mack <daniel@zonque.org>

to all 3 of them.


Thanks,
Daniel
