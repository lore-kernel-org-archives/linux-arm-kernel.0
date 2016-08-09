From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 9 Aug 2016 19:27:07 +0200
Subject: [linux-sunxi] Re: [PATCH v4 3/7] clk: sunxi: add generic
 multi-parent bus clock gates driver
In-Reply-To: <CAGb2v64CnRJyQih=DMZ4wfMPjdYNHwm2TxqNjaALsQ+m7bwsbg@mail.gmail.com>
References: <20160808172149.30861-1-andre.przywara@arm.com>
 <20160808172149.30861-4-andre.przywara@arm.com>
 <20160808201527.62ec34beb19b86dcfd3dbf03@free.fr>
 <CAGb2v64CnRJyQih=DMZ4wfMPjdYNHwm2TxqNjaALsQ+m7bwsbg@mail.gmail.com>
Message-ID: <20160809192707.ecb29cd176c29232e1086c82@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 9 Aug 2016 18:02:47 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> > The 'parent's of the bus gates are of no interest.
> > They are supposed to be (no clear documentation) apb1, apb2, ahb1 and
> > ahb2, but, as you well noticed in the patch 5/7, these clocks are fixed
> > and have no gate. Some of them are parents of real clocks, but they
> > don't bring anything to the bus gates of the other clocks.
> 
> Yes they are. Some devices, such as UARTs and I2C controllers, need
> to get the clock rate of the gate and calculate the proper internal
> divider.

You are right, the clocks of some subsystems have only a gate, but
these are exceptions.

Look at an ordinary clock, say the mmc0 of the H3.
There is a "bus" gate (see below) in the CCU register 0x60, bit 8, and
the "clock" gate in the CCU register 0x88, bit 31.

The 'simple-gates' says that the "bus gate" is child of ahb1 (in all
sunxi versions, the one prior to 'simple-gate', in the 'simple-gate',
in 'sunxi-ng', and now in Andr?'s patch).

But, where do you see a hardware relation between the mmc0 clock and
the ahb1 clock?

> > As I wrote previously, the simplest is to ungate/gate the clocks in
> > both the bus and clock registers on clk_prepare/unprepare.
> > Then, your 'multi-bus-gates' would be simply a generic 'multi-gates'.
> 
> This is somewhat misleading. What "clock" registers are you referring
> to? There are no "bus" registers. The reason we call them "bus clock
> gates" is because they are mashed together, instead of having clearly
> separated registers for each AHB/APB bus.
> 
> And if you want just a generic clock gates driver, we already have
> the "simple-gates" driver.

Maybe I used the wrong words.

The "clock" register is the one which defines the parameters of the
clock (parents, mul/div factors, gate). For the H3 mmc0, it is the
CCU register 0x60.

The "bus" register is one of the so-called "Bus Clock Gating Register"s.
For the H3 mmc0, it is the CCU register 0x88.	

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
