From: peterz@infradead.org (Peter Zijlstra)
Date: Sat, 2 Dec 2017 14:59:52 +0100
Subject: [PATCH 0/5] crypto: arm64 - disable NEON across scatterwalk API
 calls
In-Reply-To: <CAKv+Gu_DMVYX8y-8JJwyxy2rF0+6ofSWyjwpvwuF042ievBb7w@mail.gmail.com>
References: <20171201211927.24653-1-ard.biesheuvel@linaro.org>
 <20171202090107.GT3326@worktop>
 <CAKv+Gu-dG0Zc35NZZ85U36K2TXCpN+wJTYOyjkhxRjXbdiJTAQ@mail.gmail.com>
 <CAKv+Gu_DMVYX8y-8JJwyxy2rF0+6ofSWyjwpvwuF042ievBb7w@mail.gmail.com>
Message-ID: <20171202135952.GX3326@worktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 02, 2017 at 11:15:14AM +0000, Ard Biesheuvel wrote:
> On 2 December 2017 at 09:11, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> > They consume the entire input in a single go, yes. But making it more
> > granular than that is going to hurt performance, unless we introduce
> > some kind of kernel_neon_yield(), which does a end+begin but only if
> > the task is being scheduled out.
> >
> > For example, the SHA256 keeps 256 bytes of round constants in NEON
> > registers, and reloading those from memory for each 64 byte block of
> > input is going to be noticeable. The same applies to the AES code
> > (although the numbers are slightly different)
> 
> Something like below should do the trick I think (apologies for the
> patch soup). I.e., check TIF_NEED_RESCHED at a point where only very
> few NEON registers are live, and preserve/restore the live registers
> across calls to kernel_neon_end + kernel_neon_begin. Would that work
> for RT?

Probably yes. The important point is that preempt latencies (and thus by
extension NEON regions) are bounded and preferably small.

Unbounded stuff (like depends on the amount of data fed) are a complete
no-no for RT since then you cannot make predictions on how long things
will take.
