From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Nov 2014 10:08:28 +0000
Subject: [PATCH 3.18-rc3 v9 5/5] arm: smp: Handle ipi_cpu_backtrace()
 using FIQ (if available)
In-Reply-To: <13373554.4deCsZOMXS@dabox>
References: <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>
 <20141126131210.GI3836@n2100.arm.linux.org.uk>
 <5475FD02.3030501@linaro.org> <13373554.4deCsZOMXS@dabox>
Message-ID: <20141128100828.GQ3836@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 10:10:04AM +0100, Tim Sander wrote:
> Hi Daniel, Russell
> 
> Am Mittwoch, 26. November 2014, 16:17:06 schrieb Daniel Thompson:
> > On 26/11/14 13:12, Russell King - ARM Linux wrote:
> > > On Wed, Nov 26, 2014 at 01:46:52PM +0100, Tim Sander wrote:
> > >> Hi Daniel
> > >> 
> > >> Am Dienstag, 25. November 2014, 17:26:41 schrieb Daniel Thompson:
> > >>> Previous changes have introduced both a replacement default FIQ handler
> > >>> and an implementation of arch_trigger_all_cpu_backtrace for ARM but
> > >>> these are currently independent of each other.
> > >>> 
> > >>> This patch plumbs together these features making it possible, on
> > >>> platforms
> > >>> that support it, to trigger backtrace using FIQ.
> > >> 
> > >> Does this ipi handler interfere in any way with set_fiq_handler?
> > >> 
> > >> As far as i know there is only one FIQ handler vector so i guess there is
> > >> a
> > >> potential conflict. But i have not worked with IPI's so i might be
> > >> completley wrong.
> > > 
> > > First, the code in arch/arm/kernel/fiq.c should work with this new FIQ
> > > code in that the new FIQ code is used as the "default" handler (as
> > > opposed to the original handler which was a total no-op.)
> > > 
> > > Secondly, use of arch/arm/kernel/fiq.c in a SMP system is really not a
> > > good idea: the FIQ registers are private to each CPU in the system, and
> > > there is no infrastructure to allow fiq.c to ensure that it loads the
> > > right CPU with the register information for the provided handler.
> Well given the races in the GIC v1. i have seen in the chips on my desk 
> initializing with for_each_possible_cpu(cpu) work_on_cpu(cpu,..) is rather 
> easy.
> > > So, use of arch/arm/kernel/fiq.c and the IPI's use of FIQ /should/ be
> > > mutually exclusive.
> Yes but i digress on the assessment that this a decision between SMP and non-
> SMP usage or the availbility of the GIC.

The two things are mutually exclusive.  You can either have FIQ being used
for debug purposes, where we decode the FIQ reason and call some function
(which means that we will only service one FIQ at a time) or you can use
it in exclusive mode (provided by fiq.c) where your handler has sole usage
of the vector, and benefits from fast and immediate servicing of the event.

You can't have fast and immediate servicing of the event _and_ debug usage
at the same time.

> Well i am not against these features as they assumably improve the backtrace,
> but it would be nice to have a config option which switches between 
> set_fiq_handler usage and the other conflicting usages of the fiq.

You have a config option already.  CONFIG_FIQ.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
