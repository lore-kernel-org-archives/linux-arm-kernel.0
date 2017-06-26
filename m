From: danielmicay@gmail.com (Daniel Micay)
Date: Mon, 26 Jun 2017 18:52:31 -0400
Subject: [kernel-hardening] non-x86 per-task stack canaries
In-Reply-To: <CAGXu5jLCAdPOKZFotaWZ8MjwqW8Eq9_tLc_fgbYsTcbVWv77AQ@mail.gmail.com>
References: <CAGXu5jLCAdPOKZFotaWZ8MjwqW8Eq9_tLc_fgbYsTcbVWv77AQ@mail.gmail.com>
Message-ID: <1498517551.22457.7.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-06-26 at 14:04 -0700, Kees Cook wrote:
> Hi,
> 
> The stack protector functionality on x86_64 uses %gs:0x28 (%gs is the
> percpu area) for __stack_chk_guard, and all other architectures use a
> global variable instead. This means we never change the stack canary
> on non-x86 architectures which allows for a leak in one task to expose
> the canary in another task.
> 
> I'm curious what thoughts people may have about how to get this
> correctly implemented. Teaching the compiler about per-cpu data sounds
> exciting. :)
> 
> -Kees

arm64 has many integer registers so I don't think reserving one would
hurt performance, especially in the kernel where hot numeric loops
barely exist. It would reduce the cost of SSP by getting rid of the
memory read for the canary value. On the other hand, using per-cpu data
would likely be higher cost than the global. x86 has segment registers
but most archs probably need to do something more painful.

It's safe as long as it's a callee-saved register. It should be enforced
that there's no assembly spilling it and calling into C code without the
random canary. There's very little assembly using registers like x28 so
it wouldn't be that bad. It's possible there's one where nothing needs
to be changed, there only needs to be a check to make sure it stays that
way.

It would be a step towards making SSP cheap enough to expand it into a
feature like the StackGuard XOR canaries.

Samsung has a return address XOR feature based on reserving a register
and while RAP's probabilistic return address mitigation isn't open-
source, it was stated that it reserves a register on x86_64 where they
aren't as plentiful as arm64.
