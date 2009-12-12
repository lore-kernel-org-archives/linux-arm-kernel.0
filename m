From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Dec 2009 11:28:29 +0000
Subject: [PATCH 5/6] ARMv7: Improved page table format with TRE and AFE
In-Reply-To: <20091207141404.30429.85379.stgit@pc1117.cambridge.arm.com>
References: <20091207135603.30429.74812.stgit@pc1117.cambridge.arm.com>
	<20091207141404.30429.85379.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091212112829.GB27020@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2009 at 02:14:10PM +0000, Catalin Marinas wrote:
> This patch enables the Access Flag in SCTLR and, together with the TEX
> remapping, allows the use of the spare bits in the page table entry thus
> removing the Linux specific PTEs. The simplified permission model is
> used which means that "kernel read/write, user read-only" is no longer
> available. This was used for the vectors page but with a dedicated TLS
> register it is no longer necessary.

I really do not want to go here without an explaination of how situations
such as:

- Kernel reads PTE and modifies it
- Hardware accesses page
-  TLB reads PTE, updates, and writes new back
- Kernel writes PTE back
- Kernel cleans cache line

are handled.  What about SMP, where CPU0 may access and modify the active
page tables on CPU1 (eg, clearing PTEs)?

Are TLB accesses with AFE enabled guaranteed to read from the L1 cache?
If not, we need to clean _and_ invalidate PTE updates.
