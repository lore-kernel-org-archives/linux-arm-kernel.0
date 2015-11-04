From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Wed, 4 Nov 2015 14:55:01 -0800
Subject: [GIT PULL] arm64 updates for 4.4
In-Reply-To: <20151104182508.GA28726@e104818-lin.cambridge.arm.com>
References: <20151104182508.GA28726@e104818-lin.cambridge.arm.com>
Message-ID: <CA+55aFw3Y4x0RQPjgkZSV=NkXEoMWTq7AYRBpkqd-KMt6om6sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 4, 2015 at 10:25 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> - Support for 16KB pages, with the additional bonus of a 36-bit VA
>   space, though the latter only depending on EXPERT

So I told the ppc people this many years ago, and I guess I'll tell
you guys too: 16kB pages are not actually useful, and anybody who
thinks they are have not actually done the math.

It ends up being a horrible waste of memory for things like the page
cache, to the point where all the arguments for it ("it allows us to
manage lots of memory more cheaply") are pure and utter BS, because
you effectively lose half of that memory to fragmentation in pretty
much all normal loads.

It's good for single-process loads - if you do a lot of big fortran
jobs, or a lot of big database loads, and nothing else, you're fine.
Or if you are an embedded OS and only haev one particular load you
worry about.

But it is really really nasty for any general-purpose stuff, and when
your hardware people tell you that it's a great way to make your TLB's
more effective, tell them back that they are incompetent morons, and
that they should just make their TLB's better.

Because they are.

To make them understand the problem, compare it to having a 256-byte
cacheline. They might understand it then, because you're talking about
things that they almost certainly *also* wanted to do, but did the
numbers on, and realized it was bad.

And on the other hand, if they go "Hmm. 256-byte cache lines? We
should do that too", then you know they are not worth your time, and
you can quietly tell your bosses that they should up the medication in
the watercooler in the hw lab.

                      Linus
