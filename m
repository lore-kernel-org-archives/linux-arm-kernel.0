From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 30 Jan 2014 19:29:25 +0100
Subject: [PATCH v2 00/21] pinctrl: mvebu: restructure and remove
 hardcoded addresses from Dove pinctrl
In-Reply-To: <1390869573-27624-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1390674856-4993-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1390869573-27624-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140130182925.GM10864@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 01:39:12AM +0100, Sebastian Hesselbarth wrote:
> This patch set is one required step for Dove to hop into mach-mvebu.
> Until now, pinctrl-dove was hardcoding some registers that do not
> directly belong to MPP core registers. This is not compatible with
> what we want for mach-mvebu.

Hi Sebastian

I think there might be something wrong here....

/debug/pinctrl/f1010000.pinctrl/pinconf-groups used to contain:

Pin config settings per pin group
Format: group (name): configs
0 (mpp0):current: spi(cs), available = [ gpio(io) nand(io2) ]
1 (mpp1):current: spi(mosi), available = [ gpo(o) nand(io3) ]
2 (mpp2):current: spi(sck), available = [ gpo(o) nand(io4) ]
3 (mpp3):current: spi(miso), available = [ gpo(o) nand(io5) ]
4 (mpp4):current: sata1(act), available = [ gpio(io) nand(io6) uart0(rxd) lcd(hsync) ]
5 (mpp5):current: sata0(act), available = [ gpo(o) nand(io7) uart0(txd) lcd(vsync) ]
6 (mpp6):current: sysrst(out), available = [ spi(mosi) ]
...

It now has:

Pin config settings per pin group
Format: group (name): configs
0 (mpp0):current: gpio(io), available = [ nand(io2) spi(cs) ]
1 (mpp1):current: gpo(o), available = [ nand(io3) spi(mosi) ]
2 (mpp2):current: gpo(o), available = [ nand(io4) spi(sck) ]
3 (mpp3):current: gpo(o), available = [ nand(io5) spi(miso) ]
4 (mpp4):current: gpio(io), available = [ nand(io6) uart0(rxd) sata1(act) lcd(hsync) ]
5 (mpp5):current: gpo(o), available = [ nand(io7) uart0(txd) sata0(act) lcd(vsync) ]
6 (mpp6):current: UNKNOWN, available = [ sysrst(out) spi(mosi) ]

The device i'm testing on does use spi and sata, so i would say the
old contents was correct and the new is wrong.

    Andrew
