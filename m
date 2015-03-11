From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Mar 2015 21:31:42 +0100
Subject: [PATCHv1] rtc: bcm-iproc: Add support for Broadcom iproc rtc
In-Reply-To: <55009ED6.4050205@broadcom.com>
References: <1418757750-3628-1-git-send-email-arun.ramamurthy@broadcom.com>
 <2216310.NqXA88JvvL@wuerfel> <55009ED6.4050205@broadcom.com>
Message-ID: <3192051.z32dL5alyl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 March 2015 13:00:22 Arun Ramamurthy wrote:
> 
> Arnd, this is the device tree entry that I would end up with and I plan 
> to use syscon_regmap_lookup_by_phandle in the rtc driver. Does this look 
> acceptable?
> 
> rtc: iproc_rtc at 0x03026000 {
>                 compatible = "brcm,iproc-rtc";
>                 reg =   <0x03026000 0xC>,
>                 iso_cell_syscon = <&crmu_iso_cell_control>;
>                 bbl_auth_syscon = <&crmu_bbl_auth>
>                 status = "okay";
> 
> crmu_iso_cell_control:crmu at 0x0301C02C {
>                 compatible = "syscon";
>                 reg = <0x0301C038 0x8>
> }
> 
> crmu_bbl_auth:crmu at 0x03024C74 {
>                 compatible = "syscon";
>                 reg = <0x03024C74 0x8>;
> }

This doesn't look right, sorry:

A syscon device is defined as a collection of registers that
have no logical grouping within them but that can be seen
as a single device. What you have here instead are two syscon
nodes that each have only a single 8-byte register.

What are the other registers surrounding those? I would expect
something like

	crmu0: syscon at 03010000 {
                 compatible = "syscon";
                 reg = <0x03010000 0x10000>;
	};

and then use an offset into the syscon from the rtc node, like

	iproc_rtc: rtc at 03026000 {
		compatible = "brcm,iproc-rtc";
		reg = <0x03026000 0x1000>;
		iso_cell_syscon = <&crmu0 0xc038>;
		bbl_auth_syscon = <&crmu1 0x4c74>;
	};

Note also that you got most of the naming wrong:

- node names should be generic strings like "rtc", "syscon", "pci" etc.
  The specific strings are defined in ePAPR.
- unit addresses should match the first 'reg' property and
  not start with '0x'.
- it seems strange that the rtc has only 12 bytes of registers,
  though that may actually be correct.

	Arnd
