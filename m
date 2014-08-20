From: grant.likely@linaro.org (Grant Likely)
Date: Wed, 20 Aug 2014 11:42:27 -0500
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <1406206825-15590-20-git-send-email-hanjun.guo@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-20-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140820164227.E0F4BC41204@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Jul 2014 21:00:25 +0800, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> +Clocks
> +------
> +
> +Like clocks that are part of the power resources there is no standard way
> +to represent a clock tree in ACPI 5.1 in a similar manner to how it is
> +described in DT.
> +
> +Devices affected by this include things like UARTs, SoC driven LCD displays,
> +etc.
> +
> +The firmware for example UEFI should initialise these clocks to fixed working
> +values before the kernel is executed. If a driver requires to know rates of
> +clocks set by firmware then they can be passed to kernel using _DSD.
> +
> +example :-
> +
> +Device (CLK0) {
> +	...
> +
> +	Name (_DSD, Package() {
> +		ToUUID("XXXXX"),
> +		Package() {
> +			Package(2) {"#clock-cells", 0},
> +			Package(2) {"clock-frequency", "10000"}
> +		}
> +	})
> +
> +	...
> +}
> +
> +Device (USR1) {
> +	...
> +
> +	Name (_DSD, Package() {
> +		ToUUID("XXXXX"),
> +		Package() {
> +			Package(2) {"clocks", Package() {1, ^CLK0}}},
> +		}
> +	})
> +
> +	...
> +}

Really? This looks wrong. The above example goes right back to
conceptually putting the clock tree into ACPI. I would expect the ACPI
way to expose current clock rate to an individual device driver is to
expose a clock rate method that internally knows how to return the
currently set rate.

g.
