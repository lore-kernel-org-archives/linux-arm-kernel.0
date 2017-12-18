From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 18 Dec 2017 14:57:37 +0100
Subject: [PATCH net-next 2/2 v9] net: ethernet: Add a driver for Gemini
 gigabit ethernet
In-Reply-To: <20171216193911.6938-2-linus.walleij@linaro.org>
References: <20171216193911.6938-1-linus.walleij@linaro.org>
 <20171216193911.6938-2-linus.walleij@linaro.org>
Message-ID: <CACRpkdZ3t9ZDB-GOoriq0Jm=-GtYzUX-qc36o_XbWO9NQzMUmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 16, 2017 at 8:39 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> The Gemini ethernet has been around for years as an out-of-tree
> patch used with the NAS boxen and routers built on StorLink
> SL3512 and SL3516, later Storm Semiconductor, later Cortina
> Systems. These ASICs are still being deployed and brand new
> off-the-shelf systems using it can easily be acquired.
>
> The full name of the IP block is "Net Engine and Gigabit
> Ethernet MAC" commonly just called "GMAC".
>
> The hardware block contains a common TCP Offload Enginer (TOE)
> that can be used by both MACs. The current driver does not use
> it.
>
> Cc: Tobias Waldvogel <tobias.waldvogel@gmail.com>
> Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes from v8:
> - Remove dependency guards in Kconfig to get a wider compile
>   coverage for the driver to detect broken APIs etc.

I guess we need to hold this off for a while, the code does
some weird stuff using the ARM-internal page DMA mapping
API.

I *think* what happens is that the driver allocates a global queue
used for RX and TX on both interfaces, then initializes that with
page pointers and gives that to the hardware to play with.

When an RX packet comes in, the RX routine needs to figure
out from the DMA (physical) address which remapped
page/address this random physical address pointer
corresponds to.

The Linux DMA API assumption is that the driver keeps track
of this mapping, not the hardware. So we need to figure out
a way to reverse-map this. Preferably quickly, and without
using any ARM-internal mapping APIs.

Yours,
Linus Walleij
