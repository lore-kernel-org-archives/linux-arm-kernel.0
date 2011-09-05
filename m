From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 05 Sep 2011 08:54:30 +0200
Subject: [PATCH] arm: ixp4xx, u300: Select ARCH_REQUIRE_GPIOLIB,
	not GENERIC_GPIO
In-Reply-To: <1315192383.3092.260.camel@deadeye> (Ben Hutchings's message of
	"Mon, 05 Sep 2011 04:12:56 +0100")
References: <1315192383.3092.260.camel@deadeye>
Message-ID: <87r53v7a3d.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Hutchings <ben@decadent.org.uk> writes:

Hi,

> The GPIO implementations for these two machines depend on gpiolib,
> so they must not select GENERIC_GPIO directly.

They're not calling gpiochip_add afaik so they should really only select
GENERIC_GPIO.

>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
> This hould fix the build failure seen here:
> https://buildd.debian.org/status/fetch.php?pkg=linux-2.6&arch=armel&ver=3.1.0%7Erc4-1%7Eexperimental.1&stamp=1315007168

The problem here is that gpio_request_one has been added to the ads7846
driver but gpio_request_one is not defined in GENERIC_GPIO case (I
guess that other (arm and non-arm) platforms may hit similar troubles
with gpio_request_one. One quick fix would be to add a gpio_request_one
function say in asm-generic/gpio.h. One other fix would be to define
gpio_request_one and gpio_request_array in each
machine/platform/... specific header. Don't know what's the best
solution.


Arnaud
