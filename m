From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 22 May 2012 07:26:18 +0800
Subject: [GIT PULL] DT clk binding support
In-Reply-To: <4FBA89E3.7010106@gmail.com>
References: <4FB80F32.5090309@gmail.com>
 <20120520030653.GB5810@S2100-06.ap.freescale.net>
 <4FB9A5E7.2070000@gmail.com>
 <20120521064901.GE8140@S2101-09.ap.freescale.net>
 <4FBA89E3.7010106@gmail.com>
Message-ID: <20120521232616.GF8140@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 01:30:59PM -0500, Rob Herring wrote:
> > With the bindings here, I need something like below in device tree to
> > replace the clk lookup registration that is currently done in imx6q
> > sabrelite specific setup code.  However the problem here is I have cko
> > defined in clock driver, and thus I can not give phandle to cko in
> > device tree.  What I suggest is for such cases, we could require
> > clock-names = "cko" than clocks = <&cko>, and of_clk_get() should also
> > be able to find the clock with looking for the clk name.
> > 
> > imx6q-sabrelite.dts:
> > 
> > 	codec: sgtl5000 at 0a {
> > 		compatible = "fsl,sgtl5000";
> > 		reg = <0x0a>;
> > 		clocks = <&cko>;
> > 	};
> > 
> > mach-imx6q.c, imx6q_sabrelite_cko1_setup(): 
> > 
> >         cko1 = clk_get_sys(NULL, "cko1");
> >         clk_register_clkdev(cko1, NULL, "0-000a");
> > 
> 
> What!? This is a terrible abuse/hack of the clock binding and is in no
> way what was intended. You cannot use half of the clock binding. You
> have to have a provider. The primary binding is a phandle reference.
> clock-names is just auxiliary data.
> 
Well, on conversation [1], it seems people agreed that for those huge
clock tree, only leaf clocks should be exposed in device tree.  Then
please help me understand how we could do that with the current binding
design, considering those leaf clocks are consumers of their parent
clocks while being provider to the leaf clock the parent clock is not
exposed in device tree.

Regards,
Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/139414/focus=1216423
