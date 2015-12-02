From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 2 Dec 2015 19:59:20 +0100
Subject: [PATCH RFC 0/3] input: rotary_encoder: use more than two gpios
 as input
In-Reply-To: <2266988.l83Fg404My@pcimr>
References: <1449050834-31779-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <2266988.l83Fg404My@pcimr>
Message-ID: <20151202185920.GO5072@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Dec 02, 2015 at 01:52:58PM +0100, Rojhalat Ibrahim wrote:
> On Wednesday 02 December 2015 11:07:11 Uwe Kleine-K?nig wrote:
> > some time ago I worked on the rotary encoder driver to make it support
> > more than two input lines. This is the (only slightly tested[1]) rebase of
> > this series on top of 4.4-rc2 (from 4.1).
> > 
> > It would be great to get some feedback, especially (but not only) for my
> > change to raumfeld.c.
> > 
> > Before Ezequiel's patch 3a341a4c30d4 ("Input: rotary-encoder - add
> > support for quarter-period mode") we had a dt property
> > "rotary-encoder,half-period" defined. It's presence meant that we had 2
> > indents per period; it's absence that there is only 1. Ezequiel
> > introduced rotary-encoder,steps-per-period instead when adding support
> > for quarter-period mode (which has 4 indents per period).
> > 
> > Up to now (i.e. with two inputs) a period has length 4. Now with (say)
> > four inputs a period has length 16 instead. Now how should this be
> > modeled in dt? This series implements that I have to pass
> > 
> > 	rotary-encoder,steps-per-period = <16>;
> > 
> > now for "quarter-period mode" (i.e. 4 indents per 4 state changes[2]),
> > but that feels unnatural. I'd prefer to set a property to <1> instead,
> > meaning the device has an indent for each state change[2]. half-period
> > mode would be <2> and full-period mode would be <4>. But I don't have a
> > nice name for such a property and maybe it's easier to live with
> > steps-per-period = <16>? What do you think?
> > 
> > Also note that these patches are not as technically versatile as
> > possible. With 4 (n) input lines we could detect a quick rotation where the
> > machine's latency only allows to sample after 7 (2^(n-1)-1) state
> > changes. Currently this is not implemented, but can be done later.
> > 
> > Best regards
> > Uwe
> > 
> 
> AFAIUI the rotary encoder driver only handles incremental encoders not
> absolute encoders. (So in fact the assumed rotary encoder could also be a

There is a device tree property "rotary-encoder,relative-axis" which
switches between absolute and relative reporting. This is maybe badly
named, but IIUC is there to differenciate between incremental and
absolute encoders.

> linear encoder with an incremental interface.) Those encoders almost always
> have an interface with two outputs (A, B) with a phase shift of 90 degrees
> between them. So in this case we have 4 steps per period. Sometimes there
> is only one line for 1 or 2 steps per period. But I have never seen or

I don't see how using only a single gpio would work for a rotary
encoder. I suspect we use different vocabulary to describe our devices
and so don't understand each other?! At least you cannot detect the
direction of the movement with a single input line, do you?

> heard of a device with more than 2 lines (except for the third output which
> serves as a reference position index marker).
> 
> Do devices wirh more than two outputs actually exist?
> Or is the purpose of supporting more than 2 lines something other than
> connecting an actual encoder to them?

I have a real rotary encoder with 4 input lines and so 16
distinguishable positions. It would be described as:

	compatible = "rotary-encoder";
	gpios = <&gpio4 12 GPIO_ACTIVE_HIGH>, <&gpio4 11 GPIO_ACTIVE_HIGH>, <&gpio4 10 GPIO_ACTIVE_HIGH>, <&gpio4 9 GPIO_ACTIVE_HIGH>;
	rotary-encoder,steps = <16>;
	rotary-encoder,steps-per-period = <16>;

with the binding implemented in my patches.

The wikipedia article about rotary encoders[1] uses a device with 3
input lines to explain gray encoding. So I didn't consider "my" device
as exotic up to now.

Best regards
Uwe

[1] https://en.wikipedia.org/wiki/Rotary_encoder

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
