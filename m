From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 12 Jan 2015 13:15:58 +0100
Subject: [PATCH v3 1/5] usb: atmel_usba_udc: Rework at91sam9rl errata
 handling
In-Reply-To: <1421060278-27329-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1421060278-27329-1-git-send-email-boris.brezillon@free-electrons.com>
 <1421060278-27329-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1421064958.22660.54.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-01-12 at 11:57 +0100, Boris Brezillon wrote:
> at91sam9rl SoC has an erratum forcing us to toggle the BIAS on USB
> suspend/resume events.
> 
> This specific handling is only activated when CONFIG_ARCH_AT91SAM9RL is
> set and this option is only set when building a non-DT kernel, which is
> problematic since non-DT support for at91sam9rl SoC has been removed.

This sentence is not entirely correct. Commit bcf8c7e7703b ("ARM: at91:
remove at91sam9rl legacy board support") actually removed the Kconfig
symbol ARCH_AT91SAM9RL entirely. So the check for CONFIG_ARCH_AT91SAM9RL
has been pointless since (next-20141110 and) v3.19-rc1. See my report at
https://lkml.org/lkml/2014/11/10/232 .

(I stumbled on this patch because I contemplated sending a patch to
simply remove the check for CONFIG_ARCH_AT91SAM9RL and the currently
useless function toggle_bias.)

> Rework the toggle_bias implementation to attach it to the "at91sam9rl-udc"
> compatible string.
> 
> Add new compatible strings to avoid executing at91sam9rl erratum handling
> on other SoCs.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>


Paul Bolle
