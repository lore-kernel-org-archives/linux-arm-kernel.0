From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Jan 2013 12:02:59 +0000
Subject: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
In-Reply-To: <50E4C9C6.20609@codeaurora.org>
References: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
 <50E4C9C6.20609@codeaurora.org>
Message-ID: <20130103120259.GB5193@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 02, 2013 at 11:59:02PM +0000, Stephen Boyd wrote:
> On 01/02/13 13:07, Stephen Warren wrote:
> > From: Stephen Warren <swarren@nvidia.com>
> >
> > On Tegra at least, this change allows kexec to work with SMP enabled.
> > Without this,  machine_shutdown() simply puts all CPUs into a loop. If
> > the code of that loop is over-written, the CPUs may hang or crash (which
> > I do observe in practice), or cause the kexec'd kernel not to be able to
> > initialize them.
> >
> > This fix has the added benefit that the kexec always happens on the boot
> > CPU, and thus kexec mirrors the initial kernel boot as much as possible.
> >
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > ---
> > Russell, I assume this should go into the ARM patch tracker if OK?
> >
> >  arch/arm/kernel/process.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> > index f79dd1e..1893bda 100644
> > --- a/arch/arm/kernel/process.c
> > +++ b/arch/arm/kernel/process.c
> > @@ -239,6 +239,7 @@ __setup("reboot=", reboot_setup);
> >  
> >  void machine_shutdown(void)
> >  {
> > +	disable_nonboot_cpus();
> >  #ifdef CONFIG_SMP
> >  	smp_send_stop();
> >  #endif
> 
> How does this work in a CONFIG_SUSPEND=n build? It looks like
> disable_nonboot_cpus() would be a no-op and so we wouldn't actually hot
> unplug the other CPUs before sending the smp_send_stop(). And then the
> smp_send_stop() seems a little unnecessary if we do actually shutdown
> the other CPUs.

You need the smp_send_stop call in order to send the cpu_kill (looks like
tegra needs die and then kill). So you really need hotplug support as well
as suspend for this to do much (if not, the secondaries end up spinning
with interrupts disabled which is probably the best we can do anyway).

We could add SUSPEND as a KEXEC dependency if SMP (we already have HOTPLUG
there) if you like?

Will
