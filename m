From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 09 Feb 2015 20:56:12 +0100
Subject: [PATCH v3 2/5] ARM: dts: pxa: add clocks
In-Reply-To: <54D64BBE.9080704@cogentembedded.com> (Sergei Shtylyov's message
 of "Sat, 07 Feb 2015 20:30:38 +0300")
References: <1423312760-15871-1-git-send-email-robert.jarzmik@free.fr>
 <1423312760-15871-2-git-send-email-robert.jarzmik@free.fr>
 <54D60B79.5060206@cogentembedded.com> <87a90p9815.fsf@free.fr>
 <54D64BBE.9080704@cogentembedded.com>
Message-ID: <87egpy7tb7.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +		ffuart: uart at 40100000 {
> +			clocks = <&pxa2xx_clks CLK_FFUART>;
> +		};
> +

After another thought about your "one line" node, I think this can be even
improved, so that :
 - uart clocks are put into pxa2xx.dtsi instead of pxa27x.dtsi
 - replace all pxa2xx_clks by clks
 - let pxa27x.dtsi, pxa3xx.dtsi declare the clks label

This way we'll have :
 - pxa2xx.dtsi
		ffuart: uart at 40100000 {
                        compatible = ...
                        ...
			clocks = <&clks CLK_FFUART>;
		};
 - pxa27x.dtsi
                clks: pxa2xx_clks at 41300004 {
                        compatible = "marvell,pxa270-clocks";
                        #clock-cells = <1>;
                        status = "okay";
                };
 - pxa3xx.dtsi
                clks: pxa3xx_clks at 41300004 {
                        compatible = "marvell,pxa300-clocks";
                        #clock-cells = <1>;
                        status = "okay";
                };

Cheers.

-- 
Robert
