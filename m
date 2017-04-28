From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 28 Apr 2017 11:02:30 +0100
Subject: [PATCHv2 2/2] arm64: cpufeature: use
 static_branch_enable_cpuslocked()
In-Reply-To: <20170427180104.GO1890@arm.com>
References: <1493315077-19496-1-git-send-email-mark.rutland@arm.com>
 <1493315077-19496-3-git-send-email-mark.rutland@arm.com>
 <20170427180104.GO1890@arm.com>
Message-ID: <20170428100230.GA22621@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 07:01:04PM +0100, Will Deacon wrote:
> On Thu, Apr 27, 2017 at 06:44:37PM +0100, Mark Rutland wrote:
> > diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> > index f6cc67e..379ad8d 100644
> > --- a/arch/arm64/kernel/cpu_errata.c
> > +++ b/arch/arm64/kernel/cpu_errata.c
> > @@ -175,9 +175,20 @@ void verify_local_cpu_errata_workarounds(void)
> >  		}
> >  }
> >  
> > -void update_cpu_errata_workarounds(void)
> > +/*
> > + * Secondary CPUs are booted with the waker holding the
> > + * CPU hotplug lock, hence we don't need to lock it here again.
> > + */
> > +void update_secondary_cpu_errata_workarounds(void)
> > +{
> > +	update_cpu_capabilities(arm64_errata, "enabling workaround for");
> > +}
> > +
> > +void update_boot_cpu_errata_workarounds(void)
> >  {
> > +	get_online_cpus();
> >  	update_cpu_capabilities(arm64_errata, "enabling workaround for");
> > +	put_online_cpus();
> >  }
> 
> These functions seem to have unhelpful names, especially when compared to
> the naming scheme used by the core code. I'd prefer to have:
> 
> update_cpu_errata_workarounds: just calls update_cpu_capabilities
> 
> update_cpu_errata_workarounds_cpuslocked: does get_online_cpus(), then calls
> update_cpu_errata_workarounds, then does put_online_cpus();

That's the opposite polarity to the other _cpuslocked functions, where
_cpuslocked means that the lock is already held (and should not be taken
by the _cpuslocked function itself.

So I'll make those changes, but I'll swap that so:
update_cpu_errata_workarounds() does:

  get_online_cpus()
  update_cpu_errata_workarounds_cpuslocked()
  put_online_cpus()

> With that change:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

I assume that will stand with the above change. Please shout if not!

Thanks,
Mark.
