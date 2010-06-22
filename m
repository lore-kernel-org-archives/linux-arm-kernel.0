From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 22 Jun 2010 16:47:03 +0400
Subject: [PATCH v4 1/4] ARM: Remove the domain switching on ARMv6k/v7 CPUs
In-Reply-To: <20100621144626.26309.59790.stgit@e102109-lin.cambridge.arm.com>
References: <20100621144409.26309.87173.stgit@e102109-lin.cambridge.arm.com>
	<20100621144626.26309.59790.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100622124703.GA12613@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 21, 2010 at 03:46:26PM +0100, Catalin Marinas wrote:
> This patch removes the domain switching functionality via the set_fs and
> __switch_to functions on cores that have a TLS register.
> 
> Currently, the ioremap and vmalloc areas share the same level 1 page
> tables and therefore have the same domain (DOMAIN_KERNEL). When the
> kernel domain is modified from Client to Manager (via the __set_fs or in
> the __switch_to function), the XN (eXecute Never) bit is overridden and
> newer CPUs can speculatively prefetch the ioremap'ed memory.
> 
> Linux performs the kernel domain switching to allow user-specific
> functions (copy_to/from_user, get/put_user etc.) to access kernel
> memory. In order for these functions to work with the kernel domain set
> to Client, the patch modifies the LDRT/STRT and related instructions to
> the LDR/STR ones.
> 
> The user pages access rights are also modified for kernel read-only
> access rather than read/write so that the copy-on-write mechanism still
> works. CPU_USE_DOMAINS gets disabled only if HAS_TLS_REG is defined
> since writing the TLS value to the high vectors page isn't possible.
> 
> The user addresses passed to the kernel are checked by the access_ok()
> function so that they do not point to the kernel space.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

I tested this on ARMv6K (ARM11 MPcore) and ARMv7 (Cortex-A9), and
didn't notice any issues. This is also needed for robust mutextes
support... so, if that helps,

Tested-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!
