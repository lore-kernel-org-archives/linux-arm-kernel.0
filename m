From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 22 Jan 2014 16:37:10 +0100
Subject: [PATCH RESEND] cpufreq: exynos: Fix build error of no type of
 module_init
In-Reply-To: <1390402760.18340.6.camel@AMDC1943>
References: <1390400476-22951-1-git-send-email-k.kozlowski@samsung.com>
 <CAKohpo=2wR+Sqwxj4koH0rvuk29BkNyAZgN0RR7bVH+3uqpB1Q@mail.gmail.com>
 <1390402760.18340.6.camel@AMDC1943>
Message-ID: <1390405030.18340.11.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> 
> On Wed, 2014-01-22 at 20:12 +0530, Viresh Kumar wrote:
> > On 22 January 2014 19:51, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> > > Add missing include to fix build error:
> > > drivers/cpufreq/exynos-cpufreq.c:292:1: warning: data definition has no type or storage class [enabled by default]
> > > drivers/cpufreq/exynos-cpufreq.c:292:1: error: type defaults to ?int? in declaration of ?module_init? [-Werror=implicit-int]
> > > drivers/cpufreq/exynos-cpufreq.c:292:1: warning: parameter names (without types) in function declaration [enabled by default]
> > > drivers/cpufreq/exynos-cpufreq.c:292:1: warning: data definition has no type or storage class [enabled by default]
> > > drivers/cpufreq/exynos-cpufreq.c:292:1: error: type defaults to ?int? in declaration of ?module_exit? [-Werror=implicit-int]
> > > drivers/cpufreq/exynos-cpufreq.c:292:1: warning: parameter names (without types) in function declaration [enabled by default]
> > > drivers/cpufreq/exynos-cpufreq.c:292:1: warning: ?exynos_cpufreq_platdrv_init? defined but not used [-Wunused-function]
> > > cc1: some warnings being treated as errors
> > > make[2]: *** [drivers/cpufreq/exynos-cpufreq.o] Error 1
> > > make[1]: *** [drivers/cpufreq] Error 2
> > >
> > > Build error happens on gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5)
> > > and was introduced by commit d568b6f71df1 (cpufreq: exynos: Convert
> > > exynos-cpufreq to platform driver).
> > >
> > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > > Cc: Lukasz Majewski <l.majewski@samsung.com>
> > > Cc: Tomasz Figa <t.figa@samsung.com>
> > > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > > ---
> > >  drivers/cpufreq/exynos-cpufreq.c |    1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
> > > index fcd2914d081a..fa54c2b88dd7 100644
> > > --- a/drivers/cpufreq/exynos-cpufreq.c
> > > +++ b/drivers/cpufreq/exynos-cpufreq.c
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/regulator/consumer.h>
> > >  #include <linux/cpufreq.h>
> > >  #include <linux/suspend.h>
> > > +#include <linux/module.h>
> > >  #include <linux/platform_device.h>
> > 
> > I am surprised how that patch went through then? And nothing was
> > reported by kbuild for it..
> 
> Hi,
> 
> A little more explanation from my side: the build error actually happens
> only on next/master, not Linus' tree.
> 
> Mentioned commit which changes the driver to platform driver is in
> mainline since 3.12-rc2 so it seems this is not the cause of the build
> error. I think I need to find first the real cause of this build error.
> 
> Best regards,
> Krzysztof

After bisecting, the real commit for build error is:
caa7dcde7c424cdc81698a6e4e48072eb67ec67e
    module: relocate module_init from init.h to module.h

My patch seems valid although the reason in commit msg should be updated:
################
Add missing include to fix build error:
drivers/cpufreq/exynos-cpufreq.c:292:1: warning: data definition has no type or storage class [enabled by default]
drivers/cpufreq/exynos-cpufreq.c:292:1: error: type defaults to ?int? in declaration of ?module_init? [-Werror=implicit-int]
drivers/cpufreq/exynos-cpufreq.c:292:1: warning: parameter names (without types) in function declaration [enabled by default]
drivers/cpufreq/exynos-cpufreq.c:292:1: warning: data definition has no type or storage class [enabled by default]
drivers/cpufreq/exynos-cpufreq.c:292:1: error: type defaults to ?int? in declaration of ?module_exit? [-Werror=implicit-int]
drivers/cpufreq/exynos-cpufreq.c:292:1: warning: parameter names (without types) in function declaration [enabled by default]
drivers/cpufreq/exynos-cpufreq.c:292:1: warning: ?exynos_cpufreq_platdrv_init? defined but not used [-Wunused-function]
cc1: some warnings being treated as errors
make[2]: *** [drivers/cpufreq/exynos-cpufreq.o] Error 1
make[1]: *** [drivers/cpufreq] Error 2

Build error happens on gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5)
and was introduced in next tree by commit caa7dcde7c42 (module: relocate
module_init from init.h to module.h).
################
