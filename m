From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Mon, 27 Feb 2017 11:23:21 -0800
Subject: [WARNING: A/V UNSCANNABLE][Merge tag 'media/v4.11-1' of git]
 ff58d005cd: BUG: unable to handle kernel NULL pointer dereference at 0000039c
In-Reply-To: <20170227154124.GA20569@gmail.com>
References: <58b07b30.9XFLj9Hhl7F6HMc2%fengguang.wu@intel.com>
 <CA+55aFytXj+TZ_TanbxcY0KgRTrV7Vvr=fWON8tioUGmYHYiNA@mail.gmail.com>
 <20170225090741.GA20463@gmail.com>
 <CA+55aFy+ER8cYV02eZsKAOLnZBWY96zNWqUFWSWT1+3sZD4XnQ@mail.gmail.com>
 <alpine.DEB.2.20.1702271105090.4732@nanos>
 <alpine.DEB.2.20.1702271231410.4732@nanos>
 <20170227154124.GA20569@gmail.com>
Message-ID: <CA+55aFxwtkOs95R-v7z8yjguvp91oDTxRKs-x3uN_=sM_33Gvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2017 at 7:41 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> BTW., instead of trying to avoid the scenario, wow about moving in the other
> direction: making CONFIG_DEBUG_SHIRQ=y unconditional property in the IRQ core code
> starting from v4.12 or so

The problem is that it's generally almost undebuggable ahead of time
by developers, and most users won't be able to do good reports either,
because the symptom is geberally a boot-time crash, often with no
logs.

So this option is *not* good for actual users. It's been tried before.

It's a wonderful thing for developers to run with to make sure the
drivers they are working on are resilient to this problem, but we have
too many legacy drivers and lots of random users, and it's unrealistic
to expect them to handle it.

In other words: what will happen is that distros start getting bootup
problem reports six months or a year after we've done it, and *if*
they figure out it's the irq enabling, they'll disable it, because
they have no way to solve it either.

And core developers will just maybe see the occasional "4.12 doesn't
boot for me" reports, but by then developers will ahve moved on to
4.16 or something.

So I don't disagree that in a perfect world all drivers should just
handle it. It's just that it's not realistic.

The fact that we have now *twice* gotten an oops report or a "this
machine doesn't boot" report etc within a week or so of merging the
problematic patch does *not* indicate that it's easy to fix or rare.

Quite the reverse.

It indicates that it's just rare enough that core developers don't see
it, but it's common enough to have triggered issues in random places.

And it will just get *much* worse when you then get the random
end-users that usually have older machines than the developers who
actually test daily development -git trees.

Then we'll just hit *other* random places, and without having testers
that are competent and willing or able to bisect or debug.

                  Linus
