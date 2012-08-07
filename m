From: khilman@ti.com (Kevin Hilman)
Date: Tue, 07 Aug 2012 16:26:21 -0700
Subject: [linux-pm] [PATCH 4/4] PM: cleanup: stop mandating that platforms
 export (pm_idle)()
In-Reply-To: <0753050fb227e5a19f0df303d1e9bf74534aabcd.1343428708.git.len.brown@intel.com>
 (Len Brown's message of "Fri, 27 Jul 2012 18:42:55 -0400")
References: <1343428975-3897-1-git-send-email-lenb@kernel.org>
 <06ed885aac76cc68bd1ca1f32c8dcab7bcca1940.1343428708.git.len.brown@intel.com>
 <0753050fb227e5a19f0df303d1e9bf74534aabcd.1343428708.git.len.brown@intel.com>
Message-ID: <878vdqz3ky.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ linux-arm-kernel

Len Brown <lenb@kernel.org> writes:

> From: Len Brown <len.brown@intel.com>
>
> (pm_idle)() was originally used on x86 to vector bewteen
> ACPI and APM.  With the advent of CPU_IDLE, that reason
> for pm_idle to exist vanished.
>
> But x86 APM still scribbled on pm_idle from a module,
> so pm_idle didn't go away.  Worse, it was declared in pm.h,
> and so it spread to other architectures as dead code.
>
> But today, APM no longer scribbles on pm_idle, so
> x86 no longer requires pm_idle to be visible to modules,
> or global at all.
>
> Here we remove pm_idle from pm.h, to stop the mandate
> that all architectures define it.
>
> This deletes dead code from most architectures,
> while some continue using their own internal pm_idle.
>
> At the end of the day, pm_idle...
> becomes static in sh, was global
> becomes static in x86, was EXPORT_SYMBOL
> becomes as global in sparc, was EXPORT_SYMBOL
> continues as static in m32r (no pm.h use there)
> and is deleted from all other places in the kernel.
>
> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: x86 at kernel.org # x86
> Cc: Mike Frysinger <vapier@gentoo.org> # blackfin
> Cc: Jonas Bonn <jonas@southpole.se> # openrisc
> Cc: Tony Luck <tony.luck@intel.com> # ia64
> Cc: David Howells <dhowells@redhat.com> # mn10300
> Cc: Mikael Starvik <starvik@axis.com> # cris
> Cc: Michal Simek <monstr@monstr.eu> # microblaze
> Cc: Paul Mundt <lethal@linux-sh.org> # sh
> Cc: David S. Miller <davem@davemloft.net> # sparc
> Cc: Russell King <linux@arm.linux.org.uk> # ARM
> Cc: Rafael J. Wysocki <rjw@sisk.pl> # PM
> ---
>  arch/arm/kernel/process.c         | 12 +++---------

Just looking at the ARM changes, it looks good to me.  I tested it with
and without CPUidle on my ARM-based TI/OMAP platforms (3430/n900,
4430/Panda)

So for the arch/arm changes:

Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Kevin Hilman <khilman@ti.com>

Kevin
