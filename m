From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 13 Aug 2014 12:31:11 -0400 (EDT)
Subject: [PATCH v7 3/8] drivers: cpuidle: implement DT based idle states
 infrastructure
In-Reply-To: <1407945127-27554-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-4-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <alpine.LFD.2.11.1408131223501.1133@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Aug 2014, Lorenzo Pieralisi wrote:

> On most common ARM systems, the low-power states a CPU can be put into are
> not discoverable in HW and require device tree bindings to describe
> power down suspend operations and idle states parameters.
> 
> In order to enable DT based idle states and configure idle drivers, this
> patch implements the bulk infrastructure required to parse the device tree
> idle states bindings and initialize the corresponding CPUidle driver states
> data.
> 
> The parsing API accepts a start index that defines the first idle state
> that should be initialized by the parsing code in order to give new and
> legacy driver flexibility over which states should be parsed using the
> new DT mechanism.
> 
> The idle states list is obtained from the first cpu in the driver
> cpumask, which implicitly means the parsing code expects idle states
> (and related list of phandles) to be the same for all CPUs in the
> CPUidle driver mask. The kernel does not check this assumption, it must
> be enforced by the bootloader to ensure correct system behaviour.

Can we make the kernel a little less reliant on bootloader to ensure 
correct system behaviour please?  If assumptions are assumed by the 
kernel, it should at least print a warning and simply ignore the 
information when such assumption are not respected.

> +	/*
> +	 * We get the idle states for the first logical cpu in the
> +	 * driver mask. The kernel does not check idle states on all
> +	 * cpus in the driver mask, they are assumed to be the same
> +	 * by default.
> +	 */

What if they're not?


Nicolas
