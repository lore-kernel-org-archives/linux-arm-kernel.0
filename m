From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Oct 2014 15:16:10 +0000
Subject: [PATCH v2 00/20] rtc: omap: fixes and power-off feature
In-Reply-To: <20141028131257.GS2006@localhost>
References: <20141024192540.GD11455@saruman> <20141024192948.GE11455@saruman>
 <20141024193655.GD19377@localhost> <20141024194442.GG11455@saruman>
 <20141024195532.GF19377@localhost>
 <20141027162251.d7ff2a5f31917c638d4e47f7@linux-foundation.org>
 <20141028002552.GX12379@n2100.arm.linux.org.uk>
 <20141028081616.GL2006@localhost>
 <20141028084745.GY12379@n2100.arm.linux.org.uk>
 <20141028131257.GS2006@localhost>
Message-ID: <20141028151610.GA12379@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 02:12:57PM +0100, Johan Hovold wrote:
> That's not what I was trying to refer to. But the patch set explicitly
> allows for multiple, prioritised power-off handlers, which can power
> off a board in different ways and with various degrees of success.
> Specifically, it allows for fallback handlers in case one or more
> power-off handlers fail.
> 
> So if we allow for that, what is to prevent the final power-off handler
> from failing? And should this not be logged by arch code in the same way
> as failure to restart is?

And how is that different from having a set of power-off handlers, and
reporting when each individual one fails?  Don't you want to know if
your primary high priority reboot handler fails, just as much as you
want to know if your final last-resort power-off handler fails?

Or different from having no power-off handlers.

Here's the x86 code:

void machine_power_off(void)
{
        machine_ops.power_off();
}

struct machine_ops machine_ops = {
        .power_off = native_machine_power_off,
...

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

See - x86 can very well just fall straight back out of machine_power_off()
if there's no pm_power_off() hook and tboot is not enabled.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
