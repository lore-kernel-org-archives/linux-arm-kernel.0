From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 Jan 2014 16:33:17 +0100
Subject: [PATCH v7 4/4] arm64: Add APM X-Gene SoC SATA host controller DTS
 entries
In-Reply-To: <1388708539-333-5-git-send-email-lho@apm.com>
References: <1388708539-333-1-git-send-email-lho@apm.com>
 <1388708539-333-4-git-send-email-lho@apm.com>
 <1388708539-333-5-git-send-email-lho@apm.com>
Message-ID: <201401031633.18110.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 January 2014, Loc Ho wrote:
> +                       sata23clk: sata23clk at 1f22c000 {
> +                               compatible = "apm,xgene-device-clock";
> +                               #clock-cells = <1>;
> +                               clocks = <&socplldiv2 0>;
> +                               clock-names = "sata23clk";

> +                       };
> +
> +                       sata45clk: sata45clk at 1f23c000 {
> +                               compatible = "apm,xgene-device-clock";
> +                               #clock-cells = <1>;
> +                               clocks = <&socplldiv2 0>;
> +                               clock-names = "sata45clk";

Something is wrong here: You have two devices with the same "compatible"
string but using different "clock-names" strings. The binding document
lists this as an optional property with the description  "shall be
the name of the device clock. If missing, use the device name", which
doesn't seem to make any sense.

Please fix the binding and the existing users of this, and don't introduce
any more broken instances. Since each device clock is documented to
have only one parent anyway, please just make it an anonymous clock.

	Arnd
