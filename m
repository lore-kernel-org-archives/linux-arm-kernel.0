From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 10 Feb 2014 11:40:34 +0100
Subject: [PATCH] backlight: add PWM dependencies
In-Reply-To: <1391518634-6472-1-git-send-email-linus.walleij@linaro.org>
References: <1391518634-6472-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140210104032.GB20143@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 01:57:14PM +0100, Linus Walleij wrote:
> In some compilations the LM3630A and LP855X backlight drivers
> fail like this:
> 
> drivers/built-in.o: In function `lm3630a_pwm_ctrl':
> drivers/video/backlight/lm3630a_bl.c:168: undefined reference to `pwm_config'
> drivers/video/backlight/lm3630a_bl.c:172: undefined reference to `pwm_disable'
> drivers/video/backlight/lm3630a_bl.c:170: undefined reference to `pwm_enable'
> drivers/built-in.o: In function `lp855x_pwm_ctrl':
> drivers/video/backlight/lp855x_bl.c:249: undefined reference to `pwm_config'
> drivers/video/backlight/lp855x_bl.c:253: undefined reference to `pwm_disable'
> drivers/video/backlight/lp855x_bl.c:251: undefined reference to `pwm_enable'
> 
> This is because both drivers depend on the PWM framework, so
> add this dependency to their Kconfig entries.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/video/backlight/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)

Hi Linus,

it seems like at least BACKLIGHT_LP8788 is missing a corresponding
dependency as well.

I have applied Sascha's patch to remove the obsolete HAVE_PWM symbol,
and this will fix at least the build issues. However it will also cause
the driver to fail at runtime because the pwm_*() functions won't work.

So I wonder if we should still apply this patch to make it clear that
PWM support is necessary to make the driver work. I guess the point is
somewhat moot because even if we had PWM enabled it could still happen
that no PWM driver is enabled to provide a PWM device... I guess it's
equally justifiable to leave that up to the defconfig.

Should we just drop this patch? Cc'ing Arnd who's commented on Jingoo's
alternate proposal.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140210/1b95b04c/attachment.sig>
