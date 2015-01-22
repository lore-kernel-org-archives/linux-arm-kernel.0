From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Jan 2015 17:47:13 +0100
Subject: [RFC PATCH v4 3/4] arm64:thunder: Add initial dts for Cavium's
 Thunder SoC in 2 Node topology.
In-Reply-To: <1421924755-26029-4-git-send-email-gkulkarni@caviumnetworks.com>
References: <1421924755-26029-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1421924755-26029-4-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <2882934.brFyhkGPyE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 January 2015 16:35:54 Ganapatrao Kulkarni wrote:
> +
> +		cpu at 000 {
> +			device_type = "cpu";
> +			compatible = "cavium,thunder", "arm,armv8";
> +			reg = <0x0 0x000>;
> +			enable-method = "psci";
> +			/* socket 0, cluster 0, core 0*/
> +			arm,associativity = <0 0 0>;
> +		};
...
> +             cpu at 20f {
> +                     device_type = "cpu";
> +                     compatible = "cavium,thunder", "arm,armv8";
> +                     reg = <0x0 0x20f>;
> +                     enable-method = "psci";
> +                     arm,associativity = <0 2 15>;
> +		};
> +		cpu at 10000 {
> +			device_type = "cpu";
> +			compatible = "cavium,thunder", "arm,armv8";
> +			reg = <0x0 0x10000>;
> +			enable-method = "psci";
> +			/* socket 1, cluster 0, core 0*/
> +			arm,associativity = <1 0 0>;
> +		};

This seems wrong still: The clusters and cores do not have unique
numbers. I believe the code will not work correctly, and it won't
be compliant with the binding from patch 2.

I think the right way here would be to use 

	arm,associativity = <0 2 47>;

for cpu at 20f, and

	arm,associativity = <1 3 48>;

for cpu at 10000. Your previous version used the numbers from 
the reg property, which should be fine as well if that helps:


	arm,associativity = <0x0 0x200 0x20f>;

	arm,associativity = <0x10000 0x10000 0x10000>;

which should have the same effect as above, as long as the code
can handle the numbers not being consecutive.

	Arnd
