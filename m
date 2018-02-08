From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 8 Feb 2018 08:59:30 -0700
Subject: [PATCH] coresight replicator: set default y after Kconfig rename
In-Reply-To: <20180207150351.ce930e929bc0d7f6cfb1aa56@arm.com>
References: <20180207150351.ce930e929bc0d7f6cfb1aa56@arm.com>
Message-ID: <CANLsYkwMUG9pwcMH9UdLWVqS9pzJCOFJa5Y0Y1NX0SqznUdx+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 February 2018 at 14:03, Kim Phillips <kim.phillips@arm.com> wrote:
> Commit 1c8859848dbb ("coresight replicator: Cleanup programmable
> replicator naming") changed the Kconfig symbol name from
> QCOM_REPLICATOR, which, whilst not in the single arm64 defconfig,
> was being set in my juno build script, which left the new symbol unset,
> causing the following unexpected grief:
>
>  # ./perf record -vvv -C 0 -e cs_etm/@20070000.etr/ --per-thread true
>  ..<snip>..
>  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>  mmap size 528384B
>  AUX area mmap length 4194304
>  perf event ring buffer mmapped per cpu
>  failed to mmap AUX area
>  failed to mmap with 12 (Cannot allocate memory)
>
> Make it default y to help not surprise unsuspecting users.
>
> Fixes: 1c8859848dbb ("coresight replicator: Cleanup programmable replicator naming")
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
>  drivers/hwtracing/coresight/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index ef9cb3c164e1..b94bbd95efa6 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -73,6 +73,7 @@ config CORESIGHT_SOURCE_ETM4X
>  config CORESIGHT_DYNAMIC_REPLICATOR
>         bool "CoreSight Programmable Replicator driver"
>         depends on CORESIGHT_LINKS_AND_SINKS
> +       default y
>         help
>           This enables support for dynamic CoreSight replicator link driver.
>           The programmable ATB replicator allows independent filtering of the

As I said before don't see why it needs to be treated differently than other CS
blocks - intelligent replicators show up on the AMBA bus and need to
be declared in the DT.  As such people are expected to enable the proper
option.

Mathieu

> --
> 2.16.1
>
