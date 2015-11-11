From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Wed, 11 Nov 2015 10:11:33 -0800
Subject: [PATCH 2/2] arm64: bpf: add BPF XADD instruction
In-Reply-To: <20151111175741.GR17308@twins.programming.kicks-ass.net>
References: <56436420.9090401@iogearbox.net> <20151111162341.GN9562@arm.com>
 <20151111172659.GA86334@ast-mbp.thefacebook.com>
 <20151111.123548.1039494689070388545.davem@davemloft.net>
 <20151111175741.GR17308@twins.programming.kicks-ass.net>
Message-ID: <20151111181132.GA90947@ast-mbp.thefacebook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2015 at 06:57:41PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 11, 2015 at 12:35:48PM -0500, David Miller wrote:
> > From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Date: Wed, 11 Nov 2015 09:27:00 -0800
> > 
> > > BPF_XADD == atomic_add() in kernel. period.
> > > we are not going to deprecate it or introduce something else.
> > 
> > Agreed, it makes no sense to try and tie C99 or whatever atomic
> > semantics to something that is already clearly defined to have
> > exactly kernel atomic_add() semantics.
> 
> Dave, this really doesn't make any sense to me. __sync primitives have
> well defined semantics and (e)BPF is violating this.

bpf_xadd was never meant to be __sync_fetch_and_add equivalent.
>From the day one it meant to be atomic_add() as kernel does it.
I did piggy back on __sync in the llvm backend because it was the quick
and dirty way to move forward.
In retrospect I should have introduced a clean intrinstic for that instead,
but it's not too late to do it now. user space we can change at any time
unlike kernel.

> Furthermore, the fetch_and_add (or XADD) name has well defined
> semantics, which (e)BPF also violates.

bpf_xadd also didn't meant to be 'fetch'. It was void return from the beginning.

> Atomicy is hard enough as it is, backends giving random interpretations
> to them isn't helping anybody.

no randomness. bpf_xadd == atomic_add() in kernel.
imo that is the simplest and cleanest intepretantion one can have, no?

> It also baffles me that Alexei is seemingly unwilling to change/rev the
> (e)BPF instructions, which would be invisible to the regular user, he
> does want to change the language itself, which will impact all
> 'scripts'.

well, we cannot change it in kernel because it's ABI.
I'm not against adding new insns. We definitely can, but let's figure out why?
Is anything broken? No. So what new insns make sense?
Add new one that does 'fetch_and_add' ? What is the real use case it
will be used for?
Adding new intrinsic to llvm is not a big deal. I'll add it as soon
as I have time to work on it or if somebody beats me to it I would be
glad to test it and apply it.
