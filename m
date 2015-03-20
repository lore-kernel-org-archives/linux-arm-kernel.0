From: robherring2@gmail.com (Rob Herring)
Date: Fri, 20 Mar 2015 13:25:31 -0500
Subject: [PATCH RESEND] Doc: dt: arch_timer: discourage clock-frequency use
In-Reply-To: <1426874267-24413-1-git-send-email-mark.rutland@arm.com>
References: <1426874267-24413-1-git-send-email-mark.rutland@arm.com>
Message-ID: <CAL_JsqJfyknhZxGvbWcj1Vj1FGRt40qT9b=xrbhm0wfu-BduTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 20, 2015 at 12:57 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> The ARM Generic Timer (AKA the architected timer, arm_arch_timer)
> features a CPU register (CNTFRQ) which firmware is intended to
> initialize, and non-secure software can read to determine the frequency
> of the timer. On CPUs with secure state, this register cannot be written
> from non-secure states.
>
> The firmware of early SoCs featuring the timer did not correctly
> initialize CNTFRQ correctly on all CPUs, requiring the frequency to be
> described in DT as a workaround. This workaround is not complete however
> as it is exposed to all software in a privileged non-secure mode
> (including guests running under a hypervisor). The firmware and DTs for
> recent SoCs have followed the example set by these early SoCs.
>
> This patch updates the arch timer binding documentation to make it
> clearer that the use of the clock-frequency property is a poor
> work-around. The MMIO generic timer binding is similarly updated, though
> this is less of a concern as there is generally no need to expose the
> MMIO timers to guest OSs.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Acked-by: Olof Johansson <olof@lixom.net>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/arch_timer.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> This patch has fallen through the cracks a few times [1,2], though that appears
> to be my fault for not sorting out a reasonable Cc list.
>
> Rob, are you happy to take this through your tree?

Yes, I'll take it.

Rob

>
> Mark.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/282804.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/282830.html
>
>
> diff --git a/Documentation/devicetree/bindings/arm/arch_timer.txt b/Documentation/devicetree/bindings/arm/arch_timer.txt
> index 256b4d8..e774128 100644
> --- a/Documentation/devicetree/bindings/arm/arch_timer.txt
> +++ b/Documentation/devicetree/bindings/arm/arch_timer.txt
> @@ -17,7 +17,10 @@ to deliver its interrupts via SPIs.
>  - interrupts : Interrupt list for secure, non-secure, virtual and
>    hypervisor timers, in that order.
>
> -- clock-frequency : The frequency of the main counter, in Hz. Optional.
> +- clock-frequency : The frequency of the main counter, in Hz. Should be present
> +  only where necessary to work around broken firmware which does not configure
> +  CNTFRQ on all CPUs to a uniform correct value. Use of this property is
> +  strongly discouraged; fix your firmware unless absolutely impossible.
>
>  - always-on : a boolean property. If present, the timer is powered through an
>    always-on power domain, therefore it never loses context.
> @@ -46,7 +49,8 @@ Example:
>
>  - compatible : Should at least contain "arm,armv7-timer-mem".
>
> -- clock-frequency : The frequency of the main counter, in Hz. Optional.
> +- clock-frequency : The frequency of the main counter, in Hz. Should be present
> +  only when firmware has not configured the MMIO CNTFRQ registers.
>
>  - reg : The control frame base address.
>
> --
> 1.9.1
>
