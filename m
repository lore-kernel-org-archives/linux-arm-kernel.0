From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri, 23 Aug 2013 09:32:50 +0200
Subject: [RFC 17/17] clk: zynq: remove call to of_clk_init
In-Reply-To: <c4d10bdf-6506-4edc-92cc-2acc67b86602@VA3EHSMHS032.ehs.local>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376964271-22715-18-git-send-email-sebastian.hesselbarth@gmail.com>
 <d17acba9-85f9-40cd-a176-2005e3e924f8@CO1EHSMHS002.ehs.local>
 <c4d10bdf-6506-4edc-92cc-2acc67b86602@VA3EHSMHS032.ehs.local>
Message-ID: <20130823073250.GB30135@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Thu, Aug 22, 2013 at 05:59:36PM -0700, S?ren Brinkmann wrote:
> On Thu, Aug 22, 2013 at 05:26:47PM -0700, S?ren Brinkmann wrote:
> > Hi Sebastian,
> >
> > On Tue, Aug 20, 2013 at 04:04:31AM +0200, Sebastian Hesselbarth wrote:
> > > With arch/arm calling of_clk_init(NULL) from time_init(), we can now
> > > remove it from corresponding drivers/clk code.
> >
> > I think that would break Zynq.
> > If I see this correctly you call of_clk_init() from common code,
> > _before_ the SOC specific time init function is called.
> > The problem is, that we have code setting up a global pointer which is
> > required by zynq_clk_setup() which is triggered when of_clk_init() is
> > called.
> >
> > Let me try to illustrate the current call graph:
> >
> > time_init()
> > 	zynq_timer_init()		// this machines init_time()
> > 		zynq_slcr_init()	// setup System Level Control Registers including a global pointer
> > 			zynq_clock_init()
> > 				of_clk_init()
> > 					zynq_clk_setup()   // requires pointer setup in zynq_slcr_init()
> > 					...
> >
> > IIUC, your series would change this to:
> > time_init()
> > 	of_clk_init()
> > 		zynq_clk_setup()	// SLCR pointer is not setup/NULL
> > 		...
> > 	zynq_timer_init()
> > 		zynq_slcr_init()	// now the pointer becomes valid
>
> I guess we could move zynq_slcr_init() into init_irq(). I'll give that a
> shot tomorrow.
>

I propose getting rid of the whole global pointer and let the clkc map the
address itself instead.

Then there is no need to shuffle stuff around in the initcalls.
I have some WIP patches (not rebased on next and not even tested with it,
but with v3.11-rc4)

The dtsi would be something like:

       control-register at f8000000 {
	       compatible = "simple-bus";
               #address-cells = <1>;
               #size-cells = <1>;
               reg = <0xf8000000 0x1000>;
               ranges;

               slcr: slcr at f8000000 {
                       compatible = "xlnx,zynq-slcr", "syscon";
                       reg = <0xf8000000 0x10>;
               };

               clkc: clkc at f8000100 {
                       #clock-cells = <1>;
                       compatible = "xlnx,ps7-clkc";
                       reg = <0xf8000100 0x100>;
                       ps-clk-frequency = <33333333>;
		       xlnx,slcr = <&slcr>;
                       clock-output-names = "armpll", "ddrpll", "iopll", "cpu_6or4x",
                                       "cpu_3or2x", "cpu_2x", "cpu_1x", "ddr2x", "ddr3x",
                                       "dci", "lqspi", "smc", "pcap", "gem0", "gem1",
                                       "fclk0", "fclk1", "fclk2", "fclk3", "can0", "can1",
                                       "sdio0", "sdio1", "uart0", "uart1", "spi0", "spi1",
                                       "dma", "usb0_aper", "usb1_aper", "gem0_aper",
                                       "gem1_aper", "sdio0_aper", "sdio1_aper",
                                       "spi0_aper", "spi1_aper", "can0_aper", "can1_aper",
                                       "i2c0_aper", "i2c1_aper", "uart0_aper", "uart1_aper",
                                       "gpio_aper", "lqspi_aper", "smc_aper", "swdt",
                                       "dbg_trc", "dbg_apb";
               };

               mio: pinmux at f8000700 {
                       compatible = "xlnx,ps7-pinctrl";
                       reg = <0xf8000700 0x110>;
		       xlnx,slcr = <&slcr>;
               };
       };

With the phandle to the slcr node it should also be possible to handle locking,
unlocking, but I haven't tried that yet.
Also, as you can see, I would add "syscon" to the slcr. Than it can get an early
init call to unlock the register space. And be later added as as syscon driver
so you can work with regmap etc. and work dynamically with the slcr after boot
(pinmuxing + dt overlays etc). I have tested the early-init-and-later-syscon-registering-stuff
and it works. With the time_init changes, the early_init might have to be earlier
though, but only when the slcr is locked.

The clkc driver than has

        np = of_find_compatible_node(NULL, NULL, "xlnx,ps7-clkc");
        if (!np) {
                pr_err("%s: no ps7-clkc node found\n", __func__);
                BUG();
        }

        zynq_slcr_base_priv = of_iomap(np, 0);
        if (!zynq_slcr_base_priv) {
                pr_err("%s: Unable to map I/O memory\n", np->name);
                of_node_put(np);
                BUG();
                return;
        }

in the setup function. So, it is independent from any prior setup of the slcr.
This just leaves the locking. Which might me able to be handled with the phandle.

But I have to finish that first. So, if reording the entries is working as a
hotfix, go ahead I guess.


Regards,
Steffen

--
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
