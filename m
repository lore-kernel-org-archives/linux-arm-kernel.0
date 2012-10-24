From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 24 Oct 2012 21:38:23 +0200
Subject: [PATCH] [RFC] pinctrl: mvebu: reset pins to an UNKNOWN state
 on startup
In-Reply-To: <1351106281-31288-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351106281-31288-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <508843AF.7060803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2012 09:18 PM, Thomas Petazzoni wrote:
> Note: this patch is a *RFC*, it is not intended for merging, only to
> get a discussion started. The code is horrible, makes terrible
> assumptions and so on.
>
> On many platforms, most of the pinmux initialization is done in the
> bootloader, and therefore persists when we boot the Linux kernel. This
> prevents us from making sure that the pinmux configuration in the
> board device trees is correct.

Thomas,

how you make sure something you don't know about? The bootloader sets
these pinmux settings for a reason and if the DT doesn't tell the kernel
it should make no assumptions at all.

> One idea to make sure our device trees are correct in terms of
> pinmuxing is to set the state of each pin to an unavailable function
> during the initialization of the pinctrl driver. This way, only pins
> that are explicitly configured through proper device tree attributes
> will actually be functional.
>
> Remaining questions to solve:
>
>   * Is this useful?

IMHO it isn't - but maybe I am missing the point here. What is it that
you don't like in the bootloaders choice of configuring pinmux?

>   * Maybe some pins should be excluded for this, especially if the
>     console serial port pins are muxed. On Armada XP, it's not the
>     case: UART0 RX/UART0 TX pins are not part of MPPs, so we can clear
>     all pins. But on other mvebu platforms, it may be the case.

That's why you don't touch pins that you don't know about. The mvebu
pinctrl is written to overwrite pinctrl settings only if someone
requests a special function. Usually this is done by a developer that
knows about the board.

Sebastian
