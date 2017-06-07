From: davem@davemloft.net (David Miller)
Date: Wed, 07 Jun 2017 15:27:44 -0400 (EDT)
Subject: [PATCH net] bpf, arm64: use separate register for state in stxr
In-Reply-To: <530443d87bd51b3682a1b60ea19b2030d7d21409.1496834547.git.daniel@iogearbox.net>
References: <530443d87bd51b3682a1b60ea19b2030d7d21409.1496834547.git.daniel@iogearbox.net>
Message-ID: <20170607.152744.2250129714275096783.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Wed,  7 Jun 2017 13:45:37 +0200

> Will reported that in BPF_XADD we must use a different register in stxr
> instruction for the status flag due to otherwise CONSTRAINED UNPREDICTABLE
> behavior per architecture. Reference manual says [1]:
> 
>   If s == t, then one of the following behaviors must occur:
> 
>    * The instruction is UNDEFINED.
>    * The instruction executes as a NOP.
>    * The instruction performs the store to the specified address, but
>      the value stored is UNKNOWN.
> 
> Thus, use a different temporary register for the status flag to fix it.
> 
> Disassembly extract from test 226/STX_XADD_DW from test_bpf.ko:
> 
>   [...]
>   0000003c:  c85f7d4b  ldxr x11, [x10]
>   00000040:  8b07016b  add x11, x11, x7
>   00000044:  c80c7d4b  stxr w12, x11, [x10]
>   00000048:  35ffffac  cbnz w12, 0x0000003c
>   [...]
> 
>   [1] https://static.docs.arm.com/ddi0487/b/DDI0487B_a_armv8_arm.pdf, p.6132
> 
> Fixes: 85f68fe89832 ("bpf, arm64: implement jiting of BPF_XADD")
> Reported-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Applied, thanks Daniel.
