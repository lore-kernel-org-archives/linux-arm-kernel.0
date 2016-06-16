From: geoff@infradead.org (Geoff Levand)
Date: Thu, 16 Jun 2016 15:58:49 -0700
Subject: [PATCH v18 04/13] arm64/kexec: Add pr_debug output
In-Reply-To: <57618CEB.6040807@arm.com>
References: <cover.1465502767.git.geoff@infradead.org>
 <cfd2d457d5f1991c82b641970ce20475bcc6c7dd.1465502767.git.geoff@infradead.org>
 <57618CEB.6040807@arm.com>
Message-ID: <1466117929.21058.55.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-06-15 at 18:14 +0100, James Morse wrote:
> On 09/06/16 21:08, Geoff Levand wrote:
> > To aid in debugging kexec problems or when adding new functionality to kexec add
> > a new routine kexec_image_info() and several inline pr_debug statements.

> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> > +/**
> > + * kexec_is_dtb - Helper routine to check the device tree header signature.
> > + */
> > +static bool kexec_is_dtb(const void *dtb)
> > +{
> > +> > 	> > __be32 magic;
> > +
> > +> > 	> > if (get_user(magic, (__be32 *)dtb))
> > +> > 	> > 	> > return false;
> > +
> 
> You pass this function 'kimage->segment[i].buf', this looks like the user space
> memory that contained the dtb when kexec-tools first ran to load the image.
> 
> This will work when you call it from machine_kexec_prepare(), but by the time we
> get to machine_kexec() that process is long gone, and this pointer should be
> considered junk.
> 
> I don't think its possible to find this information from machine_kexec(), as the
> DTB will be split up into page size chunks and scattered through memory.

That's correct.  I don't think it that important to print the
dtb segment, so I'll just remove this kexec_is_dtb() routine.

> > +
> >  void machine_kexec_cleanup(struct kimage *kimage)
> >  {
> >  > > 	> > /* Empty routine needed to avoid build errors. */
> > @@ -65,6 +107,8 @@ int machine_kexec_prepare(struct kimage *kimage)
> >  > > 	> > 	> > }
> >  > > 	> > }
> >  
> > +> > 	> > kexec_image_info(kimage);
> > +
> 
> You want to put this at the start of machine_kexec_prepare(), otherwise we may
> return from:
> > #ifdef CONFIG_HOTPLUG_CPU
> > 	> > /* any_cpu as we don't mind being preempted */
> > 	> > int any_cpu = raw_smp_processor_id();
> > 
> > 	> > if (cpu_ops[any_cpu]->cpu_die)
> > 	> > 	> > return 0;
> > #endif /* CONFIG_HOTPLUG_CPU */
> 
> This maybe-return-an-error block needs to be the last thing in the function.

OK.

> I'm not sure if the debug output is actually useful this early: kexec-tools
> prints out exactly the same information shortly after this function returns.

I thought it good to do it here, kexec-tools is not the only user
of kexec see https://github.com/antonblanchard/kexec-lite.

Thanks for checking.

-Geoff
