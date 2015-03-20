From: tony@atomide.com (Tony Lindgren)
Date: Fri, 20 Mar 2015 15:35:41 -0700
Subject: [PATCHv5 27/35] ARM: dts: am33xx: add minimal l4 bus layout with
 control module support
In-Reply-To: <550C9490.3070505@ti.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
 <1426877086-17131-28-git-send-email-t-kristo@ti.com>
 <550C9490.3070505@ti.com>
Message-ID: <20150320223541.GV31346@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Suman Anna <s-anna@ti.com> [150320 14:44]:
> On 03/20/2015 01:44 PM, Kristo, Tero wrote:
> > +			scm: scm at 210000 {
> > +				compatible = "ti,am3-scm", "simple-bus";
> > +				reg = <0x210000 0x2000>;
> > +				#address-cells = <1>;
> > +				#size-cells = <1>;
> > +				ranges = <0 0x210000 0x2000>;
> > +
> > +				am33xx_pinmux: pinmux at 800 {
> > +					compatible = "pinctrl-single";
> > +					reg = <0x800 0x238>;
> > +					#address-cells = <1>;
> > +					#size-cells = <0>;
> > +					pinctrl-single,register-width = <32>;
> > +					pinctrl-single,function-mask = <0x7f>;
> > +				};
> > +
> > +				scm_conf: scm_conf at 0 {
> > +					compatible = "syscon";
> > +					reg = <0x0 0x7fc>;
> 
> Hmm, you are consolidating the am33xx_control_module and cm nodes, so is
> this supposed to be 0x800 or 0x7fc? I would think it should be 0x800.

Seems correct to me, it's offset 0, size 0x7fc. So that's the scm_conf
syscon area before pinctrl-single at 0x44c00000 + 0x210000 + 0.

The io area for pinctrl-single starts at 0x800, so the scm_conf should
be before it in the dts file.

> Also, are we ordering the child nodes of scm by node names or addresses.
> I have to add the wkup_m3 node, and prefer ordering by addresses.

Yeah address ordering makes most sense here IMO.

Note that you should follow the TRM "Table 2-2. L4_WKUP Peripheral Memory
Map" and set up things as separate devices as shown there. Pretty much
each row in that table is a separate device on the interconnect. That's
especially true if the device has registers like revision, sysc, syss
and so on. In that case they can be clocked and idled separately.

So with these changes we follow the hardware mapping, although only
partially have it populated now for l4_wkup:

l3 (ocp) +-> l4_per  +-> ...
         |           |-> ...
         |
         +-> l4_wkup +-> prcm
         |           |-> scm 
	 |           |-> ...
         |
         +-> ...     +-> ...


Regards,

Tony
