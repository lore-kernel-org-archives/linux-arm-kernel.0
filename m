From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Sep 2010 22:21:01 +0100
Subject: [PATCH 2/2] ARM: S5PV310: Update CPU hotplug implementation
In-Reply-To: <AANLkTinaGsnZg-nTGvXS4xw-_8e8+pLpL4hYN-HMNYfh@mail.gmail.com>
References: <1284700388-9394-1-git-send-email-kgene.kim@samsung.com>
	<1284700388-9394-3-git-send-email-kgene.kim@samsung.com>
	<001901cb5fcd$a0a5b5a0$e1f120e0$%kim@samsung.com>
	<AANLkTinaGsnZg-nTGvXS4xw-_8e8+pLpL4hYN-HMNYfh@mail.gmail.com>
Message-ID: <20100930212101.GC11660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 30, 2010 at 10:02:37AM -0700, Colin Cross wrote:
> On Wed, Sep 29, 2010 at 4:58 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Kukjin Kim wrote:
> >>
> >> From: Changhwan Youn <chaos.youn@samsung.com>
> >>
> >> This patch updates CPU hotplug implementation to reduce CPU power
> >> consumption
> >> and will turn off the CPU power when CPU1 is unplugged while previous CPU
> >> hotplug
> >> used CPU idle.
> >> This patch removes init memory freeing code to use CPU boot code when CPU1
> > is
> >> plugged-in again and adds vfp_enable() call to allow to access CP10 and
> > CP11.
> >>
> >> Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> >> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> >> Cc: Russell King <rmk@arm.linux.org.uk>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Colin Cross <ccross@android.com>
> > Cc: Erik Gilling <konkers@android.com>
> > Cc: Olof Johansson <olof@lixom.net>
> >
> 
> snip
> 
> >> +#ifndef CONFIG_HOTPLUG_CPU
> >> ? ? ? if (!machine_is_integrator() && !machine_is_cintegrator())
> >> ? ? ? ? ? ? ? totalram_pages +=
> > free_area(__phys_to_pfn(__pa(__init_begin)),
> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? __phys_to_pfn(__pa(__init_end)),
> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "init");
> >> +#endif
> >> ?}
> >>
> >> ?#ifdef CONFIG_BLK_DEV_INITRD
> 
> I don't think this is necessary.  Any symbol that is necessary for CPU
> hotplug should be marked with __cpuinit instead of __init.  The linker
> script will put __cpuinit symbols outside the __init_begin -
> __init_end section if CONFIG_HOTPLUG_CPU is enabled.

That's the theory, but not everything required for a complete restart of
a secondary CPU (iow, if it's powered off) is in the right section yet.
I'll have patches hopefully tomorrow to address this.
