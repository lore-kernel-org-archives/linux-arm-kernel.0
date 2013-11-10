From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 10 Nov 2013 00:03:42 -0500 (EST)
Subject: [PATCH v2] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <1383951632-6090-1-git-send-email-sboyd@codeaurora.org>
References: <1383951632-6090-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <alpine.LFD.2.10.1311092357090.2314@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Nov 2013, Stephen Boyd wrote:

> If we're running on a v7 ARM CPU, detect if the CPU supports the
> sdiv/udiv instructions and replace the signed and unsigned
> division library functions with an sdiv/udiv instruction.
> 
> Running the perf messaging benchmark in pipe mode
> 
>  $ perf bench sched messaging -p
> 
> shows a modest improvement on my v7 CPU.
> 
> before:
> (5.060 + 5.960 + 5.971 + 5.643 + 6.029 + 5.665 + 6.050 + 5.870 + 6.117 + 5.683) / 10 = 5.805
> 
> after:
> (4.884 + 5.549 + 5.749 + 6.001 + 5.460 + 5.103 + 5.956 + 6.112 + 5.468 + 5.093) / 10 = 5.538
> 
> (5.805 - 5.538) / 5.805 = 4.6%
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Bah..... NAK.

We are doing runtime patching of the kernel for many many things
already.  So why not do the same here?

The obvious strategy is to simply overwrite the start of the existing 
__aeabi_idiv code with the "sdiv r0, r0, r1" and "bx lr" opcodes.  

Similarly for the unsigned case.

That let you test the hardware capability only once during boot instead 
of everytime a divide operation is performed.


Nicolas
