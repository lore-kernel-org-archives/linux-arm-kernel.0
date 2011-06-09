From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Jun 2011 17:50:29 +0100
Subject: [RFC PATCH v4] ARM hibernation/suspend-to-disk support
In-Reply-To: <alpine.DEB.2.00.1106071722040.2236@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106071722040.2236@localhost6.localdomain6>
Message-ID: <20110609165029.GC24424@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2011 at 05:48:17PM +0100, Frank Hofmann wrote:
> There are a few dependencies this patch brings in:
>
> * due to the use of cpu_suspend / cpu_resume, it'll only apply as-is
>   to kernels no older than f6b0fa02e8b0708d17d631afce456524eadf87ff,
>   where Russell King introduced the generic interface.
>   Patching these into older kernels is a little work.
>
> * it temporarily uses swapper_pg_dir and establishes 1:1 mappings there
>   for a MMU-off transition, which is necessary before resume.
>   In order to tear these down afterwards, identity_mapping_del() needs
>   to be called; for some reason that's #ifdef CONFIG_SMP ...
>
> * it needs to "catch" sleep_save_sp after cpu_suspend() so that resume
>   can be provided with the proper starting point.
>   This requires an ENTRY(sleep_save_sp) in arch/arm/kernel/sleep.S so
>   that the symbol becomes public.
>
> * it assumes cpu_reset will disable the MMU. cpu_v6_reset/cpu_v7_reset
>   are currently not doing so (amongst some other minor chip types).
>
> * there's kind of a circular dependency between CONFIG_HIBERNATION and
>   CONFIG_PM_SLEEP, on ARM. The latter is necessary so that cpu_suspend
>   and cpu_resume are compiled in, but it cannot be selected via
>   ARCH_HIBERNATION_POSSIBLE because CONFIG_PM_SLEEP depends on
>   CONFIG_HIBERNATION_INTERFACE - selected by CONFIG_HIBERNATION.

Another issue is that it uses PHYS_OFFSET in assembly code which is not
permissible with P2V patching.
