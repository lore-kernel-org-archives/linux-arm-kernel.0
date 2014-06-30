From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 30 Jun 2014 14:57:08 +0200
Subject: [PATCH 06/16] ARM: mvebu: Rename the armada_370_xp into
 mvebu_v7 in pmsu.c file
In-Reply-To: <1403875377-940-7-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
 <1403875377-940-7-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140630145708.528110bd@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Fri, 27 Jun 2014 15:22:47 +0200, Gregory CLEMENT wrote:
> Actually most of the function related to the PMSU are not specific to
> the Armada 370 or Armada XP SoCs, but can also be used for most of the
> other mvebu ARMv7 SoCs.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/pmsu.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)

I'm fine on the principle, but this badly conflicts with the PMSU
changes I've made to support CPU hotplug, which are already in
linux-next. See
http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/log/arch/arm/mach-mvebu/pmsu.c.

>  /* No locking is needed because we only access per-CPU registers */
> -void armada_370_xp_pmsu_idle_prepare(bool deepidle)
> +static void mvebu_v7_pmsu_idle_prepare(bool deepidle)

Also, note here that you're not only renaming, but also adding the
'static' qualifier. This is already done in linux-next by
http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/arch/arm/mach-mvebu/pmsu.c?id=adb1d99384c7480886153a97d2ea22e9c0d2e053,
but the function is anyway renamed in
http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/arch/arm/mach-mvebu/pmsu.c?id=bbb92284b6c821e9434223d437fbd10b8a24c294
as a preparation for CPU hotplug support.

> -static noinline int do_armada_370_xp_cpu_suspend(unsigned long deepidle)
> +static noinline int do_armada_xp_370_cpu_suspend(unsigned long deepidle)

This does not seem like a rename to mvebu_v7.

>  {
> -	armada_370_xp_pmsu_idle_prepare(deepidle);
> +	mvebu_v7_pmsu_idle_prepare(deepidle);
>  
>  	v7_exit_coherency_flush(all);
>  
> @@ -248,13 +248,13 @@ static noinline int do_armada_370_xp_cpu_suspend(unsigned long deepidle)
>  	return 0;
>  }
>  
> -static int armada_370_xp_cpu_suspend(unsigned long deepidle)
> +static int armada_xp_370_cpu_suspend(unsigned long deepidle)

Ditto.

>  {
> -	return cpu_suspend(deepidle, do_armada_370_xp_cpu_suspend);
> +	return cpu_suspend(deepidle, do_armada_xp_370_cpu_suspend);

Ditto.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
