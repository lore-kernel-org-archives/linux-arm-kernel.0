From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 12:44:44 +0200
Subject: [PATCH v9 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <1431623147-4950-4-git-send-email-lho@apm.com>
References: <1431623147-4950-1-git-send-email-lho@apm.com>
 <1431623147-4950-3-git-send-email-lho@apm.com>
 <1431623147-4950-4-git-send-email-lho@apm.com>
Message-ID: <2623886.1GmlYtlSK2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 May 2015 11:05:45 Loc Ho wrote:
> +       edac: edac at 78800000 {
> +               compatible = "apm,xgene-edac";
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               reg = <0x0 0x78800000 0x0 0x100>;

This seens a 'ranges' property to make the address resolution
work. An empty property should be fine.

> +               interrupts = <0x0 0x20 0x4>,
> +                            <0x0 0x21 0x4>,
> +                            <0x0 0x27 0x4>;
> +
> +               edacmc0: edacmc0 at 7e800000 {
> +                       compatible = "apm,xgene-edac-mc";
> +                       regmap-csw = <&csw>;
> +                       regmap-mcba = <&mcba>;
> +                       regmap-mcbb = <&mcbb>;
> +                       reg = <0x0 0x7e800000 0x0 0x1000>;
> +               };
> +
> +               edacpmd0: edacpmd0 at 7c000000 {
> +                       compatible = "apm,xgene-edac-pmd";
> +                       regmap-efuse = <&efuse>;
> +                       reg = <0x0 0x7c000000 0x0 0x200000>;
> +               };

Why do you have labels for each one? If nothing references
these nodes, just remove the labels.

Regarding the names, remove the numbers for the nodes that are
uniquely identified by the register location, e.g. replace
edacmc0 at 7e800000 with edacmc at 7e800000.

If you have multiple edac-mc devices, would they point to the
same syscon nodes, or different ones for each? If they are the
same, just move the references to the main node.

	Arnd
