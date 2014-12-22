From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Dec 2014 09:17:45 -0700
Subject: [PATCH] ARM: tegra: Use PMC scratch register 40 for tegra_resume()
 location store
In-Reply-To: <1419202392-1159-1-git-send-email-digetx@gmail.com>
References: <1419202392-1159-1-git-send-email-digetx@gmail.com>
Message-ID: <54984429.8040905@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/21/2014 03:52 PM, Dmitry Osipenko wrote:
> Commit 7232398abc6a ("ARM: tegra: Convert PMC to a driver") changed tegra_resume()
> location storing from late to early and as result broke suspend on tegra20.
> PMC scratch register 41 was used by tegra lp1 suspend core code for storing
> physical memory address of common resume function and in the same time used by
> tegra20 cpuidle driver for storing cpu1 "resettable" status, so it implied
> strict order of scratch register use. Fix it by using scratch 40 instead of 41
> for tegra_resume() location store.

You likely can't simply change the PMC scratch register usage 
arbitrarily; specific registers are designated for specific purposes, 
and code outside the Linux kernel (bootloaders, LP0 resume code, secure 
monitors, etc.) may depend on those specific values being in those 
registers. Without significant research, I'd suggest not changing the 
PMC scratch register usage.
