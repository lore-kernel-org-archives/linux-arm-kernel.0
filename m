From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 11 Apr 2012 15:38:37 -0600 (MDT)
Subject: [PATCH 02/12] arm: omap3: Only sleep during cpu_idle if I/O
 wake-ups work
In-Reply-To: <1334171147-7517-3-git-send-email-mgreer@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-3-git-send-email-mgreer@animalcreek.com>
Message-ID: <alpine.DEB.2.00.1204111538110.29473@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Apr 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> Currently in the OMAP3 code, cpu_idle() calls pm_idle(),
> which is a function pointer set to omap3_pm_idle()).
> omap3_pm_idle() calls omap_sram_idle() which eventually
> causes a 'wfi' instruction to be executed effectively
> putting the system to sleep.  It is assumed that an
> I/O wake-up event will occur to wake the system up again.
> This doesn't work on systems that don't support I/O wake-ups
> (indicated by omap3_has_io_wakeup() returning false).
> 
> Leaving pm_idle() pointing to default_idle() won't work
> either because the cpu_<processor>_do_idle() routine which
> is eventually called may also execute a 'wfi' instruction
> (e.g., cpu_v7_do_idle()).
> 
> To handle this, leave pm_idle() pointing to omap3_pm_idle()
> but add a check in omap3_pm_idle() so it avoids calling
> omap_sram_idle() when I/O wake-ups aren't supported.
> 
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

Same basic comments here as with your "arm: omap3: Only sleep in cpuidle 
driver if I/O wake-ups work" patch.


- Paul
