From: mirq-linux@rere.qmqm.pl (=?iso-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Mon, 18 Dec 2017 15:48:17 +0100
Subject: [PATCH net-next 2/2 v9] net: ethernet: Add a driver for Gemini
 gigabit ethernet
In-Reply-To: <CACRpkdZ3t9ZDB-GOoriq0Jm=-GtYzUX-qc36o_XbWO9NQzMUmA@mail.gmail.com>
References: <20171216193911.6938-1-linus.walleij@linaro.org>
 <20171216193911.6938-2-linus.walleij@linaro.org>
 <CACRpkdZ3t9ZDB-GOoriq0Jm=-GtYzUX-qc36o_XbWO9NQzMUmA@mail.gmail.com>
Message-ID: <20171218144817.GA25352@qmqm.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 02:57:37PM +0100, Linus Walleij wrote:
> On Sat, Dec 16, 2017 at 8:39 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > The Gemini ethernet has been around for years as an out-of-tree
> > patch used with the NAS boxen and routers built on StorLink
> > SL3512 and SL3516, later Storm Semiconductor, later Cortina
> > Systems. These ASICs are still being deployed and brand new
> > off-the-shelf systems using it can easily be acquired.
[...]
> > ---
> > Changes from v8:
> > - Remove dependency guards in Kconfig to get a wider compile
> >   coverage for the driver to detect broken APIs etc.
> 
> I guess we need to hold this off for a while, the code does
> some weird stuff using the ARM-internal page DMA mapping
> API.
> 
> I *think* what happens is that the driver allocates a global queue
> used for RX and TX on both interfaces, then initializes that with
> page pointers and gives that to the hardware to play with.
> 
> When an RX packet comes in, the RX routine needs to figure
> out from the DMA (physical) address which remapped
> page/address this random physical address pointer
> corresponds to.
> 
> The Linux DMA API assumption is that the driver keeps track
> of this mapping, not the hardware. So we need to figure out
> a way to reverse-map this. Preferably quickly, and without
> using any ARM-internal mapping APIs.

IIRC, the hardware copies descriptors from free queue (FREEQ)
to RX queues. FREEQ is shared among the two ethernet ports.

This platform is CPU bound, so every additional lookup will
hit performance here. In my version I had an #ifdef for
COMPILE_TEST that replaced ARM-specific calls with stubs.
Since the driver is not expected to work on other platforms,
this seemed like the best workaround to make it compile
on other arches.

Best Regards,
Micha? Miros?aw
