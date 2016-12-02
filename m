From: joseph@codesourcery.com (Joseph Myers)
Date: Fri, 2 Dec 2016 16:59:27 +0000
Subject: [RFC PATCH 00/29] arm64: Scalable Vector Extension core
 support
In-Reply-To: <faabab1d-fafb-2bd1-200f-b0e3ba17e1d5@redhat.com>
References: <20161130120654.GJ1574@e103592.cambridge.arm.com>
 <3e8afc5a-1ba9-6369-462b-4f5a707d8b8a@redhat.com>
 <20161202114850.GQ1574@e103592.cambridge.arm.com>
 <faabab1d-fafb-2bd1-200f-b0e3ba17e1d5@redhat.com>
Message-ID: <alpine.DEB.2.20.1612021648580.16956@digraph.polyomino.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2 Dec 2016, Florian Weimer wrote:

> > However, it would be necessary to prevent GCC from moving any code
> > across these statements -- in particular, SVE code that access VL-
> > dependent data spilled on the stack is liable to go wrong if reordered
> > with the above.  So the sequence would need to go in an external
> > function (or a single asm...)
> 
> I would talk to GCC folks?we have similar issues with changing the FPU
> rounding mode, I assume.

In general, GCC doesn't track the implicit uses of thread-local state 
involved in floating-point exceptions and rounding modes, and so doesn't 
avoid moving code across manipulations of such state; there are various 
open bugs in this area (though many of the open bugs are for local rather 
than global issues with code generation or local optimizations not 
respecting exceptions and rounding modes, which are easier to fix).  Hence 
glibc using various macros such as math_opt_barrier and math_force_eval 
which use asms to prevent such motion.

I'm not familiar enough with the optimizers to judge the right way to 
address such issues with implicit use of thread-local state.  And I 
haven't thought much yet about how to implement TS 18661-1 constant 
rounding modes, which would involve the compiler implicitly inserting 
rounding modes changes, though I think it would be fairly straightforward 
given underlying support for avoiding inappropriate code motion.

-- 
Joseph S. Myers
joseph at codesourcery.com
