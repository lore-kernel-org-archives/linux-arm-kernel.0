From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 1 Dec 2015 20:40:39 -0700
Subject: [PATCH RFC 1/4] ARM: bcm2835: remove sdhci pins from GPIO pinctrl
In-Reply-To: <1447949176-21926-2-git-send-email-stefan.wahren@i2se.com>
References: <1447949176-21926-1-git-send-email-stefan.wahren@i2se.com>
 <1447949176-21926-2-git-send-email-stefan.wahren@i2se.com>
Message-ID: <565E6837.1070909@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2015 09:06 AM, Stefan Wahren wrote:
> Currently the pins alt3 (sdhci) are assigned to GPIO pinctrl.
> This is bad because a user could export it to sysfs and break
> sdhci. In order to avoid that remove those pins from GPIO pintrl.

> diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts

>  &gpio {
> -	pinctrl-0 = <&gpioout &alt0 &i2s_alt0 &alt3>;
> +	pinctrl-0 = <&gpioout &alt0 &i2s_alt0>;

This doesn't make sense. The current DT content is configuring those
pins as SDHCI, not as GPIO. Admitedly this is redundant since the
firmware and/or bootloader already did this in order to boot the system,
but irrespective, the current DT causes no issues. Removing the pinctrl
setting should not influence whether the pins can be exported via GPIO
sysfs either.
