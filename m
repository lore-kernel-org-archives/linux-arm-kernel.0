From: ralf@linux-mips.org (Ralf Baechle)
Date: Wed, 27 Jan 2016 11:40:32 +0100
Subject: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <20160115004753.GN3818@linux.vnet.ibm.com>
References: <5696CF08.8080700@imgtec.com> <20160114121449.GC15828@arm.com>
 <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com>
 <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <569814F2.50801@imgtec.com>
 <20160114225510.GJ3818@linux.vnet.ibm.com>
 <56983054.4070807@imgtec.com>
 <20160115004753.GN3818@linux.vnet.ibm.com>
Message-ID: <20160127104032.GB2939@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 04:47:53PM -0800, Paul E. McKenney wrote:

> So you need to build a different kernel for some types of MIPS systems?

Yes.  We can't really do without.  Classic MIPS code is not relocatable
without the complexity of PIC code as used by ELF DSOs - and their
performanc penalty.  Plus we have a number of architecture revisions
ovr the decades, big and little endian, 32 and 64 bit as the major
stumbling stones.  There however are groups of similar systems that
can share kernel binaries.

> Or do you do boot-time rewriting, like a number of other arches do?

We don't rewrite the code (as in the .text of the vmlinux binary) but we
do runtime code generation for a few highly performance sensitive area
of the kernel code such as copy_page() or TLB exception handlers.  This
allows more flexibility than just inserting templates into the kernel
code.  Downside - it means we have some of the complexity of as and ld
in the kernel.

  Ralf
