From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 29 May 2015 16:00:41 -0700
Subject: [PATCH v8 0/7] arm64,hi6220: Enable Hisilicon Hi6220 SoC
In-Reply-To: <1432865319-20413-1-git-send-email-bintian.wang@huawei.com>
 (Bintian Wang's message of "Fri, 29 May 2015 10:08:32 +0800")
References: <1432865319-20413-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <7hwpzrdm5i.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bintian,

Bintian Wang <bintian.wang@huawei.com> writes:

> From: Bintian Wang <wangbintian@gmail.com>
>
> Hi6220 is one mobile solution of Hisilicon, this patchset contains
> initial support for Hi6220 SoC and HiKey development board, which
> supports octal ARM Cortex A53 cores. Initial support is minimal and
> includes just the arch configuration, clock driver, device tree
> configuration.
>
> PSCI is enabled in device tree and there is no problem to boot all the
> octal cores, and the CPU hotplug is also working now, you can download
> and compile the latest firmware based on the following link to run this
> patch set:
> https://github.com/96boards/documentation/wiki/UEFI
>
> Changes v6~v8:
> This three versions only modified the clock drivers based on the
> Stephen's review advices.
> * clk-hi6220.c:
>   ** Split the clock header file from clock driver
>   ** Delete setting the parents clock of UART1 to HI6220_150M in clock
>      driver, we can do that using assigned-clock in dts when enable
>      UART1 in the future.
> * clkdivider-hi6220.c: 
>   ** Reuse some functions exported by clk-divider.c
>   ** Remove "pr_err" and CLK_IS_BASIC flag
>   ** Fix some programing style problems
> * hisilicon/clk.h: remove the "__init" markings on some funcition
>   prototypes.

It's not clear what kernel this series is meant to apply to.  It doesn't
apply cleanly to v4.1-rc2 (the version stated for v5) or the current -rc
(v4.1-rc5) it also doesn't apply cleanly to linus/master or linux-next.

If the series doesn't apply to Linus tree, please state clearly in the
changelog what tree it should apply to as well as any dependncies.

Also, this version is missing patch 1 from the v6 series, which adds the
Kconfig/defconfig changes. Without that patch, nothing in this series is
even compiled (clk driver or DTS files.)

So my recommendation, since the clock driver is very close to being
merged:

Please create a v9 series with *only* the patches that are not already
queued up on the clk tree[1].  That should be patches 1-3 and 7 of this
series, plus patch 1 from v6.

That series should apply cleanly to v4.1-rc1 (or a newer -rc if there
are dependencies.)  In the changelog to that series, state the version
that it applies to, and also state that it depends on the clk-next
branch where the clock maintainers have queued up the driver[1].

Then all that's left is to collect an ack from a DT maintainer, and
these can be queued up via the arm-soc tree.

FWIW, I've boot tested patches 1-3 and 7 of this series, plus patch 1
from v6 combined with the clk-next-hi6220 branch[1] on my board (which
uses ATF + mainline u-boot) and all 8 A53 cores are coming up, so feel
free to add:

Tested-by: Kevin Hilman <khilman@linaro.org>

to your v9 series.

Thanks,

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next-hi6220
