From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Nov 2011 11:25:08 +0000
Subject: [PATCH] ARM: Do not call flush_cache_user_range with mmap_sem held
In-Reply-To: <20111117110339.GO9581@n2100.arm.linux.org.uk>
References: <20111107172836.5615.64219.stgit@e102109-lin.cambridge.arm.com>
 <CAOesGMhWxEKUe7C4A+Xqv3RjN_u1t4k8eHWSZE4qMoBPD9=1qw@mail.gmail.com>
 <20111116235024.GH9581@n2100.arm.linux.org.uk>
 <20111117102205.GF4748@arm.com>
 <20111117104245.GL9581@n2100.arm.linux.org.uk>
 <20111117105935.GH4748@arm.com>
 <20111117110339.GO9581@n2100.arm.linux.org.uk>
Message-ID: <20111117112508.GA20412@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 11:03:39AM +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 17, 2011 at 10:59:36AM +0000, Catalin Marinas wrote:
> > On Thu, Nov 17, 2011 at 10:42:46AM +0000, Russell King - ARM Linux wrote:
> > > On Thu, Nov 17, 2011 at 10:22:05AM +0000, Catalin Marinas wrote:
> > > > BTW, we could even go a step further an remove the vma checks entirely,
> > > > just use access_ok() since __cpuc_coherent_user_range() can handle
> > > > unmapped ranges properly (though it may introduce some latency if some
> > > > user app passes a 3G range but we can change the fixup code to abort the
> > > > operation when it gets a fault that can't be fixed up).
> > > 
> > > So, do you think that it is acceptable to be able to pass into this from
> > > userspace the arguments '0', '~0', '0' and have the kernel spin over the
> > > entire 4G space, including IO space on any of the supported architectures.
> > 
> > We have access_ok() to check for user only space.
> > 
> > > Note that pre-ARMv6 CPUs will spin over that range in 32-byte steps
> > > whether or not there's a page present.
> > 
> > You are right, the pre-v6 hardware would not trigger a fault. So if we
> > don't want another #ifdef in this function, we just keep the vma checks
> > for all architecture versions.
> > 
> > But I consider that the original patch is still valid.
> 
> You thinks it's safe to walk the vma list with no locks held?

No, I don't, but the patch only releases the semaphore when calling the
cache flushing function. The vmas are walked with the semaphore held.

Please read the patch I posted properly.

-- 
Catalin
