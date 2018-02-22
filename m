From: drjones@redhat.com (Andrew Jones)
Date: Thu, 22 Feb 2018 15:04:36 +0100
Subject: [PATCH v4 28/40] KVM: arm64: Defer saving/restoring 64-bit
 sysregs to vcpu load/put on VHE
In-Reply-To: <20180215210332.8648-29-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-29-christoffer.dall@linaro.org>
Message-ID: <20180222140436.jzk2fa7mzsasu64a@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 10:03:20PM +0100, Christoffer Dall wrote:
> Some system registers do not affect the host kernel's execution and can
> therefore be loaded when we are about to run a VCPU and we don't have to
> restore the host state to the hardware before the time when we are
> actually about to return to userspace or schedule out the VCPU thread.
> 
> The EL1 system registers and the userspace state registers only
> affecting EL0 execution do not need to be saved and restored on every
> switch between the VM and the host, because they don't affect the host
> kernel's execution.
> 
> We mark all registers which are now deffered as such in the
> vcpu_{read,write}_sys_reg accessors in sys-regs.c to ensure the most
> up-to-date copy is always accessed.
> 
> Note MPIDR_EL1 (controlled via VMPIDR_EL2) is accessed from other vcpu
> threads, for example via the GIC emulation, and therefore must be
> declared as immediate, which is fine as the guest cannot modify this
> value.
> 
> The 32-bit sysregs can also be deferred but we do this in a separate
> patch as it requires a bit more infrastructure.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
> 
> Notes:
>     Changes since v3:
>      - Changed to switch-based sysreg approach
> 
>  arch/arm64/kvm/hyp/sysreg-sr.c | 39 +++++++++++++++++++++++++++++++--------
>  arch/arm64/kvm/sys_regs.c      | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+), 8 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
