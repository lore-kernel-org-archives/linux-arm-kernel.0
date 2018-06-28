From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 28 Jun 2018 11:37:38 +0200
Subject: [PATCH 2/5] kernel/jump_label: implement generic support for
 relative references
In-Reply-To: <CAKv+Gu-bL0neh61=1B=Dja7+tsH_ong731t2Xp17h4E1fjavjA@mail.gmail.com>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
 <20180627160604.8154-3-ard.biesheuvel@linaro.org>
 <20180628085003.GA2494@hirez.programming.kicks-ass.net>
 <CAKv+Gu87DmGLG7N8X8+V7LppXm72SJUmCcEpaehCE5Rt0Z4FNw@mail.gmail.com>
 <CAKv+Gu-xPR6UEiP0NT0zYXKRYXqwFCXP=nf0cC87PZdDYBZB4A@mail.gmail.com>
 <20180628092504.GC2494@hirez.programming.kicks-ass.net>
 <CAKv+Gu-bL0neh61=1B=Dja7+tsH_ong731t2Xp17h4E1fjavjA@mail.gmail.com>
Message-ID: <20180628093738.GE2494@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 11:29:40AM +0200, Ard Biesheuvel wrote:
> On 28 June 2018 at 11:25, Peter Zijlstra <peterz@infradead.org> wrote:
> >> > Meh. I thought IS_ENABLED() was preferred over #ifdef, no?
> >
> > Dunno, I just reacted to the proposed code's uglyness :-)
> >
> 
> I will try to come up with something that rhymes, ok? :-)

:-)

> >> ... and it means the sort() routine will unconditionally perform an
> >> indirect function call even if the arch does not require it.
> >
> > Yeah, not sure I care about that here, this is a one time affair, very
> > far away from any fast paths.
> >
> 
> Fair enough.

I recently had thoughts about doing the sort at link time, but then I
figured I didn't care enough to go write the tool to do that. The reason
was in that other patch-set that might conflict, that wants to use jump
labels _very_ early (for x86), so we had to lift the ideal nops stuff
and the cpu feature bits it relies upon to early code.

All in all the patch wasn't terrible and that made me completely loose
interest about doing the link-time thing again.

However, if someone is 'concerned' about the boot time performance, and
figures avoiding the sort is somehow worth it, they can look into it.
