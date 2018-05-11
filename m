From: andreyknvl@google.com (Andrey Konovalov)
Date: Fri, 11 May 2018 14:36:22 +0200
Subject: [PATCH 4/6] mm, arm64: untag user addresses in mm/gup.c
In-Reply-To: <20180508151137.zguepljs3pa7xv5g@armageddon.cambridge.arm.com>
References: <cover.1524077494.git.andreyknvl@google.com>
 <0db34d04fa16be162336106e3b4a94f3dacc0af4.1524077494.git.andreyknvl@google.com>
 <20180426174714.4jtb72q56w3xonsa@armageddon.cambridge.arm.com>
 <CAAeHK+zY8p9E4FZa7mbdgR=wR0u-RDS552dn=h9fKRC-ArYLdw@mail.gmail.com>
 <20180502153645.fui4ju3scsze3zkq@black.fi.intel.com>
 <CAAeHK+yTbmZfkeNbqbo+J90zsjsM99rwnYBGfQBxphHMMfgD7A@mail.gmail.com>
 <20180508151137.zguepljs3pa7xv5g@armageddon.cambridge.arm.com>
Message-ID: <CAAeHK+yR9=SYEBg-Pvi+x3qSqQSG1u+79pk5vQvOcsp+o=zkxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 8, 2018 at 5:11 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, May 02, 2018 at 07:25:17PM +0200, Andrey Konovalov wrote:
>> On Wed, May 2, 2018 at 5:36 PM, Kirill A. Shutemov
>> <kirill.shutemov@linux.intel.com> wrote:
>> > On Wed, May 02, 2018 at 02:38:42PM +0000, Andrey Konovalov wrote:
>> >> > Does having a tagged address here makes any difference? I couldn't hit a
>> >> > failure with my simple tests (LD_PRELOAD a library that randomly adds
>> >> > tags to pointers returned by malloc).
>> >>
>> >> I think you're right, follow_page_mask is only called from
>> >> __get_user_pages, which already untagged the address. I'll remove
>> >> untagging here.
>> >
>> > It also called from follow_page(). Have you covered all its callers?
>>
>> Oh, missed that, will take a look.
>>
>> Thinking about that, would it make sense to add untagging to find_vma
>> (and others) instead of trying to cover all find_vma callers?
>
> I don't think adding the untagging to find_vma() is sufficient. In many
> cases the caller does a subsequent check like 'start < vma->vm_start'
> (see sys_msync() as an example, there are a few others as well).

OK.

> What I
> did in my tests was a WARN_ON_ONCE() in find_vma() if the address is
> tagged.

So this is similar to what I did.

Do you think trying to find "all places where we cast out __user" with
static analysis as Kirill suggested is something I should pursue? Or
is this patchset is good as is as the first approximation, since we
can fix more things where untagging is needed as we discover them one
by one?
