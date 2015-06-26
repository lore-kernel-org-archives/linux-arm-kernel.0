From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 26 Jun 2015 17:59:29 +0100
Subject: [PATCH] keystone: psci: adds cpu_die implementation
In-Reply-To: <558D8492.2090503@ti.com>
References: <1435240970-30869-1-git-send-email-vitalya@ti.com>
 <20150625144511.GA6844@leverpostej> <558C174F.80108@oracle.com>
 <558C25E0.3010102@ti.com> <20150625161308.GF6844@leverpostej>
 <558C328C.5070803@ti.com> <20150625165741.GA10564@leverpostej>
 <20150625172057.GA11952@leverpostej> <558C4B84.9030303@oracle.com>
 <558D8492.2090503@ti.com>
Message-ID: <20150626165929.GB31602@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> OK. Now I'm confused :) We may have several different configurations here:
> 
> 1) CONFIG_HOTPLUG_CPU and CONFIG_ARM_PSCI are not set.
>     In this case keystone arch needs to have
>     keystone_smp_boot_secondary();
> 
> 2) CONFIG_HOTPLUG_CPU=y and CONFIG_ARM_PSCI is not set.
>     keystone_smp_boot_secondary() is required and non PSCI
>     implementation of keystone_cpu_die() is also required.
> 
> 3) CONFIG_HOTPLUG_CPU is not set and CONFIG_ARM_PSCI=y
> 4) CONFIG_HOTPLUG_CPU=y and CONFIG_ARM_PSCI=y
> 
>     How do I boot secondary CPUs in cases of 3 and 4?
>     Do I need to implement PSCI version of the
>     keystone_smp_boot_secondary() of adding PSCI commands to DTB is
>     enough?

The DTB additions alone _should_ be sufficient.

>     Do I need to implement keystone_cpu_die() if PSCI commands are
>     added to DTB?

You _should not_ need to add any platform code to use PSCI.

However, if you have existing platform code which pokes the hardware
logically owned by your FW PSCI implementation, you need to ensure that
this code doesn't poke that hardware when PSCI is in use.

Thanks,
Mark.
