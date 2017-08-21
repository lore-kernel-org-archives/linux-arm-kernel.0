From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Aug 2017 10:25:27 +0200
Subject: [PATCH 0/2] extend PWM framework to support PWM dead-times
In-Reply-To: <1494332153-14534-1-git-send-email-claudiu.beznea@microchip.com>
References: <1494332153-14534-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <20170821082527.GQ18996@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 09, 2017 at 03:15:51PM +0300, Claudiu Beznea wrote:
> Hi all,
> 
> Please give feedback on these patches which extends the PWM
> framework in order to support multiple PWM signal types.
> Since I didn't receive any inputs on RFC series I'm resending it as
> normal patch series.
> 
> The current patch series add the following PWM signal types:
> - PWM complementary signals
> - PWM push-pull signal
> 
> Definition of PWM complementary mode:
> For a PWM controllers with more than one outputs per PWM channel,
> e.g. with 2 outputs per PWM channels, the PWM complementary signals
> have opposite levels, same duration and same starting times,
> as in the following diagram:
> 
>         __    __    __    __
> PWMH __|  |__|  |__|  |__|  |__
>      __    __    __    __    __
> PWML   |__|  |__|  |__|  |__|
>        <--T-->
> Where T is the signal period.
> 
> Definition of PWM push-pull mode:
> For PWM controllers with more than one outputs per PWM channel,
> e.g. with 2 outputs per PWM channel, the PWM push-pull signals
> have same levels, same duration and are delayed until the begining
> of the next period, as in the following diagram:
> 
>         __          __
> PWMH __|  |________|  |________
>               __          __
> PWML ________|  |________|  |__
>        <--T-->
> 
> Where T is the signal period.
> 
> These output signals could be configured by setting PWM mode
> (a new input in sysfs has been added in order to support this
> operation).
> 
> root at sama5d2-xplained:/sys/devices/platform/ahb/ahb:apb/f802c000.pwm/pwm/pwmchip0/pwm2# ls -l
> -r--r--r--    1 root     root          4096 Feb  9 10:54 capture
> -rw-r--r--    1 root     root          4096 Feb  9 10:54 duty_cycle
> -rw-r--r--    1 root     root          4096 Feb  9 10:54 enable
> -rw-r--r--    1 root     root          4096 Feb  9 10:54 mode
> -rw-r--r--    1 root     root          4096 Feb  9 10:54 period
> -rw-r--r--    1 root     root          4096 Feb  9 10:55 polarity
> drwxr-xr-x    2 root     root             0 Feb  9 10:54 power
> -rw-r--r--    1 root     root          4096 Feb  9 10:54 uevent
> 
> The PWM push-pull mode could be usefull in applications like
> half bridge converters.

Sorry for taking an absurdly long time to get back to you on this.

One problem I see with this is that the PWM framework is built on the
assumption that we have a single output per PWM channel. This becomes
important when you start adding features such as this because now the
users have no way of determining whether or not the PWM they retrieve
will actually be able to do what they want.

For example, let's say you have a half bridge converter driver in the
kernel and it does a pwm_get() to obtain a PWM to use. There's nothing
preventing it from using a simple one-output PWM and there's no way to
check that we're actually doing something wrong.

I think any in-kernel API would have to be more fully-featured,
otherwise we're bound to run into problems. At the very least I think
we'd have to expose some sort of capabilities list.

A possibly simpler approach might be to restrict this to the driver that
you need this for. It looks like you will be mainly using this via sysfs
and in that case you might be able to just extend what information is
exposed in sysfs for the particular PWM you're dealing with.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/7b2791ef/attachment.sig>
