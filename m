From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 11 Oct 2017 15:45:43 +0100
Subject: [PATCH v3 01/28] regset: Add support for dynamically sized regsets
In-Reply-To: <20171011141410.tu53u2ugvs6n7uem@armageddon.cambridge.arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-2-git-send-email-Dave.Martin@arm.com>
 <20171011141410.tu53u2ugvs6n7uem@armageddon.cambridge.arm.com>
Message-ID: <20171011144543.GE19485@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 03:14:10PM +0100, Catalin Marinas wrote:
> On Tue, Oct 10, 2017 at 07:38:18PM +0100, Dave P Martin wrote:
> > Currently the regset API doesn't allow for the possibility that
> > regsets (or at least, the amount of meaningful data in a regset)
> > may change in size.
> > 
> > In particular, this results in useless padding being added to
> > coredumps in a regset's current size is smaller than its
> > theoretical maximum size.
> > 
> > This patch adds a get_size() function to struct user_regset.
> > Individual regset implementations can implement this function to
> > return the current size of the regset data.  A regset_size()
> > function is added to provide callers with an abstract interface for
> > determining the size of a regset without needing to know whether
> > the regset is dynamically sized or not.
> > 
> > The only affected user of this interface is the ELF coredump code:
> > This patch ports ELF coredump to dump regsets with their actual
> > size in the coredump.  This has no effect except for new regsets
> > that are dynamically sized and provide a get_size() implementation.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
> > ---
> >  fs/binfmt_elf.c        |  6 ++---
> >  include/linux/regset.h | 67 ++++++++++++++++++++++++++++++++++++++++++++------
> >  2 files changed, 63 insertions(+), 10 deletions(-)
> 
> The patch looks fine to me:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> However, you'd probably need an ack from the filesystem maintainers
> (cc'ed; patch below for reference).

Apologies for that -- I manually added Ccs to this patch in previous
postings, and predictably lost them in the respin.

I'll add Cc lines in the commit message, since there will be a
further re-spin of the series to apply the Documentation changes
requested by Szabolcs that I missed.

I don't currently have any pending fixes to _this_ patch, so it's still
worth reviewing.

Cheers
---Dave

[...]
