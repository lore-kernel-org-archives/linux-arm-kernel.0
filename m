From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 23 Mar 2017 10:49:30 +0000
Subject: [RFC PATCH v2 11/41] arm64/sve: Expand task_struct for Scalable
 Vector Extension state
In-Reply-To: <20170322162035.GB19950@leverpostej>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
 <1490194274-30569-12-git-send-email-Dave.Martin@arm.com>
 <20170322162035.GB19950@leverpostej>
Message-ID: <20170323104927.GB3750@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 04:20:35PM +0000, Mark Rutland wrote:
> On Wed, Mar 22, 2017 at 02:50:41PM +0000, Dave Martin wrote:
> > This patch expands task_struct to accommodate the Scalable Vector
> > Extension state.
> > 
> > The extra space is not used for anything yet.
> 
> [...]
> 
> > +#ifdef CONFIG_ARM64_SVE
> > +
> > +static void *__sve_state(struct task_struct *task)
> > +{
> > +	return (char *)task + ALIGN(sizeof(*task), 16);
> > +}
> > +
> > +static void *sve_pffr(struct task_struct *task)
> > +{
> > +	unsigned int vl = sve_get_vl();
> > +
> > +	BUG_ON(vl % 16);
> > +	return (char *)__sve_state(task) + 34 * vl;
> > +}
> 
> Can we mnemonicise the magic numbers for these?
> 
> That, and some comment regarding how the task_struct and sve state are
> organised in memory, as that's painful to reverse-engineer.

See patch 16.  The signal frame layout becomes the canonical source of
this magic (since I deliberately want to be able to copy directly to/
from task_struct).

That patch also abstracts the vl validity check so we don't have to
spell that out everywhere.

> 
> > +
> > +#else /* ! CONFIG_ARM64_SVE */
> > +
> > +/* Dummy declarations for usage protected with IS_ENABLED(CONFIG_ARM64_SVE): */
> > +extern void *__sve_state(struct task_struct *task);
> > +extern void *sve_pffr(struct task_struct *task);
> > +
> > +#endif /* ! CONFIG_ARM64_SVE */
> 
> The usual pattern is to make these static inlines, with a BUILD_BUG() if
> calls are expected/required to be optimised away entirely.

Not sure where I got this idiom from -- there is precedent in e.g.,
arch/arm/include/asm/cmpxchg.h, but I don't think I got it from
there...

I was concerned about false positives with BUILD_BUG(), but it's
unavoidable either way.  The compiler is never going to give an absolute
promise to remove unused code.

The "missing extern" approach seems no less valid, except potential
namespace pollution, but I don't have a problem with changing these.

Cheers
---Dave
