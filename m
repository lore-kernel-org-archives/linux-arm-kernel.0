From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Apr 2012 13:47:21 +0100
Subject: Using GPMI-NAND driver on iMX28 using 3.4-rc1?
In-Reply-To: <20120410123952.GA419@S2101-09.ap.freescale.net>
References: <CAOMZO5AsbFDXHs3JRLC5=1MjZ7QrxciqV25xpZQL1Yvk3boQmw@mail.gmail.com>
 <CAOdLEaoEDr7fnswwV-Gs8tZF9Zj-RFnRa9Z=eqRFd0==OgV10Q@mail.gmail.com>
 <CAOMZO5AoFnM=cCR-kS4A1k2xY_bRd9+gN1p9bFxdyPS2-UdbkQ@mail.gmail.com>
 <4F7D3DB8.6080009@freescale.com>
 <CAOdLEaoy8ARS=awimR6fN8EcX+FrqxaSr3VUG3rP3zrNLOf+Gw@mail.gmail.com>
 <1333628861.31825.22.camel@vkoul-udesk3>
 <20120406022305.GJ7264@S2101-09.ap.freescale.net>
 <4F7EC6AF.6000603@freescale.com>
 <20120410094223.GN24211@n2100.arm.linux.org.uk>
 <20120410123952.GA419@S2101-09.ap.freescale.net>
Message-ID: <20120410124721.GS24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 08:39:58PM +0800, Shawn Guo wrote:
> When mxs-dma driver was created, we chose to only support a single
> descriptor at the beginning, and mxs_dma_issue_pending() is an empty
> function right now .  This is something needs to be improved, but it
> should be orthogonal to the bug fix posted here.

You could view it as being the reason that the bug occurred, because
had the issue_pending() function been used to start the transfer,
things would naturally happen in the right order.

So, one solution to the bug would be to do exactly that - move the
channel enable to the issue pending function, which will have the
same effect as reversing the order of cookie assignment and channel
enable.

However, the risk is that because you have a no-op issue_pending(),
some of your drivers may have decided its not worth calling and omitted
it.
