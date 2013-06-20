From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 20 Jun 2013 10:43:33 +0200
Subject: BUG: commit "ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on pre-ARMv6
 CPUs" breaks armv5 with CONFIG_PREEMPT
Message-ID: <51C2C0B5.8020802@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Catalin,

on current linus/master on armv5 we observed stack trashing[1] on high
load. I bisected this problem down to commit:

> b9d4d42ad901cc848ac87f1cb8923fded3645568 is the first bad commit
> commit b9d4d42ad901cc848ac87f1cb8923fded3645568
> Author: Catalin Marinas <catalin.marinas@arm.com>
> Date:   Mon Nov 28 21:57:24 2011 +0000
> 
>     ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on pre-ARMv6 CPUs
> 
>     This patch removes the __ARCH_WANT_INTERRUPTS_ON_CTXSW definition for
>     ARMv5 and earlier processors. On such processors, the context switch
>     requires a full cache flush. To avoid high interrupt latencies, this
>     patch defers the mm switching to the post-lock switch hook if the
>     interrupts are disabled.
> 
>     Reviewed-by: Will Deacon <will.deacon@arm.com>
>     Tested-by: Will Deacon <will.deacon@arm.com>
>     Reviewed-by: Frank Rowand <frank.rowand@am.sony.com>
>     Tested-by: Marc Zyngier <Marc.Zyngier@arm.com>
>     Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> :040000 040000 034899bdcbc9aa59b5455a85a9d78b646b4cf784 ecc23e33a4ca807d4153f87fbea85a9437ff2928 M      arch

The problem can be reproduced on several mx28 and an at91sam9263 and
only occurs of CONFIG_PREEMPT (Preemptible Kernel (Low-Latency Desktop))
is enabled.

I have the gut feeling that the "if (irqs_disabled())" check in the
above patch is not correct for CONFIG_PREEMPT.

Marc

[1] The test program creating 150 threads in a row crashes like this:
> [8]+  Segmentation fault         ./thread_test_c
> [5]   Illegal instruction        ./thread_test_c
> [4]   Illegal instruction        ./thread_test_c
> [2]   Segmentation fault         ./thread_test_c
> [3]   Illegal instruction        ./thread_test_c
> [1]   Segmentation fault         ./thread_test_c

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130620/11a01756/attachment-0001.sig>
