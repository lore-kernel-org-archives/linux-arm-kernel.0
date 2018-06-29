From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 29 Jun 2018 12:04:22 +0100
Subject: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180628105057.GA26019@e103592.cambridge.arm.com>
 <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
Message-ID: <20180629110419.GC26019@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 08:56:41PM +0200, Andrey Konovalov wrote:
> On Thu, Jun 28, 2018 at 12:51 PM, Dave Martin <Dave.Martin@arm.com> wrote:
> > On Tue, Jun 26, 2018 at 03:15:10PM +0200, Andrey Konovalov wrote:
> >> 1. By using the Top Byte Ignore arm64 CPU feature, we can store pointer
> >>    tags in the top byte of each kernel pointer.
> >
> > [...]
> >
> > This is a change from the current situation, so the kernel may be
> > making implicit assumptions about the top byte of kernel addresses.
> >
> > Randomising the top bits may cause things like address conversions and
> > pointer arithmetic to break.
> >
> > For example, (q - p) will not produce the expected result if q and p
> > have different tags.
> 
> If q and p have different tags, that means they come from different
> allocations. I don't think it would make sense to calculate pointer
> difference in this case.

It's not strictly valid to subtract pointers from different allocations
in C, but it's hard to prove statically that two pointers are guaranteed
to point into the same allocation.

It's likely that we're getting away with it in some places today.

> > Conversions, such as between pointer and pfn, may also go wrong if not
> > appropriately masked.
> >
> > There are also potential pointer comparison and aliasing issues if
> > the tag bits are ever stripped or modified.
> >
> >
> > What was your approach to tracking down all the points in the code
> > where we have a potential issue?
> 
> I've been fuzzing the kernel built with KWHASAN with syzkaller. This
> gives a decent coverage and I was able to find some places where
> fixups were required this way. Right now the fuzzer is running without
> issues. It doesn't prove that all such places are fixed, but I don't
> know a better way to test this.

Can sparse be hacked to identify pointer subtractions where the pointers
are cannot be statically proved to point into the same allocation?

Maybe the number of hits for this wouldn't be outrageously high, though
I expect there would be a fair number.

Tracking pointers that have been cast to integer types is harder.
Ideally we'd want to do that, to flag up potentially problematic
masking and other similar hacks.

Cheers
---Dave
