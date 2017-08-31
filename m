From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 31 Aug 2017 09:18:12 +0200
Subject: linux-next regression caused by "gpiolib: request the gpio
 before querying its direction"
In-Reply-To: <CACRpkdbxdkHukALfYMrM7w=1KNJKLBhGebbkEpMb3C3+nCfWOA@mail.gmail.com>
References: <20170830112424.7a3a7c36@windsurf.lan>
 <3cce6903-d167-1bfc-38b4-1fdd7b3ff24b@codeaurora.org>
 <87ziah2m3f.fsf@free-electrons.com>
 <20170830161730.41919554@windsurf.lan>
 <CACRpkdbxdkHukALfYMrM7w=1KNJKLBhGebbkEpMb3C3+nCfWOA@mail.gmail.com>
Message-ID: <20170831091812.6f7d417e@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 31 Aug 2017 09:08:45 +0200, Linus Walleij wrote:

> > However, even the "reference" pinctrl-single.c implementation does it,
> > in pcs_request_gpio().  
> 
> Yeah so we have unclear semantics on this and that is just a fact of
> life. It's a bit of pain as maintainer because I sometimes don't know
> what to do when something makes superficial sense and the only thing
> I can do is to toss it into linux-next and see what happens.
> 
> Look what happened :D
> 
> If the semantics should be changed, all drivers must be changed consistently
> in a larger patch series, so until then, we revert this and leave it as it is.
> 
> Now this is reverted anyways.

Thanks for taking action on this. Regarding the semantics, the
kerneldoc comment says:

 * @gpio_request_enable: requests and enables GPIO on a certain pin.
 *      Implement this only if you can mux every pin individually as GPIO. The
 *      affected GPIO range is passed along with an offset(pin number) into that
 *      specific GPIO range - function selectors and pin groups are orthogonal
 *      to this, the core will however make sure the pins do not collide.
 * @gpio_disable_free: free up GPIO muxing on a certain pin, the reverse of
 *      @gpio_request_enable

So the ->gpio_request_enable() comment is not super clear, but the
->gpio_disable_free() explicitly says "free up GPIO muxing", which
would mean the ->gpio_request_enable() hook has muxed the pin as GPIO.
Things could be clearer, but I believe it's quite clear the intent is
that the ->gpio_request_enable() should mux the pin as a GPIO at the HW
level.

Note that on my side, I've however not been convinced by this semantic:
I find it weird that when you request a GPIO, it gets automatically
muxed as such, without an explicit pinctrl configuration in the DT.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
