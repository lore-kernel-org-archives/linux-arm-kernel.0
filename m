From: bhe@redhat.com (Baoquan He)
Date: Sat, 28 May 2016 19:28:42 +0800
Subject: [PATCH kexec-tools 05/32] arm: fix kdump to work on LPAE systems
In-Reply-To: <E1axXSK-0004hN-V7@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXSK-0004hN-V7@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <20160528112842.GA2429@x1.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/16 at 11:21am, Russell King wrote:
> We need to use 64-bit file IO when mapping system memory and the core
> dump file as we may be running on a LPAE system, otherwise we risk
> mapping memory we shouldn't, and causing a kernel oops:
> 
> Unhandled fault: asynchronous external abort (0x211) at 0x00000000
> pgd = edd2c740
> [00000000] *pgd=82ec98003, *pmd=82dcd2003, *pte=00000000
> 
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>
> ---
>  kexec/arch/arm/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
> index 38137d7..60e433a 100644
> --- a/kexec/arch/arm/Makefile
> +++ b/kexec/arch/arm/Makefile
> @@ -18,6 +18,9 @@ libfdt_SRCS += $(LIBFDT_SRCS:%=kexec/libfdt/%)
>  
>  arm_CPPFLAGS = -I$(srcdir)/kexec/libfdt
>  
> +# We want 64-bit file IO for kdump to work correctly on LPAE systems
> +arm_CPPFLAGS += -D_FILE_OFFSET_BITS=64
> +

It makes sense in this situation.

In "man 2 stat" and /usr/include/features.h, we can find the relevant
information.

EOVERFLOW
	pathname or fd refers to a file whose size, inode number, or number
	of blocks cannot be represented in, respectively, the types off_t, ino_t,
	or blkcnt_t.  This error can occur when, for example, an  application
	compiled  on  a  32-bit  platform  without -D_FILE_OFFSET_BITS=64 calls
	stat() on a file whose size exceeds (1<<31)-1 bytes.

Ack this patch.

Acked-by: Baoquan He <bhe@redhat.com>

Baoquan
Thanks
