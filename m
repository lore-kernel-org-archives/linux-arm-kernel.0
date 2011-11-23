From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 23 Nov 2011 08:50:16 -0800
Subject: [PATCH 03/17] arm/dt: Tegra: Enable audio on WM8903 boards,
 disable others
In-Reply-To: <1322011285-4002-4-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
 <1322011285-4002-4-git-send-email-swarren@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174F08C6C3@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote at Tuesday, November 22, 2011 6:21 PM:
> Add complete bindings to instantiate and configure the codec and
> top-level audio complex on all currently supported boards using the
> Tegra+WM8903 audio driver.
...
> diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
...
> +	sound {
> +		compatible = "nvidia,tegra-audio-wm8903-harmony",
> +                             "nvidia,tegra-audio-wm8903";

Thinking about that more, I'd like to change this from nvidia,tegra-audio*
to nvidia,tegra20-audio*. That's because the current ASoC machine driver,
which is what matches that compatible flag, is slightly Tegra20-specific
because it makes calls to the Tegra20-specific DAS driver. On Tegra30, this
is replaced by a Tegra30 (and later?) AHUB driver. To avoid the
Tegra+WM8903 ASoC machine driver module depending on both the Tegra20 DAS
module and the Tegra30 AHUB module, I'd like to create separate ASoC
machine drivers for the two Tegra chips, which parameterize a core machine
driver (e.g. by passing an ops/vtable). This requires versioned compatible
flags so that different drivers can be instantiated.

-- 
nvpublic
