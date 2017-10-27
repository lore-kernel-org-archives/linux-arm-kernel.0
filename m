From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 Oct 2017 14:04:11 +0100
Subject: [PATCH v4 19/28] arm64/sve: ptrace and ELF coredump support
In-Reply-To: <1509101470-7881-20-git-send-email-Dave.Martin@arm.com>
References: <1509101470-7881-1-git-send-email-Dave.Martin@arm.com>
 <1509101470-7881-20-git-send-email-Dave.Martin@arm.com>
Message-ID: <20171027130411.qc2ee2z5ywocnvnw@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 27, 2017 at 11:51:01AM +0100, Dave P Martin wrote:
> This patch defines and implements a new regset NT_ARM_SVE, which
> describes a thread's SVE register state.  This allows a debugger to
> manipulate the SVE state, as well as being included in ELF
> coredumps for post-mortem debugging.
> 
> Because the regset size and layout are dependent on the thread's
> current vector length, it is not possible to define a C struct to
> describe the regset contents as is done for existing regsets.
> Instead, and for the same reasons, NT_ARM_SVE is based on the
> freeform variable-layout approach used for the SVE signal frame.
> 
> Additionally, to reduce debug overhead when debugging threads that
> might or might not have live SVE register state, NT_ARM_SVE may be
> presented in one of two different formats: the old struct
> user_fpsimd_state format is embedded for describing the state of a
> thread with no live SVE state, whereas a new variable-layout
> structure is embedded for describing live SVE state.  This avoids a
> debugger needing to poll NT_PRFPREG in addition to NT_ARM_SVE, and
> allows existing userspace code to handle the non-SVE case without
> too much modification.
> 
> For this to work, NT_ARM_SVE is defined with a fixed-format header
> of type struct user_sve_header, which the recipient can use to
> figure out the content, size and layout of the reset of the regset.
> Accessor macros are defined to allow the vector-length-dependent
> parts of the regset to be manipulated.
> 
> Signed-off-by: Alan Hayward <alan.hayward@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Alex Benn?e <alex.bennee@linaro.org>
> Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
