From: dvyukov@google.com (Dmitry Vyukov)
Date: Fri, 24 Nov 2017 08:52:38 +0100
Subject: [PATCH v2 18/18] arm64: select ARCH_SUPPORTS_LTO_CLANG
In-Reply-To: <CAG_fn=UsmiQCXmdbED_SxgBj=xR0u0_mPS2+EhF0Me1ACBfWzw@mail.gmail.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-19-samitolvanen@google.com>
 <20171116115810.GH9361@arm.com>
 <20171116161731.GA94341@samitolvanen.mtv.corp.google.com>
 <20171116163054.kcsdsomr7u2mqql2@hirez.programming.kicks-ass.net>
 <CAKwvOdkV_g0XAbGM+nF2zt=2+tHLLcj=pbSxRDd2HMbrtU3cZg@mail.gmail.com>
 <20171116165922.llrojrvomuihabrt@hirez.programming.kicks-ass.net>
 <CAKwvOd=k=iVQvWmzP1E3XHUCYLoJgx+F9zoPuE+R2oaw_ePUVA@mail.gmail.com>
 <20171116173417.nqsh5dpu65uj7b5s@hirez.programming.kicks-ass.net>
 <20171116174830.GX3624@linux.vnet.ibm.com>
 <CAKwvOdkDz1yRo=Skt_mWxs0uucK+adXx8kFQksMbTE3ofnpUMQ@mail.gmail.com>
 <CAG_fn=UsmiQCXmdbED_SxgBj=xR0u0_mPS2+EhF0Me1ACBfWzw@mail.gmail.com>
Message-ID: <CACT4Y+bBN=R21nLtFavArK55D0=zGiYe14AjGxtWv=R1D+s8jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 23, 2017 at 2:42 PM, Alexander Potapenko <glider@google.com> wrote:
>>>> > >> > Ideally we'd get the toolchain people to commit to supporting the kernel
>>>> > >> > memory model along side the C11 one. That would help a ton.
>>>> > >>
>>>> > >> Does anyone from the kernel side participate in the C standardization process?
>>>> > >
>>>> > > Yes, Paul McKenney and Will Deacon. Doesn't mean these two can still be
>>>> > > reconciled though. From what I understand C11 (and onwards) are
>>>> > > incompatible with the kernel model on a number of subtle points.
>>>> >
>>>> > It would be good to have these incompatibilities written down, then
>>>> > for the sake of argument, they can be cited both for discussions on
>>>> > LKML and in the C standardization process.  For example, a running
>>>> > list in Documentation/ or something would make it so that anyone could
>>>> > understand and cite current issues with the latest C standard.
>>>>
>>>> Will should be able to produce this list; I know he's done before, I
>>>> just can't find it -- my Google-foo isn't strong today.
>>>
>>> Here you go:
>>>
>>> http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2017/p0124r4.html
>>
>> Great, thanks! Will take some time to digest, but happy to refer
>> others to this important work in the future.
>>
>> I wonder if we have anything like a case study that shows specifically
>> how a compiler generated a subtle bug due to specifics of the memory
>> model, like a "if you do this, here's the problematic code that will
>> get generated, and why it's problematic due to the memory model."
>> That may be a good way to raise issues with toolchain developers with
>> concrete and actionable examples.
>>
>>>> > I don't understand why we'd block patches for enabling experimental
>>>> > features.  We've been running this patch-set on actual devices for
>>>> > months and would love to provide them to the community for further
>>>> > testing.  If bugs are found, then there's more evidence to bring to
>>>> > the C standards committee.  Otherwise we're shutting down feature
>>>> > development for the sake of potential bugs in a C standard we're not
>>>> > even using.
>>>>
>>>> So the problem is that its very very hard (and painful) to find these
>>>> bugs. Getting the tools people to comment on these specific
>>>> optimizations would really help lots.
>>
>> No doubt; I do not disagree with you.  Kernel developers have very
>> important use cases for the language.
>>
>> But the core point I'm trying to make is "do we need to block this
>> patch set until issues with the C standards body in regards to the
>> kernels memory model are resolved?"  I would hope the two are
>> orthogonal and that we'd take them and then test them even more
>> extensively than the developer has in order to find out.
>>
>>> It would be good to get something similar to LKMM into KTSAN, for
>>> example.  There would probably be a few differences due to efficiency
>>> concerns, but closer is better than less close.  ;-)
>>
>> + glider, who may be able to comment on the state of KTSAN.
> We haven't touched KTSAN for a while, so it's probably broken right now.
> It should be possible to revive it, the question is how much code will
> need to be annotated to prevent the tool from overwhelming the
> developers with reports.
> +Dima and Andrey, who should know better.

Hi,

KTSAN checks acquire/release pairs, and that's very useful. But as far
as I understand this thread is about more subtle things and areas of
kernel/compiler tension. I afraid this in this context KTSAN is in the
same boat as compiler. Because, well, we need to write code that
implements precise algorithms. And if control-dependencies are defined
as "extreme care is required to avoid control-dependency-destroying
compiler optimizations" (that is, code is correct if it does not break
against the current set of enabled optimizations in the current
compiler, what?) and data-dependencies are defined akin to C11
definition (read -- non-implementable, unicorns); then KTSAN can't
help.

When/if C provides implementable rules for data-dependencies
(_Dependency) and that's implemented in compilers and kernel sticks to
this model, then I guess it should be possible to extract that info
from compiler and check against it in KTSAN (e.g. 2 synchronization
domains, one for dependent accesses and one for everything else).
Kernel could as well define own model, and KTSAN could check against
it. But that model must be implemented in compilers first anyway.
Because (1) doing it just for KTSAN does not look reasonable, (2)
until compiler supports that model there is little point in checking
(the fact that compiler uses a different model is the major gaping
hole and we are aware of it without tooling help).

And, yes, I agree that we should not block this LTO patch. All
problems are already there and are orthogonal to LTO. Compiler sees
enough code already (large TUs, lots of code in headers) and we move
code. I also have not seen any special rules wrt rcu and translation
units, I have not seen developers doing any additional analysis re
TUs, move code to separate files, nor I seen comments says that this
code must be in separate TU than that code. From what I see usually
it's assumed that things will just work. If anything LTO will be
useful to shake out latent bugs that will pop up later.
