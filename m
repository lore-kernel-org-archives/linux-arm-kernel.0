From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 17 Jul 2013 11:01:30 -0600
Subject: [PATCH] ASoC: tegra: depend on ARCH_TEGRA, not ARCH_TEGRA_*
In-Reply-To: <20130717083003.GA22506@sirena.org.uk>
References: <1374013667-21435-1-git-send-email-swarren@wwwdotorg.org>
 <20130717083003.GA22506@sirena.org.uk>
Message-ID: <51E6CDEA.7060003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2013 02:30 AM, Mark Brown wrote:
> On Tue, Jul 16, 2013 at 04:27:47PM -0600, Stephen Warren wrote:
> 
>> Stop selecting I2S/AC97/SPDIF controller drivers from the machine
>> driver config options; this doesn't really work if we don't know
>> which specific SoC(s) we're building for. However, set their
>> default values based on SND_SOC_TEGRA, since most people will
>> probably want to enable support for all SoCs. This also avoids
>> the need to change any defconfig files.
> 
> This doesn't seem terribly clever and is definitely not idiomatic
> for ASoC.  If you want to just select all CPUs that'd be fine but
> forcing the user to select the individual components isn't the
> style anything else uses.

So I think what you're saying is that machine drivers should be
changed like:

-       select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC
-       select SND_SOC_TEGRA30_I2S if ARCH_TEGRA_3x_SOC
+       select SND_SOC_TEGRA20_I2S
+       select SND_SOC_TEGRA30_I2S

But then, it won't be possible to disable support for older SoCs,
since simply enabling a machine driver that might support Tegra20
would force ASoC support for Tegra20 to be enabled, even if the user
only cares about Tegra30.
