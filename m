From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 11 Nov 2015 18:57:41 +0100
Subject: [PATCH 2/2] arm64: bpf: add BPF XADD instruction
In-Reply-To: <20151111.123548.1039494689070388545.davem@davemloft.net>
References: <56436420.9090401@iogearbox.net> <20151111162341.GN9562@arm.com>
 <20151111172659.GA86334@ast-mbp.thefacebook.com>
 <20151111.123548.1039494689070388545.davem@davemloft.net>
Message-ID: <20151111175741.GR17308@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2015 at 12:35:48PM -0500, David Miller wrote:
> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Date: Wed, 11 Nov 2015 09:27:00 -0800
> 
> > BPF_XADD == atomic_add() in kernel. period.
> > we are not going to deprecate it or introduce something else.
> 
> Agreed, it makes no sense to try and tie C99 or whatever atomic
> semantics to something that is already clearly defined to have
> exactly kernel atomic_add() semantics.

Dave, this really doesn't make any sense to me. __sync primitives have
well defined semantics and (e)BPF is violating this.

Furthermore, the fetch_and_add (or XADD) name has well defined
semantics, which (e)BPF also violates.

Atomicy is hard enough as it is, backends giving random interpretations
to them isn't helping anybody.

It also baffles me that Alexei is seemingly unwilling to change/rev the
(e)BPF instructions, which would be invisible to the regular user, he
does want to change the language itself, which will impact all
'scripts'.
