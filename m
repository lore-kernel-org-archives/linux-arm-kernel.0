From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Oct 2016 08:18:27 +0000
Subject: [PATCH 1/2] ARM: oxnas: Add OX820 SMP support
In-Reply-To: <9124cda0-d16b-0992-2552-8a617aeb5d40@baylibre.com>
References: <20161017084303.20078-1-narmstrong@baylibre.com>
 <20161017084303.20078-2-narmstrong@baylibre.com>
 <14513531.isB50DxNJf@wuerfel>
 <9124cda0-d16b-0992-2552-8a617aeb5d40@baylibre.com>
Message-ID: <20161031081827.GQ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 11:34:32AM +0200, Neil Armstrong wrote:
> On 10/17/2016 11:06 AM, Arnd Bergmann wrote:
> > On Monday, October 17, 2016 10:43:02 AM CEST Neil Armstrong wrote:
> > This seems to have been copied from plat-versatile, but is really
> > not needed here since you apparently have proper hardware support for
> > starting up the CPUs.
> Yes it seems.
> 
> > 
> > Any reason you can't just write to the cpu_ctrl register
> > once and keep going without that whole holding_pen loop
> > and spinlock?
> I suppose but I did not find any good examples except the plat-versatile code.
> I will try some simpler code.

There's plenty of examples - most ARM SMP platforms in the kernel now
do not blindly copy the versatile code.  You only have to go looking
for arch/arm/*/platsmp.c files to find them.

I'm not sure what you'd call a "good example" - maybe the imx code?
arch/arm/mach-imx/platsmp.c can't be simpler:

static int imx_boot_secondary(unsigned int cpu, struct task_struct *idle)
{
        imx_set_cpu_jump(cpu, v7_secondary_startup);
        imx_enable_cpu(cpu, true);
        return 0;
}

I guess the difficult thing is to understand what each of those called
functions does... though the function names give a very accurate clue
there.

and because plat-versatile is almost entirely software-based, it's
easy to understand and follow, _despite_ being completely broken
for things like PM and kexec (which, the platform does not support.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
