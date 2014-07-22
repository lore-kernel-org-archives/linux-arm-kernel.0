From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 22 Jul 2014 16:15:38 +0800
Subject: iMX6Q FEC: transmit queue 0 timed out
In-Reply-To: <CAOpc7mHvddM1bCex13yPTRrEkFqYvk2YHYajZeMn+MG83neUBA@mail.gmail.com>
References: <20140602124242.GB933@n2100.arm.linux.org.uk>
 <CAOpc7mFbJQNeBmOG0C-Qn856MmhtUkTq=QeDPC-EWXryi6sFGg@mail.gmail.com>
 <20140602133352.GC933@n2100.arm.linux.org.uk>
 <CAOpc7mHJ5CqCcB1rE3b8q58HDdSWeG41PTAMwgeARAL_hgUt_g@mail.gmail.com>
 <d7f1957c2afc44e8b900001e606905c0@BLUPR03MB373.namprd03.prod.outlook.com>
 <CAOpc7mHHOmEcvnSDTc+9eyCtLyMBvR2aU36XFcddT4pa0f2KOQ@mail.gmail.com>
 <a97d34741f694cd2b89b4c7f0bebc114@BLUPR03MB373.namprd03.prod.outlook.com>
 <CAOpc7mHxYVOUQVcTqPH9pLXtqNaxgeqJGoJ=U4cRNgSzOpj7Wg@mail.gmail.com>
 <20140604135047.GC23430@n2100.arm.linux.org.uk>
 <CAOpc7mHvddM1bCex13yPTRrEkFqYvk2YHYajZeMn+MG83neUBA@mail.gmail.com>
Message-ID: <20140722081536.GD5485@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 10:41:10AM +0200, Holger Schurig wrote:
> Andy,
> 
> to revive an old thread: I now got ethernet working. Basically, I
> needed to set the system so that the PHY is generating the ref-clock.
> I found even code in arch/arm/mach-imx/mach-imx6q.c that controls
> setting of GPR1[21] from the device tree. However, I wasn't really
> able to come up with a device-tree that triggers the code
> IMX6Q_GPR1_ENET_CLK_SEL_PAD. For example, Neither
> Documentation/devicetree/bindings/net/fsl-fec.txt nor any other file
> there mention anything on how to do this.
> 
> Currently I disable the 3rd clock. I changed the default
>          clocks = <&clks 117>, <&clks 117>, <&clks 190>;
>          clock-names = "ipg", "ahb", "ptp";
> (from imx6qdl.dtsi) to my dts:
>          clocks = <&clks 117>, <&clks 117>;
>          clock-names = "ipg", "ahb";
> 
> Would I have needed to create some dummy clock, e.g. "ext-phy-clk" and
> specified that as a third clock in my dts?

Since in your setup PHY is generating the reference clock, you need to
define this clock in your board dts, and overwrite the 'ptp' clock with
it, something like the following.

clocks {
	#address-cells = <1>;
	#size-cells = <0>;

	rmii_clk: clock at 0 {
		compatible = "fixed-clock";
		reg = <0>;
		#clock-cells = <0>;
		clock-frequency = <25000000>;  /* 25MHz for example */
		clock-output-names = "rmii_ref_clk";
	};
};

&fec {
        clocks = <&clks 117>, <&clks 117>, <&rmii_clk>;
};
