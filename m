From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 02 Aug 2017 15:11:43 +0200
Subject: [PATCH] arm64: defconfig: enable fine-grained task level IRQ time
 accounting
In-Reply-To: <1501532531-4499-1-git-send-email-mw@semihalf.com> (Marcin
 Wojtas's message of "Mon, 31 Jul 2017 22:22:11 +0200")
References: <1501532531-4499-1-git-send-email-mw@semihalf.com>
Message-ID: <87y3r29ks0.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

(Adding Arnd and Olof)
 
 On lun., juil. 31 2017, Marcin Wojtas <mw@semihalf.com> wrote:

> Tests showed, that under certain conditions, the summary number of jiffies
> spent on softirq/idle, which are counted by system statistics can be even
> below 10% of expected value, resulting in false load presentation.
>
> The issue was observed on the quad-core Marvell Armada 8k SoC, whose two
> 10G ports were bound into L2 bridge. Load was controlled by bidirectional
> UDP traffic, produced by a packet generator. Under such condition,
> the dominant load is softirq. With 100% single CPU occupation or without
> any activity (all CPUs 100% idle), total number of jiffies is 10000 (2500
> per each core) in 10s interval. Also with other kind of load this was
> true.
>
> However below a saturation threshold it was observed, that with CPU which
> was occupied almost by softirqs only, the statistic were awkward. See
> the mpstat output:
>
> CPU %usr %nice %sys %iowait %irq %soft %steal %guest %gnice %idle
> all 0.00  0.00 0.13    0.00 0.00  0.55   0.00   0.00   0.00 99.32
>   0 0.00  0.00 0.00    0.00 0.00 23.08   0.00   0.00   0.00 76.92
>   1 0.00  0.00 0.40    0.00 0.00  0.00   0.00   0.00   0.00 99.60
>   2 0.00  0.00 0.00    0.00 0.00  0.00   0.00   0.00   0.00 100.00
>   3 0.00  0.00 0.00    0.00 0.00  0.00   0.00   0.00   0.00 100.00
>
> Above would mean basically no total load, debug CPU0 occupied in 25%.
> Raw statistics, printed every 10s from /proc/stat unveiled a root
> cause - summary idle/softirq jiffies on loaded CPU were below 200,
> i.e. over 90% samples lost. All problems were gone after enabling
> fine granulity IRQ time accounting.
>
> This patch fixes possible wrong statistics processing by enabling
> CONFIG_IRQ_TIME_ACCOUNTING for arm64 platfroms, which is by
> default done on other architectures, e.g. x86 and arm. Tests
> showed no noticeable performance penalty, nor stability impact.

Who should take this patch?

I think that all the defconfig under arm64 are merged through the
arm-soc subsystem, but this one is not really specific to a
SoC. However, as it was experimented on an mvebu SoC, if you agree I can
take it.

Thanks,

Gregory

>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 44423e6..ed51ac6 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -3,6 +3,7 @@ CONFIG_POSIX_MQUEUE=y
>  CONFIG_AUDIT=y
>  CONFIG_NO_HZ_IDLE=y
>  CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_IRQ_TIME_ACCOUNTING=y
>  CONFIG_BSD_PROCESS_ACCT=y
>  CONFIG_BSD_PROCESS_ACCT_V3=y
>  CONFIG_TASKSTATS=y
> -- 
> 1.8.3.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
