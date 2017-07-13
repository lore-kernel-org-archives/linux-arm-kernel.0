From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jul 2017 14:16:26 +0100
Subject: [PATCH v3 4/6] ARM: meson: Add SMP bringup code for Meson8 and
 Meson8b
In-Reply-To: <20170713103113.21560-5-martin.blumenstingl@googlemail.com>
References: <20170713103113.21560-1-martin.blumenstingl@googlemail.com>
 <20170713103113.21560-5-martin.blumenstingl@googlemail.com>
Message-ID: <20170713131625.GC31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 12:31:11PM +0200, Martin Blumenstingl wrote:
> +static DEFINE_SPINLOCK(boot_lock);
> +
> +/*
> + * Write pen_release in a way that is guaranteed to be visible to all
> + * observers, irrespective of whether they're taking part in coherency
> + * or not.  This is necessary for the hotplug code to work reliably.
> + */
> +static void write_pen_release(int val)
> +{
> +	pen_release = val;
> +	smp_wmb();
> +	sync_cache_w(&pen_release);
> +}

Hi Martin,

This looks like a classic case of cargo-cult copying of the early ARM
Ltd Realview SMP code, and people really need to understand that is
not a good implementation to copy.  The Realview platforms are very
limited in what they can do: there's no power control of the CPU cores,
and there's no individual reset.  These platforms are evaluation
platforms for the CPUs, where the CPUs themselves are often "test chips".
They are not production systems.

The only way to control the cores on these platforms is via software
loops such as the holding pen and loops in the hotplug code, since the
CPUs always have to be executing some code somewhere.  There are other
issues too which required the boot_lock (to ensure local timer
calibration worked.)

None of these issues apply to production SMP platforms, so you likely do
not need any of this - and I see from your code that you do have power
and reset controls for the CPUs.  What I'm basically saying here is:
please rip out the holding pen and boot_lock code from your SMP
implementation.

If you do need it, please include a detailed explanation why it's
required - requiring it suggests that the hardware is broken, and
probably doesn't support hotplug and therefore does not support suspend/
resume.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
