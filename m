From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 Nov 2009 15:13:16 +0000
Subject: CAS implementation may be broken
In-Reply-To: <4B08055C.3000408@45mercystreet.com>
References: <4B08055C.3000408@45mercystreet.com>
Message-ID: <1258989196.8088.28.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2009-11-21 at 15:21 +0000, Toby Douglass wrote:
> I may be *utterly* wrong, and I'm expecting that someone here is simply
> going to look at what I'm about to say and explain to me what I've
> misunderstood, but I suspect it may be that atomic compare-and-swap is
> incorrectly implemented in the Linux kernel on ARM v6 and above (e.g.
> using ldrex and strex).

Well, you have to define "correctly" or you may just need a different
function for what you want. In this implementation, CAS is expected to
succeed if the the old value matches the memory one. The loop is present
to always guarantee that it will succeed if the condition matches.

Note that the exclusive monitor state is cleared (and hence STREX fails)
a every context switch or a return from an exception, i.e. interrupt).
> 
> The issue is the ABA problem.
[...]
> The problem is *we then come round in the do-while loop again*.  We have
> *not* updated our exchange value.  So THIS second time around, we
> *repeat* our strex and we DO swap - and we just swapped in completely
> the wrong next pointer, from way back before the stack was totally
> changed by all the other threads popping and pushing.

But the first thread (paused) one may may actually wait before the LDREX
(the old value was loaded with an LDR), so the LDREX/STREX pair would
succeed anyway. That's not really a solution unless you also use LDREX
for loading the old value to be passed to CAS. IOW, you need your own
implementation of what you are trying to achieve (and not modifying
CAS).

-- 
Catalin
