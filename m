From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jun 2013 20:41:00 +0100
Subject: [PATCH V2 2/2] ARM: decouple CPU offlining from reboot/shutdown
In-Reply-To: <51BF5C6D.9050806@wwwdotorg.org>
References: <1371067281-655-1-git-send-email-swarren@wwwdotorg.org>
 <1371067281-655-2-git-send-email-swarren@wwwdotorg.org>
 <51BF5C6D.9050806@wwwdotorg.org>
Message-ID: <20130617194100.GS2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 12:58:53PM -0600, Stephen Warren wrote:
> On 06/12/2013 02:01 PM, Stephen Warren wrote:
> > From: Stephen Warren <swarren@nvidia.com>
> > 
> > Add comments to machine_shutdown()/halt()/power_off()/restart() that
> > describe their purpose and/or requirements re: CPUs being active/not.
> > 
> > In machine_shutdown(), replace the call to smp_send_stop() with a call to
> > disable_nonboot_cpus(). This completely disables all but one CPU, thus
> > satisfying the requirement that only a single CPU be active for kexec.
> > Adjust Kconfig dependencies for this change.
> > 
> > In machine_halt()/power_off()/restart(), call smp_send_stop() directly,
> > rather than via machine_shutdown(); these functions don't need to
> > completely de-activate all CPUs using hotplug, but rather just quiesce
> > them.
> > 
> > Remove smp_kill_cpus(), and its call from smp_send_stop().
> > smp_kill_cpus() was indirectly calling smp_ops.cpu_kill() without calling
> > smp_ops.cpu_die() on the target CPUs first. At least some implementations
> > of smp_ops had issues with this; it caused cpu_kill() to hang on Tegra,
> > for example. Since smp_send_stop() is only used for shutdown, halt, and
> > power-off, there is no need to attempt any kind of CPU hotplug here.
> > 
> > Adjust Kconfig to reflect that machine_shutdown() (and hence kexec)
> > relies upon disable_nonboot_cpus(). However, this alone doesn't guarantee
> > that hotplug will work, or even that hotplug is implemented for a
> > particular piece of HW that a multi-platform zImage runs on. Hence, add
> > error-checking to machine_kexec() to determine whether it did work.
> 
> Russell,
> 
> The patch which initially triggered the problem [shutdown/reboot hangs
> on Tegra] (cf7df37 "reboot: rigrate shutdown/reboot to boot cpu") ended
> up going into v3.10; I assumed it was only going into v3.11.
> 
> Is it possible to take this patch for v3.10 rather than v3.11? (or is
> your git-curr branch for 3.10; that's where your patchd told me this was
> applied.)

The concern I have is that we're now at -rc6, and my "fixes" branch for
this time around is getting much larger than previous ones:

 5 files changed, 14 insertions(+), 11 deletions(-)

 3 files changed, 2 insertions(+), 3 deletions(-)

 7 files changed, 45 insertions(+), 5 deletions(-)

and it's currently looking like:

 7 files changed, 61 insertions(+), 9 deletions(-)

yes, not huge, but it's the wrong direction - and consider I've dropped
one thing from fixes this morning because they were actually broken...
and you're asking me to include this:

 4 files changed, 42 insertions(+), 20 deletions(-)

into that, which'll make it:

11 files changed, 103 insertions(+), 29 deletions(-)

and it really starts to look like things are heading in the wrong
direction... especially as far as Linus would be concerned for -rc6...

I will try though. :)
