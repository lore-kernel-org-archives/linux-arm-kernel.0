From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 27 Aug 2015 17:51:51 +0200
Subject: [PATCH 03/10] ARM: marvell/dt: add crypto related nodes to
 armada 370 dtsi
In-Reply-To: <877fog69a7.fsf@free-electrons.com>
References: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
 <1439885341-14644-4-git-send-email-boris.brezillon@free-electrons.com>
 <877fog69a7.fsf@free-electrons.com>
Message-ID: <20150827175151.23994256@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Thu, 27 Aug 2015 17:28:00 +0200
Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Boris and Arnaud,
> 
> Boris Brezillon <boris.brezillon@free-electrons.com> writes:
> 
> > From: Arnaud Ebalard <arno@natisbad.org>
> >
> > Add crypto related nodes in armada-370.dtsi.
> [...]
> > +
> > +			crypto at 90000 {
> > +				compatible = "marvell,armada-370-crypto";
> > +				reg = <0x90000 0x10000>;
> > +				reg-names = "regs";
> > +				interrupts = <48>;
> > +				clocks = <&gateclk 23>;
> > +				clock-names = "cesa0";
> > +				marvell,crypto-srams = <&crypto_sram>;
> > +				marvell,crypto-sram-size = <0x7e0>;
> > +			};
> > +		};
> > +
> > +		crypto_sram: sa-sram {
> > +			compatible = "mmio-sram";
> > +			reg = <MBUS_ID(0x09, 0x01) 0 0x800>;
> > +			reg-names = "sram";
> > +			clocks = <&gateclk 23>;
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges = <0 MBUS_ID(0x09, 0x01) 0 0x800>;
> > +
> > +			idle-sram at 0 {
> > +				reg = <0x0 0x20>;
> > +			};
> 
> So you think at the cpuilde hack using the sram. And you reserved 32
> bytes for it. So indeed it is enough to store the code we need. Could
> you add a little comment about it ?

Sure, I'll add a comment explaining why we reserve a memory region for
idle support.

> 
> In mvebu_setup_boot_addr_wa we use mvebu_mbus_add_window_by_id but this
> windows was also added by the code you add. I wonder if it could be a
> problem.

I tested it and it works: apparently you can create different MBUS
windows pointing to the same peripheral (in our case the SRAM).

> 
> Maybe we should look for if the idle-sram is present and in this case
> not calling mvebu_mbus_add_window_by_id, but it is not necessary for
> this series.

Hm, I considered reworking the code dealing with this erratum, but
since everything works as is I don't think this is necessary.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
