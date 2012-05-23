From: jrnieder@gmail.com (Jonathan Nieder)
Date: Wed, 23 May 2012 12:27:03 -0500
Subject: [PATCH] ixp4xx: fix compilation by adding gpiolib support
In-Reply-To: <1337789991-5283-1-git-send-email-richardcochran@gmail.com>
References: <1337789991-5283-1-git-send-email-richardcochran@gmail.com>
Message-ID: <20120523172703.GI21608@burratino>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

Richard Cochran wrote:

> Once again, ixp4xx no longer even compiles.

Awesome, thanks for your persistence.

>From [1] I see some details that would be useful for the commit message.
Could you include them?

	This patch adds gpiolib support for the IXP4xx platform, which fixes the
	compilation of several ixp4xx platforms, e.g.:

	In file included from arch/arm/mach-ixp4xx/include/mach/gpio.h:72,
			     from /home/frogger/projects/server/linux/arch/arm/include/asm/gpio.h:9,
			     from include/linux/gpio.h:30,
			     from arch/arm/mach-ixp4xx/nslu2-setup.c:19:
	include/asm-generic/gpio.h: In function 'gpio_get_value_cansleep':
	include/asm-generic/gpio.h:218: error: implicit declaration of function '__gpio_get_value'
	include/asm-generic/gpio.h: In function 'gpio_set_value_cansleep':
	include/asm-generic/gpio.h:224: error: implicit declaration of function '__gpio_set_value'

And:

	The problem was introduced with commit eb9ae7f2a381 ("gpio: fix build
	error in include/asm-generic/gpio.h").

[...]
> This fix should also go for 3.1, 3.2, 3.3, and 3.4.

If 3.1.y were still maintained, do I understand correctly that it
would not need this because it lacks eb9ae7f2a381?

[...]
>  arch/arm/Kconfig                         |    2 +-
>  arch/arm/mach-ixp4xx/common.c            |   48 +++++++++++++++++-
>  arch/arm/mach-ixp4xx/include/mach/gpio.h |   79 +-----------------------------
>  3 files changed, 48 insertions(+), 81 deletions(-)

This is bigger than the usual stable-kernel-rules.txt standard (100
lines with context), but the gpio.h change leaves me so happy that I
suspect it should be okay. :)  If it isn't, we can cross that bridge
later.

Hope that helps,
Jonathan

[1] http://thread.gmane.org/gmane.linux.kernel/1250585/focus=1250584
