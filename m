From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 12 Jan 2015 15:26:39 +0100
Subject: [PATCH 0/4] mmc: core: Add support for MMC power sequences
In-Reply-To: <1420215248-20650-1-git-send-email-ulf.hansson@linaro.org>
References: <1420215248-20650-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAAObsKDXTwmXQ_oviSv4jyvaVepgsw8g5VJNpt1X=JCzfpTYuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 January 2015 at 17:14, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> This is yet another try to solve the issues of dealing with power sequences for
> the MMC subsystem. The latest attempt, see link below, took a generic approach
> by adding a new top level driver layer. That's was rejected by several reasons.
> http://lwn.net/Articles/602855/
>
> This time the approach is focused to fix the issues for MMC only.
>
> To give a short background, SOCs may specify a specific MMC power sequence. To
> successfully detect an (e)MMC/SD/SDIO card, that power sequence must be followed
> while initializing the card.

Hi Ulf,

have used this to successfully init a mwifiex_sdio card but had to
also add a delay while the reset line is asserted. May make sense to
add a property to the pwrseq node to specify the minimum amount of
time that the reset GPIO needs to be asserted?

Tested-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Thanks,

Tomeu

> To be able to handle these SOC specific power sequences, we add a MMC power
> sequence interface, which helps the mmc core to deal with such.
>
> A MMC power sequence provider then implements a set of callbacks from the above
> mentioned interface. The provider has a corresponding DT compatibility string
> and relies on CONFIG_OF to be set to find it's various resourses, like for
> example a GPIO reset.
>
> The mmc core will from mmc_of_parse() try find a "mmc-pwrseq" DT node and then
> call the corresponding MMC power sequence provider's initialization function.
>
>
> Ulf Hansson (4):
>   mmc: core: Initial support for MMC power sequences
>   mmc: pwrseq: Document DT bindings for the simple MMC power sequence
>   mmc: pwrseq: Initial support for the simple MMC power sequence
>     provider
>   mmc: pwrseq_simple: Add support for a reset GPIO pin
>
>  .../devicetree/bindings/mmc/mmc,pwrseq-simple.txt  |  23 +++++
>  Documentation/devicetree/bindings/mmc/mmc.txt      |   5 +
>  drivers/mmc/core/Makefile                          |   2 +-
>  drivers/mmc/core/core.c                            |   7 ++
>  drivers/mmc/core/host.c                            |   4 +-
>  drivers/mmc/core/pwrseq.c                          | 109 +++++++++++++++++++++
>  drivers/mmc/core/pwrseq.h                          |  42 ++++++++
>  drivers/mmc/core/pwrseq_simple.c                   |  86 ++++++++++++++++
>  include/linux/mmc/host.h                           |   2 +
>  9 files changed, 278 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
>  create mode 100644 drivers/mmc/core/pwrseq.c
>  create mode 100644 drivers/mmc/core/pwrseq.h
>  create mode 100644 drivers/mmc/core/pwrseq_simple.c
>
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
