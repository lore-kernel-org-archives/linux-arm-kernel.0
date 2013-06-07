From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 07 Jun 2013 10:57:41 -0600
Subject: [PATCH 3/3] clk: tegra: T114: add DFLL DVCO reset control
In-Reply-To: <20130607121901.21868.65416.stgit@dusk.lan>
References: <20130607121505.21868.72360.stgit@dusk.lan>
 <20130607121901.21868.65416.stgit@dusk.lan>
Message-ID: <51B21105.1080301@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2013 06:19 AM, Paul Walmsley wrote:
> Add DFLL DVCO reset line control functions to the CAR IP block driver.
> 
> The DVCO present in the DFLL IP block has a separate reset line,
> exposed via the CAR IP block.  This reset line is asserted upon SoC
> reset.  Unless something (such as the DFLL driver) deasserts this
> line, the DVCO will not oscillate, although reads and writes to the
> DFLL IP block will complete.
> 
> Thanks to Aleksandr Frid <afrid@nvidia.com> for identifying this and
> saving hours of debugging time.

> diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h

>  void tegra114_clock_tune_cpu_trimmers_high(void);
>  void tegra114_clock_tune_cpu_trimmers_low(void);
>  void tegra114_clock_tune_cpu_trimmers_init(void);
> +void tegra114_clock_assert_dfll_dvco_reset(void);
> +void tegra114_clock_deassert_dfll_dvco_reset(void);

Where/what is the code that will call these new APIs? If it's going to
be something in drivers/clk, that seems fine. If not, then this seems to
be inventing a bunch of new custom APIs exported by the clock driver.
I'm not sure if that's a good idea. (Although I guess that
include/linux/clk/tegra.h has a bunch of other custom APIs to support
CPU hotplug and related functionality, so perhaps it's not a big deael).

The reset assert/de-assert functions at least might be worth exposing
using the new generic module reset API. I believe Prashant Gaikwad is
working on converting the Tegra clock driver to be a module reset
provider, hence removing the existing custom
tegra_periph_reset_{de,}assert() APIs.
