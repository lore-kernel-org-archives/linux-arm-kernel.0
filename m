From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 12 Dec 2015 03:26:57 +0100
Subject: [PATCH] cpufreq: tegra: add regulator dependency for T124
In-Reply-To: <2194927.eV2s2QmZs0@wuerfel>
References: <2194927.eV2s2QmZs0@wuerfel>
Message-ID: <1834718.KShzbrV9CD@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, December 08, 2015 10:52:45 PM Arnd Bergmann wrote:
> This driver is the only one that calls regulator_sync_voltage(), but it
> can currently be built with CONFIG_REGULATOR disabled, producing
> this build error:
> 
> drivers/cpufreq/tegra124-cpufreq.c: In function 'tegra124_cpu_switch_to_pllx':
> drivers/cpufreq/tegra124-cpufreq.c:68:2: error: implicit declaration of function 'regulator_sync_voltage' [-Werror=implicit-function-declaration]
>   regulator_sync_voltage(priv->vdd_cpu_reg);
> 
> My first attempt was to implement a helper for this function
> for regulator_sync_voltage, but Mark Brown explained:
> 
>    We don't do this for *all* regulator API functions - there's some where
>    using them strongly suggests that there is actually a dependency on
>    the regulator API.  This does seem like it might be falling into the
>    specialist category [...]
>    Looking at the code I'm pretty unclear on what the authors think the
>    use of _sync_voltage() is doing in the first place so it may be even
>    better to just remove the call.  It seems to have been included in the
>    first commit so there's not changelog explaining things and there's
>    no comment either.  I'd *expect* it to be a noop as far as I can see.
> 
> This adds the dependency to make the driver always build successfully
> or not be enabled at all. Alternatively, we could investigate if the
> driver should stop calling regulator_sync_voltage instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!

Rafael
