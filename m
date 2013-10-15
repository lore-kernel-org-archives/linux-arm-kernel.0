From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 15 Oct 2013 00:01:09 -0400 (EDT)
Subject: [RFC v3 PATCH 0/7] ARM[64]: kernel mode NEON in atomic
 contexts
In-Reply-To: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <alpine.LFD.2.03.1310142353210.1873@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 13 Oct 2013, Ard Biesheuvel wrote:

> Take #3 of this RFC series.
> 
> Instead of having additional separate versions of kernel_neon_begin/end, the
> existing ones now have been modified to always take a preallocated stack area
> as an argument.

The problem with this approach is that you break git bisect by making
the kernel unbuildable when this series is partially applied.  Either
you make kernel_neon_begin/end into wrappers with no argument around the
new interface, or you change all users at the same time as the
interface.  One big principle is not to break the kernel build in the
middle of a patch series when altering an existing interface.

> The stack area is allocated by DEFINE_NEON_REGSTACK[_PARTIAL](varname), where
> the partial version takes an additional int num_regs indicating how many
> registers need to be freed up.
> 
> In the !in_interrupt() case, these functions operate as before, and the regstack
> is defined to minimal size in this case as it will remain unused anyway. In the
> in_interrupt() case, 'num_regs' (or all) NEON registers are stacked/unstacked
> using the allocated stack region.

Would have been nice to have the stack simply be a NULL pointer when 
!in_interrupt() or when the number of regs is 0.  This would remove the 
need for a runtime check on !num_regs.  I don't see an obvious way to 
accomplish that right now though.


Nicolas
