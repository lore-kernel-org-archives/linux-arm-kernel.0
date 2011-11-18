From: will.deacon@arm.com (Will Deacon)
Date: Fri, 18 Nov 2011 17:21:07 +0000
Subject: [PATCH 4/4] ARM: idmap: use idmap_pgd when setting up mm for
 reboot
In-Reply-To: <CAHkRjk4c1Q7+q9-fc+KXc3ySwnVPXbfBGJbqL2QvpHCqtNK_Tw@mail.gmail.com>
References: <1321462094-6647-1-git-send-email-will.deacon@arm.com>
 <1321462094-6647-5-git-send-email-will.deacon@arm.com>
 <CAHkRjk4c1Q7+q9-fc+KXc3ySwnVPXbfBGJbqL2QvpHCqtNK_Tw@mail.gmail.com>
Message-ID: <20111118172107.GC17991@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2011 at 04:56:24PM +0000, Catalin Marinas wrote:
> On 16 November 2011 16:48, Will Deacon <will.deacon@arm.com> wrote:
> > ?void setup_mm_for_reboot(char mode)
> > ?{
> > - ? ? ? /*
> > - ? ? ? ?* We need to access to user-mode page tables here. For kernel threads
> > - ? ? ? ?* we don't have any user-mode mappings so we use the context that we
> > - ? ? ? ?* "borrowed".
> > - ? ? ? ?*/
> > - ? ? ? identity_mapping_add(current->active_mm->pgd, 0, TASK_SIZE);
> > + ? ? ? /* Clean and invalidate L1. */
> > + ? ? ? flush_cache_all();
> 
> Is the cache flushing needed here? The setup_mm_for_reboot callers do
> it after this function anyway (unless this is needed for VIVT
> caches?).

I initially added the cache flushing because we used to manipulate the page
tables at this point. We don't do that anymore, but as you say, if we have
a VIVT D-side then we do need that flush before switching to the new pgd.

One thing I will change is the following comment (/* Switch exclusively to kernel
mappings. */) because that's a bit confusing now.

Will
