From: robh@kernel.org (Rob Herring)
Date: Mon, 16 May 2016 11:14:33 -0500
Subject: [PATCH v2 1/2] ARM64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <1463114260-8724-1-git-send-email-oss@buserror.net>
References: <1463114260-8724-1-git-send-email-oss@buserror.net>
Message-ID: <20160516161433.GA9247@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 11:37:39PM -0500, Scott Wood wrote:
> Erratum A-008585 says that the ARM generic timer counter "has the
> potential to contain an erroneous value for a small number of core
> clock cycles every time the timer value changes".  Accesses to TVAL
> (both read and write) are also affected due to the implicit counter
> read.  Accesses to CVAL are not affected.
> 
> The workaround is to reread TVAL and count registers until successive reads
> return the same value, and when writing TVAL to retry until counter
> reads before and after the write return the same value.
> 
> This erratum can be found on LS1043A and LS2080A.
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> ---
> v2:
> Significant rework based on feedback, including using static_key,
> disabling VDSO counter access rather than adding the workaround to the
> VDSO, and uninlining the loops.
> 
> Dropped the separate property for indicating that writes to TVAL are
> affected, as I believe that's just a side effect of the implicit
> counter read being corrupted, and thus a chip that is affected by one
> will always be affected by the other.
> 
> Dropped the arm32 portion as it seems there was confusion about whether
> LS1021A is affected.  Currently I am being told that it is not
> affected.
> 
> I considered writing to CVAL rather than looping on TVAL writes, but
> that would still have required separate set_next_event() code for the
> erratum, and adding CVAL to the enum would have required a bunch of
> extra handlers in switch statements (even where unused, due to compiler
> warnings about unhandled enum values) including in an arm32 header.  It
> seemed better to avoid the arm32 interaction and new untested
> accessors.
> ---
>  .../devicetree/bindings/arm/arch_timer.txt         |   6 ++

Acked-by: Rob Herring <robh@kernel.org>

>  arch/arm64/include/asm/arch_timer.h                |  37 +++++--
>  drivers/clocksource/arm_arch_timer.c               | 110 +++++++++++++++++++++
>  3 files changed, 144 insertions(+), 9 deletions(-)
