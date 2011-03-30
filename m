From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Mar 2011 18:52:36 +0100
Subject: [PATCH] ARM: vfp: Remote obsolete fpmx_state field from
	vfp_hard_struct
In-Reply-To: <1301489184-4112-2-git-send-email-dave.martin@linaro.org>
References: <1301489184-4112-1-git-send-email-dave.martin@linaro.org>
	<1301489184-4112-2-git-send-email-dave.martin@linaro.org>
Message-ID: <20110330175236.GB2939@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 01:46:24PM +0100, Dave Martin wrote:
> The fpmx_state field was presumably used in the past, when
> FSTMX/FLDMX were used to save and resture the VFP state.
> 
> This was been deprecated since ARMv6, the context switch code
> has been ported to use the double-precision load/store variants
> many years ago, and now it appears that nothing in the kernel
> references this field any more.

Wrong.

        .macro  VFPFSTMIA, base, tmp
#if __LINUX_ARM_ARCH__ < 6
        STC     p11, cr0, [\base],#33*4             @ FSTMIAX \base!, {d0-d15}
#else
        STC     p11, cr0, [\base],#32*4             @ FSTMIAD \base!, {d0-d15}
#endif

So, building for pre-ARMv6, it's still used.
