From: vigneshr@ti.com (Vignesh R)
Date: Wed, 25 May 2016 14:14:12 +0530
Subject: [RFC PATCH 1/2] Input: rotary-encoder- Add support for absolute
 encoder
In-Reply-To: <20160524082040.GR23704@pengutronix.de>
References: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
 <1463648641-6931-2-git-send-email-vigneshr@ti.com>
 <20160522102606.GB23704@pengutronix.de> <5742E710.9@ti.com>
 <20160523131808.GN23704@pengutronix.de> <5743E206.2050602@ti.com>
 <20160524082040.GR23704@pengutronix.de>
Message-ID: <574565DC.4010502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/24/2016 01:50 PM, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Tue, May 24, 2016 at 10:39:26AM +0530, Vignesh R wrote:
>> On 05/23/2016 06:48 PM, Uwe Kleine-K?nig wrote:
>>> On Mon, May 23, 2016 at 04:48:40PM +0530, R, Vignesh wrote:
>>>> On 5/22/2016 3:56 PM, Uwe Kleine-K?nig wrote:
>>>>> On Thu, May 19, 2016 at 02:34:00PM +0530, Vignesh R wrote:
[...]
>>>
>>> OK, we have code that is more complex than it needs to be for your
>>> device. But your device is a special case of the supported devices, so
>>> I'd say don't bother that there is more logic in the driver than you
>>> need and be lucky.
>>
>> More complexity is just a overhead. Since, encoder can be turned at a
>> rate faster than handling of IRQs (rotary_encoder_quarter_period_irq()
>> is threaded IRQ hence, priority is not close to real time), some states
> 
> This problem isn't unique to your hardware. An "ordinary" encoder with
> just two GPIOs and more than one period can be rotated faster than
> 1/irq_latency, too.

But my hardware should not be affected by this problem. The whole point
of absolute encoder is to overcome the difficulty of software keeping
track of steps, one can read the gpios state anytime and find out what
value is the encoder pointing to.

> There are two things that can be done:
> 
>  - undo the conversion to threaded irqs; or
>  - read out the gpios in the fast handler and only delay decoding and
>    reporting of the event
> 
> Both approaches have their disadvantages.
> 

And both cannot guarantee that an event is not missed (on a loaded
system) and all of the state logic goes for a toss. For binary encoding
multiple IRQs(thats why incremental encoders are usually gray coded)
will fire at same time and handling all of the them is a considerable
overhead, there is good chance that some events are missed.

>> can be missed. rotary_encoder_quarter_period_irq() is not robust in this
>> case, reading gpios directly is more suitable option. I see similar
>> views expressed in previously[1]
>>
>> [1]http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/391196.html
> 
> IMHO the right thing to do is to improve
> rotary_encoder_quarter_period_irq (and also the other handlers for full
> and half period mode) to make use of additional GPIOs. 

I doubt there exists any incremental encoder with more than 2
gpios(except for the extra reference GPIO or Z signal). So modifying
full/half period handlers maybe unnecessary.

> This way all types of devices benefit and more code is shared.

Sorry.. but IMHO, there is little code sharing and more complexity. So,
I will leave it to the maintainer to decide whats the best approach here.

-- 
Regards
Vignesh
