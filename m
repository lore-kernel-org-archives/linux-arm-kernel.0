From: mhocko@kernel.org (Michal Hocko)
Date: Fri, 23 Dec 2016 15:53:05 +0100
Subject: [PATCH] mm: pmd dirty emulation in page fault handler
In-Reply-To: <20161223140131.GA5724@bbox>
References: <1482364101-16204-1-git-send-email-minchan@kernel.org>
 <20161222081713.GA32480@node.shutemov.name>
 <20161222145203.GA18970@bbox>
 <20161223091725.GA23117@dhcp22.suse.cz>
 <20161223095336.GA5305@bbox>
 <20161223115421.GD23109@dhcp22.suse.cz>
 <20161223140131.GA5724@bbox>
Message-ID: <20161223145305.GF23109@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 23-12-16 23:01:31, Minchan Kim wrote:
> On Fri, Dec 23, 2016 at 12:54:21PM +0100, Michal Hocko wrote:
> > On Fri 23-12-16 18:53:36, Minchan Kim wrote:
[...]
> > > stucks until VM marked the pmd dirty.
> > > 
> > > How the emulation work depends on the architecture. In case of arm64,
> > > when it set up pte firstly, it sets pte PTE_RDONLY to get a chance to
> > > mark the pte dirty via triggering page fault when store access happens.
> > > Once the page fault occurs, VM marks the pte dirty and arch code for
> > > setting pte will clear PTE_RDONLY for application to proceed.
> > > 
> > > IOW, if VM doesn't mark the pte dirty, application hangs forever by
> > > repeated fault(i.e., store op but the pte is PTE_RDONLY).
> > > 
> > > This patch enables dirty-bit emulation for those architectures.
> > 
> > Yes this is helpful and much more clear, thank you. One thing that is
> > still not clear to me is why cannot we handle that in the arch specific
> > code. I mean what is the side effect of doing pmd_mkdirty for
> > architectures which do not need it?
> 
> For architecture which supports H/W access/dirty bit, it couldn't be
> reached there code path so there is no side effect, I think.

ahh, I knew I was missing something. It definitely wasn't obvious to me
and my x86 config it simply generates code to call
huge_pmd_set_accessed.

> A thing
> I can think of is just increasing code size little bit. Maybe, we
> could optimize away some ifdef magic but not sure worth it.

it is not
-- 
Michal Hocko
SUSE Labs
