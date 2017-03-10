From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Mar 2017 23:43:25 +0000
Subject: [BUG] v4.11-rc1: CPUFREQ Circular locking dependency
In-Reply-To: <BY2PR21MB00361C512E03B09DBCE715D3CB200@BY2PR21MB0036.namprd21.prod.outlook.com>
References: <20170310150218.GW21222@n2100.armlinux.org.uk>
 <CAJZ5v0jGRH_hwvvm9OLsaYgbghqWKOke9PyGNnkvP_ZiMqAxSw@mail.gmail.com>
 <BY2PR21MB00362E60448FD2E00C120FFCCB200@BY2PR21MB0036.namprd21.prod.outlook.com>
 <BY2PR21MB00361C512E03B09DBCE715D3CB200@BY2PR21MB0036.namprd21.prod.outlook.com>
Message-ID: <20170310234325.GB21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 06:33:28PM +0000, Matthew Wilcox wrote:
> From cd5401d81633d5e48e39d67d4e65156e6759537e Mon Sep 17 00:00:00 2001
> From: Matthew Wilcox <mawilcox@microsoft.com>
> Date: Fri, 10 Mar 2017 13:22:53 -0500
> Subject: [PATCH] thermal: Fix potential deadlock in cpu_cooling
> 
> I expanded the scope of cooling_list_lock a little too far; it was
> not just covering cpufreq_dev_count, it was also covering the calls
> to cpufreq_register_notifier() and cpufreq_unregister_notifier().
> Since cooling_list_lock is also used within cpufreq_thermal_notifier(),
> lockdep reports a potential deadlock.  I don't think that's actually
> possible, but it's easy enough to make it impossible by testing the
> condition under cooling_list_lock and dropping the lock before calling
> cpufreq_register_notifier().
> 
> As a bonus, I noticed that cpufreq_dev_count is only used for the purpose
> of knowing whether this is the first or last cooling device registered,
> and we know that anyway because we know whether the list transitioned
> between empty and not-empty.  So we can delete that variable too.
> 
> Fixes: ae606089621ef0349402cfcbeca33a82abbd0fd0
> Reported-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

Thanks Matthew, appears to solve the problem.

Tested-by: Russell King <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
