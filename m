From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Feb 2018 17:33:23 +0000
Subject: [RFC PATCH v2 08/12] arm64: cmpxchg: Include build_bug.h instead
 of bug.h for BUILD_BUG
In-Reply-To: <20180226154848.ejqxw5lkbiqqxlsf@salmiak>
References: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
 <1519657500-15094-9-git-send-email-will.deacon@arm.com>
 <20180226154848.ejqxw5lkbiqqxlsf@salmiak>
Message-ID: <20180227173322.GK29123@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 03:48:49PM +0000, Mark Rutland wrote:
> On Mon, Feb 26, 2018 at 03:04:56PM +0000, Will Deacon wrote:
> > Having asm/cmpxchg.h pull in linux/bug.h is problematic because this
> > ends up pulling in the atomic bitops which themselves may be built on
> > top of atomic.h and cmpxchg.h.
> > 
> > Instead, just include build_bug.h for the definition of BUILD_BUG.
> 
> We also use VM_BUG_ON(), defined in <linux/mmdebug.h>, which includes
> <linux/bug.h>.
> 
> ... so I think we still have some fragility here, albeit no worse than before.
> 
> We also miss includes for:
> 
> * <linux/percpu-defs.h> (raw_cpu_ptr)
> * <linux/preempt.h> (preempt_disable, preempt_enable)

Hmm, we can't include this one because it pulls in linux/bitops.h. I've
moved the percpu cmpxchg stuff into asm/percpu.h, but that too is missing
the linux/preempt.h #include, so I've added that as well.

Generally, I think if we want to clean up our #includes then that's better
done as a separate series rather than as a piecemeal effort, which will
likely fail to identify many of the underlying problems.

Will
