From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 30 May 2010 23:46:29 +0100
Subject: 2.6.34 hangs during boot on PB11MPCore
In-Reply-To: <AANLkTilMtEpt5hRfF_hszpU_AxZm7H93bkhqUacGWZc9@mail.gmail.com>
References: <AANLkTin9n6HDdiTnQoQ9mrmuzSR8JhZVq7uPgU86yqgU@mail.gmail.com>
	<20100530073652.GX2695@buzzloop.caiaq.de>
	<AANLkTimUF5iiGnc6RnN5C3sy-R6DAqHZNf6ZEu2o3W9P@mail.gmail.com>
	<AANLkTikdvjg52v-3AKUBukGO2FCp3fENGoYgpZZ2xVtT@mail.gmail.com>
	<AANLkTilMtEpt5hRfF_hszpU_AxZm7H93bkhqUacGWZc9@mail.gmail.com>
Message-ID: <1275259589.22752.14.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2010-05-30 at 22:38 +0100, Bjoern Brandenburg wrote:
> On Sun, May 30, 2010 at 5:05 PM, Bjoern Brandenburg <bbb.lst@gmail.com> wrote:
> > On Sun, May 30, 2010 at 3:27 PM, Bjoern Brandenburg <bbb.lst@gmail.com> wrote:
> >>
> >> I'll try to see if I can pinpoint what was dropped between 2.6.33-arm1
> >> and 2.6.34-arm.
> >
> > Progress: I can get 2.6.34-arm to boot with all 4 CPUs after
> > cherry-picking the following commits (which seemed relevant but
> > absent):
> >
> > 60060ca ARM: Handle instruction cache maintenance fault  properly
> > 3f64e83 ARM errata: Eviction Buffer not empty after Cache Sync on L220
> > 3b009b5 ARM: change definition of cpu_relax() for ARM11MPCore
> >
> > Let's see which is the critical one...
> 
> It's 3f64e83 "ARM errata: Eviction Buffer not empty after Cache Sync
> on L220" [1]. With this commit cherry-picked (on top of the 'rebased'
> branch in ARM's repository, i.e., 2.6.34-arm), the system boots to X11
> and runs some simple FS tests; the other ones don't make a difference.
> 
> Are there plans for getting this and the other patches in the
> 'rebased' branch into mainline (for .35 or .36)?

Thanks for the investigation. I recall I got something similar in the
past though I could no longer reproduce it with 2.6.34 (-arm) on the
PB11MPCore I have. Could you try reverting commit e7c5650f606 (ARM:
Change the mandatory barriers implementation) on a vanilla 2.6.34
kernel?

I asked for clarification from hardware people here in ARM and the above
errata workaround doesn't seem apply to the L220 revision on the
PB11MPCore board (I need to reconfirm).

Anyway, some L220 revisions have an issue with a DSB followed by a cache
sync leading to hardware deadlock (this sequence was introduced in Linux
by the above commit). We could push the L220 erratum workaround (484863)
though the workaround I have implemented in the above commit is no
longer recommended in the errata document since it may cause other
problems with some L220 revisions.

-- 
Catalin
