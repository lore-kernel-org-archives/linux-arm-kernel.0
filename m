From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 8 May 2018 16:11:38 +0100
Subject: [PATCH 4/6] mm, arm64: untag user addresses in mm/gup.c
In-Reply-To: <CAAeHK+yTbmZfkeNbqbo+J90zsjsM99rwnYBGfQBxphHMMfgD7A@mail.gmail.com>
References: <cover.1524077494.git.andreyknvl@google.com>
 <0db34d04fa16be162336106e3b4a94f3dacc0af4.1524077494.git.andreyknvl@google.com>
 <20180426174714.4jtb72q56w3xonsa@armageddon.cambridge.arm.com>
 <CAAeHK+zY8p9E4FZa7mbdgR=wR0u-RDS552dn=h9fKRC-ArYLdw@mail.gmail.com>
 <20180502153645.fui4ju3scsze3zkq@black.fi.intel.com>
 <CAAeHK+yTbmZfkeNbqbo+J90zsjsM99rwnYBGfQBxphHMMfgD7A@mail.gmail.com>
Message-ID: <20180508151137.zguepljs3pa7xv5g@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2018 at 07:25:17PM +0200, Andrey Konovalov wrote:
> On Wed, May 2, 2018 at 5:36 PM, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> > On Wed, May 02, 2018 at 02:38:42PM +0000, Andrey Konovalov wrote:
> >> > Does having a tagged address here makes any difference? I couldn't hit a
> >> > failure with my simple tests (LD_PRELOAD a library that randomly adds
> >> > tags to pointers returned by malloc).
> >>
> >> I think you're right, follow_page_mask is only called from
> >> __get_user_pages, which already untagged the address. I'll remove
> >> untagging here.
> >
> > It also called from follow_page(). Have you covered all its callers?
> 
> Oh, missed that, will take a look.
> 
> Thinking about that, would it make sense to add untagging to find_vma
> (and others) instead of trying to cover all find_vma callers?

I don't think adding the untagging to find_vma() is sufficient. In many
cases the caller does a subsequent check like 'start < vma->vm_start'
(see sys_msync() as an example, there are a few others as well). What I
did in my tests was a WARN_ON_ONCE() in find_vma() if the address is
tagged.

-- 
Catalin
