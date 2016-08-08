From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 8 Aug 2016 20:15:27 +0200
Subject: [PATCH v4 3/7] clk: sunxi: add generic multi-parent bus clock
 gates driver
In-Reply-To: <20160808172149.30861-4-andre.przywara@arm.com>
References: <20160808172149.30861-1-andre.przywara@arm.com>
 <20160808172149.30861-4-andre.przywara@arm.com>
Message-ID: <20160808201527.62ec34beb19b86dcfd3dbf03@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  8 Aug 2016 18:21:45 +0100
Andre Przywara <andre.przywara@arm.com> wrote:

> The Allwinner H3 SoC introduced bus clock gates with potentially
> different parents per clock gate register. The H3 driver chose to
> hardcode the actual parent clock relation in the code.
> Add a new driver (which has the potential to drive the H3 and also
> the simple clock gates as well) which uses the power of DT to describe
> this relationship in an elegant and flexible way.
> Using one subnode for every parent clock we get away with a single
> DT compatible match, which can be used as a fallback value in the
> actual DTs without the need to add specific compatible strings to the
> code.  This avoids adding a new driver or function for every new SoC.

The 'parent's of the bus gates are of no interest.
They are supposed to be (no clear documentation) apb1, apb2, ahb1 and
ahb2, but, as you well noticed in the patch 5/7, these clocks are fixed
and have no gate. Some of them are parents of real clocks, but they
don't bring anything to the bus gates of the other clocks.

As I wrote previously, the simplest is to ungate/gate the clocks in
both the bus and clock registers on clk_prepare/unprepare.
Then, your 'multi-bus-gates' would be simply a generic 'multi-gates'.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
