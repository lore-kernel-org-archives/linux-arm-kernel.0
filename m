From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 17 Apr 2015 10:01:56 +0100
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <2242025.Z9qPVP4zls@wuerfel>
References: <025BB233-8D14-457A-B3B2-C6BD6C3B32EF@theobroma-systems.com>
 <E769538B-CE45-4FF3-AD2C-21B30069F0B9@caviumnetworks.com>
 <20150416133134.GC819@e104818-lin.cambridge.arm.com>
 <2242025.Z9qPVP4zls@wuerfel>
Message-ID: <20150417090156.GH819@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 16, 2015 at 05:21:30PM +0200, Arnd Bergmann wrote:
> On Thursday 16 April 2015 14:31:34 Catalin Marinas wrote:
> > On Thu, Apr 16, 2015 at 11:33:49AM +0000, Pinski, Andrew wrote:
> > > There are only a few places where long should be 32bit rather than
> > > 64bit. The non-time_t field of timespec is the only one I can think
> > > of.
> > 
> > It may be the only one but we could end up with a non-compliant
> > timespec. Unless we keep the tv_nsec as 32-bit long and add some
> > padding, we could work around it by getting the C library to sign-extend
> > such padding or we do it in a new "compat" layer in the kernel (but both
> > cases imply copying the structure).
> > 
> > However, timerspec is included in other structures, so we'd have to
> > intercept those as well. Philipp provided a list here:
> > 
> > http://article.gmane.org/gmane.linux.kernel/1931497
> 
> We're basically in the same boat as x32 then, and should do the same
> thing on both most importantly, whatever that ends up.

I'm getting confused ;). I thought you were pushing for a 32-bit time_t
on AArch64 ILP32.

I'm not sure we need to be in the same boat as x32. Their decision was
to primarily use the LP64 ABI and there are performance advantages, not
only the 2038 issue. The downside, few POSIX incompatibilities that I
think they are happy to live with. If we are happy to live with them as
well, we go ahead with the current patchset. We may try to patch some of
the POSIX incompatibilities (see Philipp's list above) by
padding/copying/sign-extending the affected structures.

> However, it would be nice to get agreement on the normal 32-bit ABI
> for time_t and timespec first, and then use the same thing everywhere.

Do you mean for native 32-bit architectures? I think OpenBSD uses a
64-bit time_t already on 32-bit arches, it's doable in Linux as well.

-- 
Catalin
