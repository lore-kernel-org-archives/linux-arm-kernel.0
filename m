From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Nov 2012 13:26:34 +0000
Subject: [PATCH] ARM: implement optimized percpu variable access
In-Reply-To: <20121127131742.GB16122@mudshark.cambridge.arm.com>
References: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
 <20121122113401.GC3113@mudshark.cambridge.arm.com>
 <50B2679F.3070107@gmail.com>
 <20121126111337.GA13312@mudshark.cambridge.arm.com>
 <20121126151534.GA13620@mudshark.cambridge.arm.com>
 <50B3A74F.20602@gmail.com>
 <20121127131742.GB16122@mudshark.cambridge.arm.com>
Message-ID: <20121127132634.GE19440@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 01:17:42PM +0000, Will Deacon wrote:
> I tried both Linaro 12.07 and 12.10 GCC builds, although the problem would
> only occur if I did a make clean and then a fresh build on top of that.
> Just building the relavant object files didn't seem to tickle the problem.

Given that the GCC optimiser does different things depending on the
direction the wind is blowing, that doesn't surprise me (anyone who's
looked at the output of modern gcc for even fairly simple functions
will know that how gcc optimises depends on a _lot_ of factors - even
what the preceding functions in the same compilation unit are.)

So I would not take too much into reading the output; if it's _possible_
for GCC to create an output which is not what we'd call correct, then
it's possible for it to create it, and because someone elses GCC doesn't
that's no reason to dismiss it (it could really be some subtle difference
causing the optimiser to behave slightly differently at that point.)

It _could_ be that the optimiser has decided on Jamie's test that it's
cheaper to recompute the percpu value, rather than yours where it's
decided to cache it on the stack.

So... if the point where the percpu stuff needs to be reloaded has a
compiler barrier, and that compiler barrier does not have an effect on
our percpu stuff being reloaded, then we still need to fix that.
