From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 1 Sep 2015 18:19:36 +0100
Subject: [PATCHv2] ARM64: Add AT_ARM64_MIDR to the aux vector
In-Reply-To: <A9115CAF-0C57-4810-97F6-6245E7D0CE48@gmail.com>
References: <1440873982-44062-1-git-send-email-apinski@cavium.com>
 <20150901163304.GC16430@leverpostej>
 <A9115CAF-0C57-4810-97F6-6245E7D0CE48@gmail.com>
Message-ID: <20150901171936.GD16430@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 01, 2015 at 05:51:44PM +0100, pinskia at gmail.com wrote:
> 
> 
> 
> 
> > On Sep 2, 2015, at 12:33 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > Hi,
> > 
> >> On Sat, Aug 29, 2015 at 07:46:22PM +0100, Andrew Pinski wrote:
> >> It is useful to pass down MIDR register down to userland if all of
> >> the online cores are all the same type.  This adds AT_ARM64_MIDR
> >> aux vector type and passes down the midr system register.
> >> 
> >> This is alternative to MIDR_EL1 part of
> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/358995.html.
> >> It allows for faster access to midr_el1 than going through a trap and
> >> does not exist if the set of cores are not the same.
> > 
> > I'm not sure I follow the rationale. If speed is important the
> > application can cache the value the first time it reads it with a trap.
> 
> It is also about compatibility also. Exposing the register is not
> backwards compatible but using the aux vector is. 

So long as we have HWCAP_CPUID describing the availability of register
access [2], then userspace can test for that before attempting to access
the MIDR.

Other than that, I don't see a backwards or forwards compatibility
issue.

> >> +u32 get_arm64_midr(void)
> >> +{
> >> +    int i;
> >> +    u32 midr = 0;
> >> +
> >> +    for_each_online_cpu(i) {
> >> +        struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, i);
> >> +        u32 oldmidr = midr;
> >> +
> >> +        midr = cpuinfo->reg_midr;
> >> +        /*
> >> +         * If there are cpus which have a different
> >> +         * midr just return 0.
> >> +         */
> >> +        if (oldmidr && oldmidr != midr)
> >> +            return 0;
> >> +    }
> >> +
> >> +    return midr;
> >> +}
> > 
> > If I have a big.LITTLE system where all the big CPUs are currently
> > offline, this will leave the MIDR the little CPUs in the auxvec.
> > However, at any point after this has run, I could hotplug the big CPUs
> > on and the little CPUs off, leaving this reporting a MIDR that
> > represents none of the online CPUs.
> > 
> > Given big.LITTLE and the potential for physical/dynamic hotplug (where
> > we won't know all the MIDRs in advance), I don't think that we can
> > generally expose a common MIDR in this fashion, and I don't think that
> > we should give the impression that we can.
> 
> This is standard issue with hot plug and big.little. Really big.little
> is a design flaw but I am not going into that here. 

Regardless of our personal feelings on big.LITTLE, it's something we
have to deal with.

Hopefully it's a non-issue anyway; a MIDR provided by this interface can
really only be used to derive optimisation criteria rather than
non-architected properties required for correctness.

> > I think that the only things we can do are expose the MIDR for CPU the
> > code is currently executing on (as Suzuki's patches do), and/or expose
> > all the MIDRs for currently online CPUs (as Steve's [1] patch does).
> > Anything else leaves us trying to provide semantics that we cannot
> > guarantee.
> 
> Except they are not backwards compatible which means nobody in their
> right mind would use the register to get the midr that way.

I assume you missed the discussion of HWCAP_CPUID, which prevents the
compatibility issue I believe you're considering here.

> I am sorry but having a newer version of glibc working on a year old
> kernel is not going to fly. 

I'm not sure I follow this, unless you meant _not_ working.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/359127.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/363559.html
