From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Sep 2015 10:22:39 +0200
Subject: cpufreq: mediatek: allow modular build
In-Reply-To: <20150911081753.GK9650@linux>
References: <1768766.yu1lxjsjLL@wuerfel> <20150911081753.GK9650@linux>
Message-ID: <2329563.MhTbBXHVz1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 September 2015 13:47:53 Viresh Kumar wrote:
> On 11-09-15, 10:15, Arnd Bergmann wrote:
> > The newly merged cpufreq-mt8173 driver breaks the ARM allmodconfig
> > build because of a dependency on the cpu-cooling infrastructure that
> > may be built as a loadable module:
> > 
> > drivers/built-in.o: In function `mtk_cpufreq_ready':
> > binder.c:(.text+0x324c8c): undefined reference to `of_cpufreq_cooling_register'
> > drivers/built-in.o: In function `mtk_cpufreq_exit':
> > binder.c:(.text+0x324ea0): undefined reference to `cpufreq_cooling_unregister'
> > 
> > This works around the issue by allowing this driver to be built
> > as a module as well, and adding a dependency on THERMAL that prevents
> > it from being built-in when the cpu-cooling driver is a module.
> > 
> > This is not perfect because there is still a case where THERMAL=m
> > and CPU_COOLING=n that should allow us to have this driver built-in
> > as well, but I decided to follow existing practice in other drivers
> > here, and that case seems irrelevant in practice.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > I have not checked if someone else has already sent a patch for this,
> > just ignore mine if the issue has been fixed already.
> 
> 5269e7067cd6 ("cpufreq: Add ARM_MT8173_CPUFREQ dependency on THERMAL")
> 
> in Rafael's tree. Its a bit different, so have a look.

That fix looks correct to me too, thanks for the quick reply!

In my approach, I decided to allow the driver to be a module, as that
seems nicer for multi_v7_defconfig, but I now see that there are
several other drivers that can only be built-in, so if we decided to
make that the general strategy we should change them all.

	Arnd
