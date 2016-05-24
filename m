From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 24 May 2016 10:20:40 +0200
Subject: [RFC PATCH 1/2] Input: rotary-encoder- Add support for absolute
 encoder
In-Reply-To: <5743E206.2050602@ti.com>
References: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
 <1463648641-6931-2-git-send-email-vigneshr@ti.com>
 <20160522102606.GB23704@pengutronix.de> <5742E710.9@ti.com>
 <20160523131808.GN23704@pengutronix.de> <5743E206.2050602@ti.com>
Message-ID: <20160524082040.GR23704@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, May 24, 2016 at 10:39:26AM +0530, Vignesh R wrote:
> On 05/23/2016 06:48 PM, Uwe Kleine-K?nig wrote:
> > On Mon, May 23, 2016 at 04:48:40PM +0530, R, Vignesh wrote:
> >> On 5/22/2016 3:56 PM, Uwe Kleine-K?nig wrote:
> >>> On Thu, May 19, 2016 at 02:34:00PM +0530, Vignesh R wrote:
> >>>> +- rotary-encoder,absolute-encoder: support encoders where GPIO lines
> >>>> +  reflect the actual position of the rotary encoder dial. For example,
> >>>> +  if dial points to 9, then four GPIO lines read HLLH(1001b = 9).
> >>>> +  In this case, rotary-encoder,steps-per-period needed not be defined.
> >>>
> >>> IMHO this is wrong, I'd formalize this device as:
> >>>
> >>> 	{
> >>> 		compatible = "rotary-encoder";
> >>> 		gpios = <&gpio 19 1>, <&gpio 20 0>, <...>, <...>;
> >>> 		rotary-encoder,encoding = "binary";
> >>> 		rotary-encoder,steps = <16>;
> >>> 		rotary-encoder,steps-per-period = <16>;
> >>
> >> The above bindings essential means quarter_period device. I would not
> >> like to bother with all the logic in rotary_encoder_quarter_period_irq()
> >> when we can know encoder->pos by directly reading state of gpio lines.
> > 
> > OK, we have code that is more complex than it needs to be for your
> > device. But your device is a special case of the supported devices, so
> > I'd say don't bother that there is more logic in the driver than you
> > need and be lucky.
> 
> More complexity is just a overhead. Since, encoder can be turned at a
> rate faster than handling of IRQs (rotary_encoder_quarter_period_irq()
> is threaded IRQ hence, priority is not close to real time), some states

This problem isn't unique to your hardware. An "ordinary" encoder with
just two GPIOs and more than one period can be rotated faster than
1/irq_latency, too. There are two things that can be done:

 - undo the conversion to threaded irqs; or
 - read out the gpios in the fast handler and only delay decoding and
   reporting of the event

Both approaches have their disadvantages.

> can be missed. rotary_encoder_quarter_period_irq() is not robust in this
> case, reading gpios directly is more suitable option. I see similar
> views expressed in previously[1]
> 
> [1]http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/391196.html

IMHO the right thing to do is to improve
rotary_encoder_quarter_period_irq (and also the other handlers for full
and half period mode) to make use of additional GPIOs. This way all
types of devices benefit and more code is shared.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
