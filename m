From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Nov 2009 14:51:10 +0000
Subject: ARM926 Software reset problems
In-Reply-To: <8EBD063210E546E0BD6C80E8EF3AAD6B@teltronic.es>
References: <B3925569A02247AFA3847BB80F9342EF@teltronic.es>
	<20091113122045.GA29008@n2100.arm.linux.org.uk>
	<8EBD063210E546E0BD6C80E8EF3AAD6B@teltronic.es>
Message-ID: <20091113145110.GA31012@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2009 at 03:41:17PM +0100, Ricardo Mart?nez wrote:
> I'm one step further. kernel_restart() uses arch_reset() which is hardware
> dependent.

kernel_restart() is not hardware dependent.  The backend of it (arch_reset)
is because platforms reboot in their own specific manner.  It is up to the
platform support implementer to make arch_reset() do the right thing on
their platform.

However, none of cpu_*reset nor arch_reset are intended to be called
directly.  You _MUST_ call kernel_restart() to initiate a restart.  No
other option will do - everything else is not supported and unreliable.

> Most ARM9 make arch_reset() through Watchdog peripheral. But the CPU I'm
> using does not have Watchdog timer.

So why are you trying to make arch_reset() work through a non-existent
watchdog?

Just point arch_reset() at cpu_reset() like this:

static void arch_reset(char mode, const char *cmd)
{
	cpu_reset(0);
}

as many other platforms do, and just call kernel_restart().
