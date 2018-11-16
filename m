From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 16 Nov 2018 11:05:00 +0100
Subject: [PATCH] pwm: lpc18xx-sct: don't reconfigure PWM in .request and
 .free
In-Reply-To: <20181116065208.3920-1-u.kleine-koenig@pengutronix.de>
References: <20181114115025.GC2620@ulmo>
 <20181116065208.3920-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20181116100500.GC28631@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 07:52:08AM +0100, Uwe Kleine-K?nig wrote:
> Regarding the .request case: The consumer might be interested in taking
> over the configured state from the boot loader. So the initially
> configured state should be retained.
> 
> For the free case the PWM consumer is responsible to disable the PWM
> before calling pwm_release and there are three subcases to consider:
> 
>  a) The pwm is already off. Then there is no gain in disabling the PWM
>     once more.
>  b) The pwm is still running and there is a good reason for that. (Not
>     sure this is a valid case, I cannot imagine such a good reason.)
>     Then it is contra productive to disable the pwm.
>  c) The pwm is still running because the consumer failed to disable the
>     PWM. Then the consumer needs fixing and there is little incentive to
>     paper over the problem in the backend driver.
> 
> This aligns the lpc18xx-sct driver to the other PWM drivers that also
> don't reconfigure the hardware in .request and .free.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-lpc18xx-sct.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied, with some minor fixes to the commit message (pwm -> PWM,
pwm_release -> pwm_put(), ...).

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181116/3730d634/attachment.sig>
