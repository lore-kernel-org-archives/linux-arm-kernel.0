From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Jan 2015 22:17:53 +0100
Subject: [RFC PATCH v3 3/4] arm64:thunder: Add initial dts for Cavium's
 Thunder SoC in 2 Node topology.
In-Reply-To: <1420011208-7051-4-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
References: <1420011208-7051-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1420011208-7051-4-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
Message-ID: <1741288.B6kbjm5Uq5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 31 December 2014 13:03:27 Ganapatrao Kulkarni wrote:
> +
> +	memory at 00000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x00000000 0x0 0x80000000>;
> +		/* board 0, socket 0, no specific core */
> +		arm,associativity = <0 0 0xffff>;
> +	};
> +
> +	memory at 10000000000 {
> +		device_type = "memory";
> +		reg = <0x100 0x00000000 0x0 0x80000000>;
> +		/* board 1, socket 0, no specific core */
> +		arm,associativity = <1 0 0xffff>;
> +	};
> +};

So no memory in any other socket?

> +		cpu at 00f {
> +			device_type = "cpu";
> +			compatible = "cavium,thunder", "arm,armv8";
> +			reg = <0x0 0x00f>;
> +			enable-method = "psci";
> +			arm,associativity = <0 0 0x00f>;
> +		};
> +		cpu at 100 {
> +			device_type = "cpu";
> +			compatible = "cavium,thunder", "arm,armv8";
> +			reg = <0x0 0x100>;
> +			enable-method = "psci";
> +			arm,associativity = <0 0 0x100>;
> +		};

What is the 0x100 offset in the last-level topology field? Does this have
no significance to topology at all? I would expect that to be something
like cluster number that is relevant to caching and should be represented
as a separate level.

In contrast, the level-two topology information seems to always be
zero for all CPUs, so you could probably leave that one out.

> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;

The soc node is missing a topology information, please add one.

	Arnd
