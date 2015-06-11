From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Jun 2015 10:24:23 +0100
Subject: i.MX6 cpufreq : rcu_sched kthread starved
In-Reply-To: <CAH-u=80WPfFmb4e3F=_mz1W-f3=sz2cY7D92USOCKCwcp5Es2w@mail.gmail.com>
References: <CAH-u=80WPfFmb4e3F=_mz1W-f3=sz2cY7D92USOCKCwcp5Es2w@mail.gmail.com>
Message-ID: <20150611092422.GU7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 10:48:31AM +0200, Jean-Michel Hautbois wrote:
> [  388.902571] INFO: rcu_sched detected stalls on CPUs/tasks: { 1}
> (detected by 0, t=2102 jiffies, g=7088, c=7087, q=34)
> [  388.913334] Task dump for CPU 1:
> [  388.916588] irq/298-IC PP   R running      0    46      2 0x00000002
> [  388.923016] Backtrace:
> [  388.925541] [<8000cbc0>] (vfp_double_ftoui) from [<807fd2c8>]
> (schedule+0x4c/0xa4)

This does not look very good.  If vfp_double_ftoui really is being called
from this path, then that means you're trying to use VFP inside the
kernel, and that's not permitted.

> [  392.127701] CPU: 0 PID: 25 Comm: kworker/0:1 Tainted: G    B    C
>    4.0.5 #49

This also tells me that your kernel has thrown a bad_page() exception,
and you have modules from drivers/staging loaded - so it's possible
that the problem you're seeing here is caused by either an unstable
staging module, or whatever caused the bad_page() exception.

Always investigate the first error first...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
