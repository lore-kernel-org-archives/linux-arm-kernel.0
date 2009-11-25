From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 13:28:57 +0100
Subject: [PATCH 12/17] ARM: pxa/raumfeld: add audio related functions
In-Reply-To: <20091125114106.GA3175@sirena.org.uk>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
	<1259145751-3331-13-git-send-email-daniel@caiaq.de>
	<20091125114106.GA3175@sirena.org.uk>
Message-ID: <20091125122857.GJ29442@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 11:41:07AM +0000, Mark Brown wrote:
> On Wed, Nov 25, 2009 at 11:42:26AM +0100, Daniel Mack wrote:
> 
> > +	if (en) {
> > +		gpio_set_value(mfp_to_gpio(GPIO_AUDIO_VA_ENABLE), 1);
> 
> This looks like you want to add regulator support to the CODEC.

Well, that's not really a regulator but just a GPIO that drives a FET.
Doesn't using the regulator framework seem a little overdone?

> > +		gpio_set_value(mfp_to_gpio(GPIO_MCLK_RESET), 1);
> > +
> > +		/* wait some time to let VA and the clocks become stable */
> > +		schedule_timeout(HZ/10);
> > +
> > +		gpio_set_value(mfp_to_gpio(GPIO_SPDIF_RESET), 1);
> > +		gpio_set_value(mfp_to_gpio(GPIO_CODEC_RESET), 1);
> 
> The relevant drivers really need to know about this...  if you are going
> to stick with this approach I'd push all this stuff into the audio
> driver, splitting it into this separate file isn't really buying
> anything since it's all machine specific and nothing except the audio
> driver needs to know what's going on.

The idea was to only let the board support file know about GPIO
definitions, so the audio part doesn't need to know about the details.
But I can move that if you like. However, I don't see much benefit - I
would merely just move the whole function over.

Daniel
