From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 07 Feb 2014 11:58:09 +0100
Subject: mv64xxx: I2C bus locked when scanning absent devices on Armada XP
In-Reply-To: <52F35DE3.8060503@free-electrons.com>
References: <52F35DE3.8060503@free-electrons.com>
Message-ID: <52F4BC41.3030902@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2014 11:03, Gregory CLEMENT wrote:
> Hi,
> 
> I write this email mainly to let you know that there are some issues
> on i2c on the Armada XP (rev A0 and B0) based boards.
> 
> What we observed was that if the i2c driver try to access an address
> where the device is absent, then the bus is locked. After the timeout
> the driver give up, but if we have a lot of i2c client registered,
> then the kernel spend a lot of time trying to scan all the
> addresses. It is noticeable when using the multiv7_defconfig where
> many i2c clients are registered, whereas with mvebu_defconfig we have
> fewer i2c clients, and most of them are present on the boards.
> 
> Here is an extract of what you can see during a boot:
> 
> [    4.127648] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [    4.137338] rtc-s35390a 1-0030: rtc core: registered rtc-s35390a as rtc0
> [    6.137649] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [    8.137648] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   10.137648] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   12.137648] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   14.137648] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   16.137648] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   18.137648] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   20.137648] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   22.137648] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   24.137648] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   26.137648] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   28.137648] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   30.137648] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   32.137649] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   34.137648] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   36.137648] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   38.137648] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   40.137648] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   42.137648] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   44.137648] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   46.137648] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   48.137648] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   50.137648] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   52.137648] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   54.137648] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   56.137648] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   58.137648] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   60.137648] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   62.137648] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [   62.144403] sdhci: Secure Digital Host Controller Interface driver
> 
> Then the kernel continue to boot. and except this very annoying delay,
> everything else is working on i2c.
> 
> If anyone have an idea of the cause of this issue, I would be glad to
> have any input.
> 
> I continue to investigate it, and for the record v3.12 was not
> affected but v3.13 was. So now I am going to bisect.

Hi all,

I wanted to let you know that I have just found a fix for this issue.

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
