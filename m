From: horms@verge.net.au (Simon Horman)
Date: Mon, 7 Jul 2014 11:21:42 +0200
Subject: [PATCH] ARM: convert all "mov.* pc, reg" to "bx reg" for ARMv6+
In-Reply-To: <E1X20Rs-00082S-KI@rmk-PC.arm.linux.org.uk>
References: <E1X20Rs-00082S-KI@rmk-PC.arm.linux.org.uk>
Message-ID: <20140707092142.GC3118@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 04:58:24PM +0100, Russell King wrote:
> ARMv6 and greater introduced a new instruction ("bx") which can be used
> to return from function calls.  Recent CPUs perform better when the
> "bx lr" instruction is used rather than the "mov pc, lr" instruction,
> and this sequence is strongly recommended to be used by the ARM
> architecture manual (section A.4.1.1).
> 
> We provide a new macro "ret" with all its variants for the condition
> code which will resolve to the appropriate instruction.
> 
> Rather than doing this piecemeal, and miss some instances, change all
> the "mov pc" instances to use the new macro, with the exception of
> the "movs" instruction and the kprobes code.  This allows us to detect
> the "mov pc, lr" case and fix it up - and also gives us the possibility
> of deploying this for other registers depending on the CPU selection.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

A conflict in next notification from Stephen Rothwell tells me that this
has made it there but regardless I would like to note that I have
successfully tested this on the following shmobile boards:
Genmai, Koelsh, Lager, Marzen, Bockw, APE6EVM, KZM9D, KZM9G,
Armadillo800 EVA and Mackerel. This covers all but one board (I do not
have access to a Henninger) and all SoCs supported in mainline.

Accordingly, the shmobile portion:

Tested-by: Simon Horman <horms+renesas@verge.net.au>
