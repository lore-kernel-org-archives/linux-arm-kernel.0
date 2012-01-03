From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 03 Jan 2012 15:54:16 +0100
Subject: [RFC PATCH 0/8] Add common ARM cpuidle init code
In-Reply-To: <201112081537.04789.arnd.bergmann@linaro.org>
References: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
 <20111208145653.GF7913@S2100-06.ap.freescale.net>
 <201112081537.04789.arnd.bergmann@linaro.org>
Message-ID: <4F031698.4010501@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/2011 04:37 PM, Arnd Bergmann wrote:
> On Thursday 08 December 2011, Shawn Guo wrote:
>>>
>> With many drivers are being moved into drivers/* from arch/arm/mach-*
>> and arch/arm/plat-*, I'm wondering if we have any problem with doing
>> the same thing on cpuidle.  If we can move these cpuidle drivers into
>> drivers/cpuidle (or drivers/idle, I'm not sure why two folders), that
>> will be the best place for such consolidation to me.
>>
>> Cc-ed linux-pm and Len Brown for helping understand.
>
> I think we should definitely move them into one of the two directories.
> The one thing making this a bit nasty is that many SoC implementation
> need to access some global registers for this and don't have a "device"
> that can be used for cpuidle with its own register ranges, but it's
> still better to have the code in a single place IMHO.

Yes, I agree. Moreover that will facilitate to factor out the code which 
is spread all around the different architecture.

The places where there is the drivers cpuidle code are at drivers/idle, 
driver/acpi, arch/arm, arch/sh/kernel/cpu/mobile/cpuidle, etc ...

IMHO, before doing some code factoring out, we should move all these 
drivers to the cpuidle directory, no ?

drivers/idle/intel_idle.c => drivers/cpuidle/intel.c
drivers/acpi/processor_idle.c => drivers/cpuidle/acpi.c

arch/arm/mach-omap2/cpuidle34xx.c => drivers/cpuidle/omap-34xx.c
arch/arm/mach-omap2/cpuidle44xx.c => drivers/cpuidle/omap-44xx.c
arch/arm/mach-shmobile/cpuidle.c  => drivers/cpuidle/arm-shmobile.c
arch/arm/mach-davinci/cpuidle.c => drivers/cpuidle/davinci.c
arch/arm/mach-at91/cpuidle.c => drivers/cpuidle/at91.c
arch/arm/mach-s3c64xx/cpuidle.c => drivers/cpuidle/s3c64xx.c
arch/arm/mach-exynos/cpuidle.c => drivers/cpuidle/exynos.c
arch/arm/mach-kirkwood/cpuidle.c => drivers/cpuidle/kirkwood.c
arch/arcm/mach-msm/idle.S => drivers/cpuidle/msm.S

That could be a first step and then we move the other archs which could 
be a bit more tricky like the powerpc.

Does it make sense ?

Thanks
   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
