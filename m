From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 05 Mar 2013 11:54:31 -0700
Subject: [PATCH 05/10] ARM: dt: tegra: add bindings of power management
 configurations for PMC
In-Reply-To: <1362397241-5786-1-git-send-email-josephl@nvidia.com>
References: <1362397241-5786-1-git-send-email-josephl@nvidia.com>
Message-ID: <51363F67.8040200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2013 04:40 AM, Joseph Lo wrote:
> The PMC mostly controls the entry and exit of the system from different
> sleep modes. Different platform or system may have different configurations.
> The power management configurations of PMC is represented as some properties.
> The system needs to define the properties when the system supports deep sleep
> mode (i.e. suspend).

One overall question here: For LP0, the idea is that the bootloader
provides the AVP boot code, puts it in RAM, passes the address to the
kernel, which then arranges for that code to be executed when the system
resumes from LP0. Why does the bootloader have to provide the code? Why
can't the AVP code simply be part of the kernel, just like e.g. the main
CPU's hotplug/secondary-power-on/power-saving reset vector is part of
the kernel? If we did that, it'd remove any need for bootloader support
for LP0 - the kernel would manage it entirely internally. That seems
much simpler.

> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt

> +Optional properties:
...
> +  2 (LP2): CPU voltage off

I would create a new section here, with title something like:

Required properties when nvidia,suspend-mode is specified:

> +- nvidia,cpu-pwr-good-time : CPU power good time in uS. If not present, the
> +  suspend function will be disabled as default.

Then, for many of these properties, you can remove the text "If not
present, the suspend function will be disabled as default.", since it's
implicit given that these properties are required.

> +Required properties when nvidia,suspend-mode=<0>:
> +- nvidia,lp0-vec : <start length> Starting address and length of LP0 vector
...
> +  bring up CPU0 for resuming the system. If the suspend mode is LP0, then
> +  this property is must to have.

Again, you can remove "If the suspend mode is LP0, then this property is
must to have.", since the property is already in a section named
"Required properties ...".
