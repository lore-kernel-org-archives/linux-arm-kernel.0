From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Dec 2014 09:55:49 +0000
Subject: [RFC] ACPI on arm64 TODO List
In-Reply-To: <54925EA1.1030901@jonmasters.org>
References: <548F9668.6080900@linaro.org> <9355623.14GfrLxEB0@wuerfel>
 <20141216152707.GH11565@e104818-lin.cambridge.arm.com>
 <5490C83A.2080600@linaro.org>
 <20141217092505.GA9475@e104818-lin.cambridge.arm.com>
 <54925EA1.1030901@jonmasters.org>
Message-ID: <20141218095549.GA19484@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 18, 2014 at 04:57:05AM +0000, Jon Masters wrote:
> On 12/17/14, 4:25 AM, Catalin Marinas wrote:
> > On Wed, Dec 17, 2014 at 12:03:06AM +0000, Al Stone wrote:
> >> They will
> >> at some point in the future, but not now.  Regardless, I think it's
> >> reasonable for us to say that if you want ACPI support, PSCI must be
> >> used for secondary CPU startup.  People can hack something up to get
> >> the parking protocol to work on development branches if they want, but
> >> I personally see no need to get that into the kernel -- and it needs
> >> to be said explicitly in arm-acpi.txt.
[...]
> > I'm fine with this. But note that it pretty much rules out the APM
> > boards (I think we ruled them out a few times already) which don't have
> > an EL3 to host PSCI firmware. EL2 is not suitable as it is likely that
> > we want this level for KVM or Xen rather than platform firmware.
> 
> The gen1 APM boards work great with UEFI and ACPI using the Parking 
> Protocol. It's trivial to support, and it's a fairly constrained since 
> everyone is headed toward PSCI. Personally I consider it unfair to 
> punish the first guy out of the gate for something that was standardized 
> after they made their design.

Most of the complaints about the APM ACPI support were around drivers,
clocks rather than the parking protocol. On the latter, we complained
when Hanjun posted core patches that did not match the documentation and
the (old) parking protocol spec was not suitable to AArch64 either.

> My recommendation would be to get the 
> relevant document updated in the public repository.

This should be stronger than just a "recommendation".

> Patches that 
> implement Parking Protocol are already in existence/working well as an 
> alternative to PSCI (which is always preferred if available).

Let's hope they match the new spec ;).

What the parking protocol doesn't cover (last time I looked) is a way to
return CPUs to firmware for hotplug or CPUidle. On non-PSCI platforms
this would need to be done with SoC-specific code implementing (part of)
the cpu_operations back-end. Technically, I think there are solutions to
standardise such CPU return to firmware but it's debatable whether it's
worth the effort given the long term PSCI recommendation.

-- 
Catalin
