From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Sat, 10 Jan 2015 13:48:10 -0800
Subject: Linux 3.19-rc3
In-Reply-To: <10028397.kdbz8TfPck@wuerfel>
References: <CA+55aFwsxoyLb9OWMSCL3doe_cz_EQtKsEFCyPUYn_T87pbz0A@mail.gmail.com>
 <4665410.x9Uu42bKmJ@wuerfel>
 <CA+55aFxphoLdFkwkVFQ87Q8EbYNqFAE-n0yTvCSOJzSO2MtDgw@mail.gmail.com>
 <10028397.kdbz8TfPck@wuerfel>
Message-ID: <CA+55aFy4v3zOQDS62ECDD-WtjbbzdFxGOT1tNSuGy5ChzM4JGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 10, 2015 at 1:36 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>>  (d) the powerpc TLB fill/buildup/teardown costs are horrible, so on
>> AIX the cost of lots of small pages is much higher too.
>
> I think (d) applies to ARM as well, since it has no hardware
> dirty/referenced bit tracking and requires the OS to mark the
> pages as invalid/readonly until the first access. ARMv8.1
> has a fix for that, but it's optional and we haven't seen any
> implementations yet.

Powerpc really makes things worse by having those hashed page tables
that (a) have bad locality and (b) have to be built up and torn down
in software. I don't think ARM ends up coming close, even with the
issues it has.

Now, it's definitely true that the x86 page table handling hadrware
tends to just be superior. Both Intel and AMD had to work really hard
on it, because Windows (in the pre-NT days) used to flush the TLB
absolutely _all_ the time.  So x86 hardware really does tend to do
very well on this.

ARM simply doesn't have the same kind of history. TLB issues seldom
show up very much on simple benchmarks or on smaller loads. It's one
of those things that tends to take a couple of generations.

[ Or, sadly, _much_ more, because some hardware designers never get
the memo, and continue to blame software and say "you should use big
pages", because they don't see the problems ]

Of course, it's entirely possible that vendors like AMD coudl transfer
their TLB handling know-how to their ARM64 cores. I have no visibility
into that, maybe some people here do..

                      Linus
