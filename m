From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 2 Feb 2017 17:56:50 +0100
Subject: [PATCHv2 net-next 01/16] dt-bindings: net: update Marvell PPv2
 binding for PPv2.2 support
In-Reply-To: <20170103201842.hdg2uzzesog2jund@rob-hp-laptop>
References: <1482943592-12556-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482943592-12556-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170103201842.hdg2uzzesog2jund@rob-hp-laptop>
Message-ID: <20170202175650.1fc06c2d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 3 Jan 2017 14:18:42 -0600, Rob Herring wrote:

> > +- port-id: ID of the port from the MAC point of view
> > +- gop-port-id: only for marvell,armada-7k-pp2, ID of the port from the
> > +  GOP (Group Of Ports) point of view  
> 
> What GOP is needs a better explanation. Why doesn't 375 need this?

GOP stands for "group of ports", it's one of the HW component inside
the PPv2 IP.

Armada 375 also has the same GOP, but we described the registers in a
different way for Armada 375, with one reg entry per port:

        reg = <0xf0000 0xa000>,
              <0xc0000 0x3060>,
              <0xc4000 0x100>,
              <0xc5000 0x100>;

The last two entries are the per-port registers for eth0 and eth1.

For PPv2.2, we wanted to simplify a little bit the register mappings,
and simply reflect the memory map of the SoC. In the SoC datasheet,
there are two memory areas for the networking subsystem, which are the
two areas reflected in:

        reg = <0x0 0x100000>,
              <0x100000 0x80000>;

The per-port registers are inside the second register area. But by
exposing the entire register area in the Device Tree binding, we allow
improvements in the driver that need additional registers to be made
without changing the Device Tree description of the device.

> > +Example for marvell,armada-7k-pp2:
> > +
> > +cpm_ethernet: ethernet at 0 {
> > +	compatible = "marvell,armada-7k-pp22";
> > +	reg = <0x0 0x100000>,
> > +	      <0x100000 0x80000>;
> > +	clocks = <&cpm_syscon0 1 3>, <&cpm_syscon0 1 9>, <&cpm_syscon0 1 5>;
> > +	clock-names = "pp_clk", "gop_clk", "gp_clk";
> > +	status = "disabled";  
> 
> Drop status from examples.

OK, so I'll have to adjust this for the existing armada-375-pp2 example
as well.

> > +
> > +	eth0: eth at 0 {  
> 
> unit address requires a reg property. Or this can be 'eth0' instead.

Same here, the sub-nodes don't have a reg property for armada-375-pp2,
so I guess this comment applies as well, right?

Thanks for your feedback!

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
