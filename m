From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 1 Sep 2015 18:30:43 +0100
Subject: [PATCHv2] ARM64: Add AT_ARM64_MIDR to the aux vector
In-Reply-To: <4C8DD5E0-E1EA-40C6-B947-72189241023C@caviumnetworks.com>
References: <1440873982-44062-1-git-send-email-apinski@cavium.com>
 <20150901163304.GC16430@leverpostej>
 <A9115CAF-0C57-4810-97F6-6245E7D0CE48@gmail.com>
 <4C8DD5E0-E1EA-40C6-B947-72189241023C@caviumnetworks.com>
Message-ID: <20150901173043.GE16430@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> >>> On Sat, Aug 29, 2015 at 07:46:22PM +0100, Andrew Pinski wrote:
> >>> It is useful to pass down MIDR register down to userland if all of
> >>> the online cores are all the same type.  This adds AT_ARM64_MIDR
> >>> aux vector type and passes down the midr system register.
> >>> 
> >>> This is alternative to MIDR_EL1 part of
> >>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/358995.html.
> >>> It allows for faster access to midr_el1 than going through a trap and
> >>> does not exist if the set of cores are not the same.
> >> 
> >> I'm not sure I follow the rationale. If speed is important the
> >> application can cache the value the first time it reads it with a trap.
> > 
> > It is also about compatibility also. Exposing the register is not backwards compatible but using the aux vector is. 
> 
> That would also break big.little too. So either break it with hot plug or break it in userland, your choice. 

The value wouldn't be representative of the system as a whole; that is
true. However, we never guaranteed that it was, while the aux vector
code implied that we did.

For optimisation that may be good enough; code optimized for a different
uArch should still function on another, even if it is slower.

> >> This also means that the behaviour is different across homogeneous and
> >> heterogeneous systems.
> 
> That should be ok because it is still backwards compatible with what
> was done before.  My goal here is just to allow quick easy access to
> midr in the case of a homogeneous system which I care about, thunderx
> and to allow glibc to select a memcpy/memset that is better for
> thunderx. 

As I mentioned in the other thread, I think that HWCAP_CPUID is
sufficient to enable forwards and backwards compatibility. If it is
present then you can use the current CPU's MIDR to select a better
memcpy/memset if required.

Thanks,
Mark.
