From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Mar 2014 00:51:15 +0000
Subject: [PATCH] ARM: machine_power_off should not return
In-Reply-To: <20140325224554.GC12185@arch.cereza>
References: <1395684784-12601-1-git-send-email-sebastian.capella@linaro.org>
 <20140325224554.GC12185@arch.cereza>
Message-ID: <20140326005115.GW7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 25, 2014 at 07:45:55PM -0300, Ezequiel Garcia wrote:
> Let's Cc: LAKML, and To: Russell.
> 
> Russell, any comments on this?
> 
> Without this patch we got the heartbeat's reboot_notifier called twice while
> testing the recent hibernation patches, which was unexpected and produced a
> kernel panic: https://lkml.org/lkml/2014/3/19/363

I don't see why we should make this change.  kernel/reboot.c handles
this function returning, so other places should do too.

Even on x86, this function can return:

void machine_power_off(void)
{
        machine_ops.power_off();
}

        .power_off = native_machine_power_off,

static void native_machine_power_off(void)
{
        if (pm_power_off) {
                if (!reboot_force)
                        machine_shutdown();
                pm_power_off();
        }
        /* A fallback in case there is no PM info available */
        tboot_shutdown(TB_SHUTDOWN_HALT);
}

void tboot_shutdown(u32 shutdown_type)
{
        void (*shutdown)(void);

        if (!tboot_enabled())
                return;

Therefore, I'd say... it's a bug in the hibernation code - or we probably
have many buggy architectures.  I'd suggest fixing the hibernation code
rather than stuffing some workaround like an endless loop into every
architecture.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
