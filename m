From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jun 2013 18:10:29 +0100
Subject: [PATCH V2 2/2] ARM: decouple CPU offlining from reboot/shutdown
In-Reply-To: <20130613074551.GA7769@mudshark.cambridge.arm.com>
References: <1371067281-655-1-git-send-email-swarren@wwwdotorg.org>
 <1371067281-655-2-git-send-email-swarren@wwwdotorg.org>
 <20130613074551.GA7769@mudshark.cambridge.arm.com>
Message-ID: <20130613171029.GG18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 08:45:51AM +0100, Will Deacon wrote:
> Hi Stephen,
> 
> On Wed, Jun 12, 2013 at 09:01:21PM +0100, Stephen Warren wrote:
> >  void machine_shutdown(void)
> >  {
> > -#ifdef CONFIG_SMP
> > -	smp_send_stop();
> > -#endif
> > +	disable_nonboot_cpus();
> >  }
> 
> Any reason not to move this into machine_kexec and leave machine_shutdown
> as a nop?

If you take a peek at kernel/kexec.c, machine_shutdown() is only invoked
if we haven't frozen processes and already disabled via hotplug the other
CPUs - which will have already been done via disable_nonboot_cpus() in
that path.

So moving it to kexec would mean that path calls disable_nonboot_cpus()
twice, which probably isn't a good thing.
