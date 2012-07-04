From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Jul 2012 10:50:53 +0100
Subject: [PATCH] ARM: reboot: disable nonboot CPUs
In-Reply-To: <1341388262-3801-1-git-send-email-per.forlin@stericsson.com>
References: <1341388262-3801-1-git-send-email-per.forlin@stericsson.com>
Message-ID: <20120704095053.GJ16319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2012 at 09:51:02AM +0200, Per Forlin wrote:
> Disable the nonboot CPUs to safely migrate tasks and interrupts
> to the boot CPU. This will prevent the nonboot CPUs to
> interfer or block the boot CPU from being able to reboot
> the system successfully.
> 
> This reboot issue was detected on u8500 when using ab8500 to initaite a
> system restart. The issue happens because smp_send_stop() stops the CPUs
> wihouth migrating all resources.
> If not issuing smp_send_stop() u8500 reboots successfully.
> 
> It's optional to support CONFIG_PM_SLEEP_SMP therefore smp_send_stop()
> can't simply be replaced by disable_nonboot_cpus()

I don't understand what or why you're trying to do this, it seems to be
unreliable to rely upon conditional sleep support to make system reboot
to work.

Yes, we know at the moment that smp_send_stop() results in the secondary
CPUs ending up spinning in the kernel, which is then potentially replaced
buy whatever happens after boot, but short of creating a new per-subarch
function, I don't see much other alternative.

Doesn't your kernel restart trigger a system hardware reset in any case?
That's about the only reliable way to do a system restart with SMP.
