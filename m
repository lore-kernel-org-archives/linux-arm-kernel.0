From: will.deacon@arm.com (Will Deacon)
Date: Sun, 23 Dec 2012 11:25:40 +0000
Subject: [PATCH 2/2] ARM: tegra: moving the clock gating procedure to
 tegra_cpu_kill
In-Reply-To: <50D4D345.6030804@wwwdotorg.org>
References: <1355970519-28200-1-git-send-email-josephl@nvidia.com>
 <1355970519-28200-2-git-send-email-josephl@nvidia.com>
 <50D34467.9000006@wwwdotorg.org>
 <1356083897.26029.187.camel@jlo-ubuntu-64.nvidia.com>
 <50D4D345.6030804@wwwdotorg.org>
Message-ID: <20121223112540.GF16237@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 21, 2012 at 09:23:17PM +0000, Stephen Warren wrote:
> On 12/21/2012 02:58 AM, Joseph Lo wrote:
> > About the kexec issue, it's complicate. Your solution should be the
> > right solution. And we should implement the hardware shutdown code in
> > cpu_die not cpu_kill. I suspect this issue can be reproduced on all ARM
> > platform. Because the smp_send_stop can't really shutdown the secondary
> > CPU core if just call machine_shutdown without disable_nonboot_cpu. And
> > in platform_shutdown and platform_reboot case, the secondary CPU already
> > been offlined and killed before this function be called. Does any other
> > ARM SMP platform can run kexec without any issue?
> > 
> > (I will check if we can do some HW shutdown in tegra_cpu_kill. For ex,
> > just clock gate the CPU without wait_for_reset.)
> 
> Will, Joseph's thoughts above pretty much match mine re: kexec. In the
> kexec thread I started earlier, I talked about replacing:
> 
> void machine_shutdown(void)
> {
> #ifdef CONFIG_SMP
> 	smp_send_stop();
> #endif
> }
> 
> with something like:
> 
> void machine_shutdown(void)
> {
> #ifdef CONFIG_HOTPLUG_CPU
>  	disable_nonboot_cpus();
> #elifdef CONFIG_SMP
> 	smp_send_stop();
> #endif
> }
> 
> and you'd responded "I think you're better off using what we currently
> have and hanging your code off platform_cpu_kill.".

Sorry for being vague: I just meant that the code as it stands in mainline
is better than calling disable_nonboot_cpus(), because the latter seems to
require all the secondary cores to hit the idle loop, notice that they are
not online, and then call cpu_die. We really need this sequence to be
synchronous wrt the CPU initiating the kexec.

> What exactly did you mean by "what we currently have"; did you mean that
> cpu_kill() should work without cpu_die() having executed on the target
> CPU itself first, so Tegra should simply implement cpu_kill()? As Joseph
> says above, I'm not sure that will work. Any more detailed thoughts you
> have here would be greatly appreciated. Thanks.

I guess this comes down to the different between cpu_die/cpu_kill and
whether you actually need cpu_die if you're not planning on returning to
the same kernel that you left. If you really need to call cpu_die, then we
need to figure out a way to do that whilst ensuring that only one CPU is
left standing at the time we start copying the new kernel into place.

Will
