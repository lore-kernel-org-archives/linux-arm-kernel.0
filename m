From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 20 Nov 2013 14:38:57 +0100
Subject: [PATCH] pinctrl: samsung: Allow pin value to be initialized using
 pinfunc.
In-Reply-To: <528BB1F2.4080107@wwwdotorg.org>
References: <1384881351-10782-1-git-send-email-t.figa@samsung.com>
 <528BB1F2.4080107@wwwdotorg.org>
Message-ID: <1751377.1AvsyJs1NG@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Tuesday 19 of November 2013 11:46:10 Stephen Warren wrote:
> On 11/19/2013 10:15 AM, Tomasz Figa wrote:
> > This patch extends the range of settings configurable via pinfunc API
> > to cover pin value as well. This allows configuration of default values
> > of pins.
> 
> Shouldn't there be a driver that acquires the GPIO that's output to the
> pin, and configures the output value? IIRC there have been previous
> discussions re: having a list of e.g. initial GPIO output values in DT,
> and that was rejected, and this patch seems to be doing almost the exact
> same thing, just at the pinctrl level rather than GPIO level.

Well, on the contrary, I remember a discussion about specifying initial
clock tree configuration in DT (on Linaro Connect in Dublin, but AFAIR
also on the ML before. Through analogy, I would extend this to initial
pin settins. However maybe the use cases behind this will make things
clearer.

> 
> That all said, I admit this could be a useful feature...

Two specific things I had in mind with this have been:

 - pins of the SoC unused on particular boards, which often need different
   configuration depending on pin bank, SoC revision and so on. I know
   that _ideally_ this should be done by "firmware", but I believe we
   have enough historic experience to know that we shouldn't expect from
   the bootloader more than that it just loads us, as the name would
   suggest (and I have even had experience with bootloaders that couldn't
   properly do this basic task, screwing up, for example, by leaving MMU
   turned on before jumping to the kernel).

 - initializing safe default state of all pins on the board, to cope with
   configurations when not all drivers are enabled. As an example, take an
   embedded board with a little of flash storage, where the kernel has to
   be really small, so not all SoC drivers can be compiled into it. Moving
   the responsibility of setting initial pin states to drivers would leave
   pins of inexistent drivers unconfigured.

I don't think I need to explain why misconfigured pins are a bad thing.

Best regards,
Tomasz
