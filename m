From: andreyknvl@google.com (Andrey Konovalov)
Date: Wed, 2 May 2018 19:25:17 +0200
Subject: [PATCH 4/6] mm, arm64: untag user addresses in mm/gup.c
In-Reply-To: <20180502153645.fui4ju3scsze3zkq@black.fi.intel.com>
References: <cover.1524077494.git.andreyknvl@google.com>
 <0db34d04fa16be162336106e3b4a94f3dacc0af4.1524077494.git.andreyknvl@google.com>
 <20180426174714.4jtb72q56w3xonsa@armageddon.cambridge.arm.com>
 <CAAeHK+zY8p9E4FZa7mbdgR=wR0u-RDS552dn=h9fKRC-ArYLdw@mail.gmail.com>
 <20180502153645.fui4ju3scsze3zkq@black.fi.intel.com>
Message-ID: <CAAeHK+yTbmZfkeNbqbo+J90zsjsM99rwnYBGfQBxphHMMfgD7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 2, 2018 at 5:36 PM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> On Wed, May 02, 2018 at 02:38:42PM +0000, Andrey Konovalov wrote:
>> > Does having a tagged address here makes any difference? I couldn't hit a
>> > failure with my simple tests (LD_PRELOAD a library that randomly adds
>> > tags to pointers returned by malloc).
>>
>> I think you're right, follow_page_mask is only called from
>> __get_user_pages, which already untagged the address. I'll remove
>> untagging here.
>
> It also called from follow_page(). Have you covered all its callers?

Oh, missed that, will take a look.

Thinking about that, would it make sense to add untagging to find_vma
(and others) instead of trying to cover all find_vma callers?
