From: jacopo@jmondi.org (jmondi)
Date: Wed, 30 Aug 2017 18:24:40 +0200
Subject: linux-next regression caused by "gpiolib: request the gpio
 before querying its direction"
In-Reply-To: <20170830163255.4e7c1422@windsurf.lan>
References: <20170830112424.7a3a7c36@windsurf.lan>
 <3cce6903-d167-1bfc-38b4-1fdd7b3ff24b@codeaurora.org>
 <87ziah2m3f.fsf@free-electrons.com>
 <20170830161730.41919554@windsurf.lan>
 <442accaa-15a0-4efb-4e5c-cebca7140213@codeaurora.org>
 <20170830163255.4e7c1422@windsurf.lan>
Message-ID: <20170830162440.GE1863@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Aug 30, 2017 at 04:32:55PM +0200, Thomas Petazzoni wrote:
> Hello,
>
> On Wed, 30 Aug 2017 09:22:55 -0500, Timur Tabi wrote:
>
> > No, that's it.  The question is, what exactly should the 'request'
> > function do?  Should it be modifying the hardware to satisfy the
> > request?  When I wrote my patch, I assumed that it wouldn't.  I thought
> > that request simply answered the question, "can I touch this GPIO"?
>
> No, it also muxes the pin in GPIO, and you can see the "reference"
> implementation pinctrl-single also does it.
>
> Let's see what Linus W. has to say about the semantic of the "request"
> operation.
>
> But if we change the semantic of "request" to no longer mux the hardware
> as GPIO, then you will also have regressions, because there are plenty
> of GPIOs that are requested, but not explicitly muxed as GPIOs in the
> DT, precisely because today requesting a GPIO is sufficient to have it
> re-muxed as GPIO at the pinctrl level.

Just to point out one of Renesas' pin controller devices seems to
suffer from the same problem, introduced by Timur's commit

https://www.spinics.net/lists/linux-renesas-soc/msg17647.html

This is indeed caused by the "request" introduced by the above said
commit, that in rza1 pincontroller, actually muxes the requested
pin as GPIO.

Reverting that commit solves all the issues in our case too.

Thanks
   j
>
> Best regards,
>
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
