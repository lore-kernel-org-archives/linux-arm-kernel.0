From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 17 Sep 2018 16:44:00 -0700
Subject: [PATCH v5 03/27] arm64: alternative: Apply alternatives early in
 boot process
In-Reply-To: <78781d82-e5c4-c590-6c0c-e7d2db456bf9@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-4-git-send-email-julien.thierry@arm.com>
 <3becf020-b230-beb8-b304-d8097377f234@arm.com>
 <78781d82-e5c4-c590-6c0c-e7d2db456bf9@arm.com>
Message-ID: <20180917234400.ctq3w2u6fi5s5coj@holly.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 05:49:09PM +0100, Julien Thierry wrote:
> > > +	__apply_alternatives(&region, false, boot_capabilities);
> > > +}
> > > +
> > >   #ifdef CONFIG_MODULES
> > >   void apply_alternatives_module(void *start, size_t length)
> > >   {
> > 
> > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > index 3bc1c8b..0d1e41e 100644
> > > --- a/arch/arm64/kernel/cpufeature.c
> > > +++ b/arch/arm64/kernel/cpufeature.c
> > > @@ -52,6 +52,8 @@
> > >   DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
> > >   EXPORT_SYMBOL(cpu_hwcaps);
> > > +unsigned long boot_capabilities;
> > > +
> > >   /*
> > >    * Flag to indicate if we have computed the system wide
> > >    * capabilities based on the boot time active CPUs. This
> > > @@ -1375,6 +1377,9 @@ static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
> > >   		if (!cpus_have_cap(caps->capability) && caps->desc)
> > >   			pr_info("%s %s\n", info, caps->desc);
> > >   		cpus_set_cap(caps->capability);
> > 
> > Hmm, the bitmap behind cpus_set_cap() is what cpus_have_cap() in
> > __apply_alternatives() looks at. If you had a call to __apply_alternatives after
> > update_cpu_capabilities(SCOPE_BOOT_CPU), but before any others, it would only
> > apply those alternatives...
> > 
> > (I don't think there is a problem re-applying the same alternative, but I
> > haven't checked).
> > 
> 
> Interesting idea. If someone can confirm that patching alternatives twice is
> safe, I think it would make things simpler.

Early versions of this patch applied the alternatives twice. I never
noticed any problems with double patching (second time round it will
write out code that is identical to what is already there so it is
merely inefficient rather than unsafe.


Daniel.
