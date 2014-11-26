From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Nov 2014 13:12:10 +0000
Subject: [PATCH 3.18-rc3 v9 5/5] arm: smp: Handle ipi_cpu_backtrace()
 using FIQ (if available)
In-Reply-To: <2744845.J3XUj2a9bM@dabox>
References: <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>
 <1416936401-5147-1-git-send-email-daniel.thompson@linaro.org>
 <1416936401-5147-6-git-send-email-daniel.thompson@linaro.org>
 <2744845.J3XUj2a9bM@dabox>
Message-ID: <20141126131210.GI3836@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 01:46:52PM +0100, Tim Sander wrote:
> Hi Daniel
> 
> Am Dienstag, 25. November 2014, 17:26:41 schrieb Daniel Thompson:
> > Previous changes have introduced both a replacement default FIQ handler
> > and an implementation of arch_trigger_all_cpu_backtrace for ARM but
> > these are currently independent of each other.
> > 
> > This patch plumbs together these features making it possible, on platforms
> > that support it, to trigger backtrace using FIQ.
> Does this ipi handler interfere in any way with set_fiq_handler?
> 
> As far as i know there is only one FIQ handler vector so i guess there is a 
> potential conflict. But i have not worked with IPI's so i might be completley
> wrong.

First, the code in arch/arm/kernel/fiq.c should work with this new FIQ
code in that the new FIQ code is used as the "default" handler (as
opposed to the original handler which was a total no-op.)

Secondly, use of arch/arm/kernel/fiq.c in a SMP system is really not a
good idea: the FIQ registers are private to each CPU in the system, and
there is no infrastructure to allow fiq.c to ensure that it loads the
right CPU with the register information for the provided handler.

So, use of arch/arm/kernel/fiq.c and the IPI's use of FIQ /should/ be
mutually exclusive.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
