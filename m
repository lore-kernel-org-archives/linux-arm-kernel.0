From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Nov 2011 18:30:37 +0000
Subject: [PATCH v6 3/5] ARM: soft_restart: disable the outer L2 when the
 last CPU is going down
In-Reply-To: <4EC3FED8.7000307@codeaurora.org>
References: <1321466057-19721-1-git-send-email-will.deacon@arm.com>
 <1321466057-19721-4-git-send-email-will.deacon@arm.com>
 <4EC3FED8.7000307@codeaurora.org>
Message-ID: <20111116183036.GR4942@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Wed, Nov 16, 2011 at 06:20:08PM +0000, Stephen Boyd wrote:
> On 11/16/11 09:54, Will Deacon wrote:
> > diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> > index 577d092..664d351 100644
> > --- a/arch/arm/kernel/process.c
> > +++ b/arch/arm/kernel/process.c
> > @@ -137,6 +137,10 @@ void soft_restart(unsigned long addr)
> >  	local_irq_disable();
> >  	local_fiq_disable();
> >  
> > +	/* Disable the L2 if we're the last man standing. */
> > +	if (num_online_cpus() == 1)
> > +		outer_disable();
> > +
> 
> When does this code execute on another cpu? My understanding is that
> soft_restart() is only called on one CPU so I would think checking the
> number of online cpus isn't necessary.

Currently, yes, this only executes on one CPU. The code is there in case
we want to implement a SMP kexec solution that doesn't require CPU hotplug
at some point.

I suppose you could end up in a situation where the reset path leads to a
soft reboot and you haven't dealt with the secondaries at this point, but
then you have bigger problems to worry about (namely that whatever you jump
to after turning the MMU off needs to deal with the secondaries somehow).

Are you seeing problems with this?

Cheers,

Will
