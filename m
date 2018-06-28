From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 28 Jun 2018 11:25:04 +0200
Subject: [PATCH 2/5] kernel/jump_label: implement generic support for
 relative references
In-Reply-To: <CAKv+Gu-xPR6UEiP0NT0zYXKRYXqwFCXP=nf0cC87PZdDYBZB4A@mail.gmail.com>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
 <20180627160604.8154-3-ard.biesheuvel@linaro.org>
 <20180628085003.GA2494@hirez.programming.kicks-ass.net>
 <CAKv+Gu87DmGLG7N8X8+V7LppXm72SJUmCcEpaehCE5Rt0Z4FNw@mail.gmail.com>
 <CAKv+Gu-xPR6UEiP0NT0zYXKRYXqwFCXP=nf0cC87PZdDYBZB4A@mail.gmail.com>
Message-ID: <20180628092504.GC2494@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 11:04:45AM +0200, Ard Biesheuvel wrote:
> On 28 June 2018 at 11:02, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >>> @@ -56,7 +72,9 @@ jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
> >>>
> >>>       size = (((unsigned long)stop - (unsigned long)start)
> >>>                                       / sizeof(struct jump_entry));
> >>> -     sort(start, size, sizeof(struct jump_entry), jump_label_cmp, NULL);
> >>> +     sort(start, size, sizeof(struct jump_entry), jump_label_cmp,
> >>> +          IS_ENABLED(CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE) ? jump_label_swap
> >>> +                                                           : NULL);
> >>>  }
> >>
> >> That will result in jump_label_swap being an unused symbol for some
> >> compile options.
> >
> > No, and isn't that the point of IS_ENABLED()? The compiler sees a
> > reference to jump_label_swap(), so it won't complain about it being
> > unused.

Ah, ok. I hadn't figured it was quite that smart about it.

> > Meh. I thought IS_ENABLED() was preferred over #ifdef, no?

Dunno, I just reacted to the proposed code's uglyness :-)

> ... and it means the sort() routine will unconditionally perform an
> indirect function call even if the arch does not require it.

Yeah, not sure I care about that here, this is a one time affair, very
far away from any fast paths.
