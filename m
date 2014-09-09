From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Sep 2014 13:50:09 +0200
Subject: [PATCHv3 1/6] ARM: dts: Add SoC level device tree support for
 LS1021A
In-Reply-To: <1410253952-15631-2-git-send-email-jingchang.lu@freescale.com>
References: <1410253952-15631-1-git-send-email-jingchang.lu@freescale.com>
 <1410253952-15631-2-git-send-email-jingchang.lu@freescale.com>
Message-ID: <4286278.g3iXMFknkK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 September 2014 17:12:27 Jingchang Lu wrote:

> +		dcfg: dcfg at 1ee0000 {
> +			compatible = "fsl,ls1021a-dcfg";
> +			reg = <0x0 0x1ee0000 0x0 0x10000>;
> +		};
> +		scfg: scfg at 1570000 {
> +			compatible = "fsl,ls1021a-scfg";
> +			reg = <0x0 0x1570000 0x0 0x10000>;
> +		};

Should these be marked as 'compatible = "syscon"' as well?

> +	dcsr {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "fsl,dcsr", "simple-bus";
> +
> +		ranges = <0x0 0x0 0x20000000 0x1000000>;
> +
> +		dcsr-epu at 0 {
> +			compatible = "fsl,ls1021a-dcsr-epu";
> +			reg = <0x0 0x10000>;
> +		};

The binding document only specifies a generic "fsl,dcsr-epu", not
"fsl,ls1021a-dcsr-epu". It also mandates that "interrupts"
must be present and contain three interrupt lines.

Please fix either the DT or the binding, so they match.	

> +		dcsr-gdi at 100000 {
> +			compatible = "fsl,ls1021a-dcsr-gdi";
> +			reg = <0x100000 0x10000>;
> +		};
> +
> +		dcsr-dddi at 120000 {
> +			compatible = "fsl,ls1021a-dcsr-dddi";
> +			reg = <0x120000 0x10000>;
> +		};
> +
> +		dcsr-dcfg at 220000 {
> +			compatible = "fsl,ls1021a-dcsr-dcfg";
> +			reg = <0x220000 0x1000>;
> +		};
> +
> +		dcsr-clock at 221000 {
> +			compatible = "fsl,ls1021a-dcsr-clock";
> +			reg = <0x221000 0x1000>;
> +		};

None of these are part of the dcsr.txt binding.

> +		dcsr-rcpm at 222000 {
> +			compatible = "fsl,ls1021a-dcsr-rcpm";
> +			reg = <0x222000 0x1000 0x223000 0x1000>;
> +		};

Missing generic fsl,dcsr-rcpm compatible value again.

> +		dcsr-ccp at 225000 {
> +			compatible = "fsl,ls1021a-dcsr-ccp";
> +			reg = <0x225000 0x1000>;
> +		};

I'm not checking any devices below this one, I assume they are mostly
incomplete, so please go through the whole list and make sure they
all match the documentation.
I can't really find any code using the dcsr in Linux. Is there
an out of tree driver that you plan to submit?

	Arnd
