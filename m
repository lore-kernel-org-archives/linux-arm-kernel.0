From: sonnyrao@chromium.org (Sonny Rao)
Date: Wed, 3 Dec 2014 11:38:13 -0800
Subject: [PATCH v2 2/2] ASoC: rockchip: i2s: add support for grabbing
 output clock to codec
In-Reply-To: <20141203192024.GL7712@sirena.org.uk>
References: <1417531766-29669-1-git-send-email-jay.xu@rock-chips.com>
 <1417591118-18695-1-git-send-email-jay.xu@rock-chips.com>
 <1417591118-18695-3-git-send-email-jay.xu@rock-chips.com>
 <20141203192024.GL7712@sirena.org.uk>
Message-ID: <CAPz6YkXRmRzYpW7xuDsq69A9H-Qm2-j6t-a+B1w9+OLOPf_YnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 3, 2014 at 11:20 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Dec 03, 2014 at 03:18:38PM +0800, Jianqun Xu wrote:
>> From: Sonny Rao <sonnyrao@chromium.org>
>>
>> We need to claim the clock which is driving the codec so that when we enable
>> clock gating, we continue to clock the codec when needed.  I make this an
>> optional clock since there might be some applications where we don't need it
>> but can still use the I2S block.
>
> I would expect that the clock for the CODEC should be managed by the
> CODEC if at all possible - that seems more logical than having the CPU
> I2S controller request and manage it if it's a separate clock.  Why add
> this to the CPU side driver?

It's a good question.  Right now the way I'm running this stuff we're
mostly setting all the i2s the clock rates from the codec driver, but
I think this isn't the correct way to go, and the i2s driver needs to
set it's rate based on the hw params, but that isn't happening (yet).

This output clock has a mux and can either be a fixed 12Mhz output or
can be derived from the same fractional divider which drives the i2s
block.   I thought it was simpler to keep them all the same, but need
to put ownership in the i2s in anticipation of the i2s driver setting
it's own clock rate.

If you think this is an implementation detail and this output clock
should just be owned by the codec driver, even though I'm guessing it
will just have to be the same as i2s, then I think we can drop this
and make sure simple card (or whatever other codec driver) claims this
clock.


>
> We've not always done this for older systems due to the lack of a usable
> clock API but that's starting to be addressed.
