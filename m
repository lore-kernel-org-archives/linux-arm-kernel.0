From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Feb 2013 18:11:15 +0000
Subject: Multi-platform, and secure-only ARM errata workarounds
In-Reply-To: <512CF87A.4090404@wwwdotorg.org>
References: <512BF81A.3080700@wwwdotorg.org> <201302261023.26939.arnd@arndb.de>
 <20130226113538.GS17833@n2100.arm.linux.org.uk>
 <512CF87A.4090404@wwwdotorg.org>
Message-ID: <20130226181114.GU17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 11:01:30AM -0700, Stephen Warren wrote:
> The conditional in that statement makes me wonder which of the following
> operations will fault in non-secure mode:
> 
> 1) Reading from the diagnostic register.

Won't fault.

> 2) Writing to the diagnostic register, of a value the same as what's
> already there.

Will fault.

> 3) Writing to the diagnostic register, of a value different than what's
> already there.

Will fault.

> Would the following not fault in both secure and non-secure mode:
> 
> read diagnostic register
> if desired bit already set:
>     b 1f
> set desired bit
> write value back to diagnostic register
> 1:

That is exactly what we do - the problem is, that if you require
workaround X to be enabled, and a different platform has that errata
fixed, then the other platform will not enable the work-around, and
the bit will be clear.

So, that causes the early boot code to read-check-modify-write the
secure-only register, and the write causes _that_ platform to fail to
boot.

Yes, yours continues to work just fine - but everyone else starts
failing.

Now, factor into that that any particular platform may have a range of
different versions of the ARM CPU core (OMAP CPUs have gone through
various Cortex-A9 CPU revisions) and you'll find that you can't tell
just from the platform information what work-arounds should be enabled.

The whole errata business is a total nightmare - and it gets much worse
with the advent of multi-SoC kernels.  We don't have an answer to this
other than disabling these troublesome errata and requiring the code
which comes before the kernel to do whatever is necessary.

As I've said, the alternative is to encode the errata information into
DT, and then write a DT parser purely in assembler... no one fancies
doing that though.
