From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 22 Feb 2018 20:49:16 +0100
Subject: [PATCH v4 28/40] KVM: arm64: Defer saving/restoring 64-bit
 sysregs to vcpu load/put on VHE
In-Reply-To: <40a10d77-85c8-9c74-c94c-57e4f8854fef@arm.com>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-29-christoffer.dall@linaro.org>
 <ece29cf2-4c60-dc3d-b2a9-e7e06380f860@arm.com>
 <40a10d77-85c8-9c74-c94c-57e4f8854fef@arm.com>
Message-ID: <20180222194916.GA29376@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 06:31:08PM +0000, Julien Grall wrote:
> 
> 
> On 22/02/18 18:30, Julien Grall wrote:
> >Hi Christoffer,
> >
> >On 15/02/18 21:03, Christoffer Dall wrote:
> >>Some system registers do not affect the host kernel's execution and can
> >>therefore be loaded when we are about to run a VCPU and we don't have to
> >>restore the host state to the hardware before the time when we are
> >>actually about to return to userspace or schedule out the VCPU thread.
> >>
> >>The EL1 system registers and the userspace state registers only
> >>affecting EL0 execution do not need to be saved and restored on every
> >>switch between the VM and the host, because they don't affect the host
> >>kernel's execution.
> >>
> >>We mark all registers which are now deffered as such in the
> >
> >NIT: s/deffered/deferred/ I think.
> >
> >>vcpu_{read,write}_sys_reg accessors in sys-regs.c to ensure the most
> >>up-to-date copy is always accessed.
> >>
> >>Note MPIDR_EL1 (controlled via VMPIDR_EL2) is accessed from other vcpu
> >>threads, for example via the GIC emulation, and therefore must be
> >>declared as immediate, which is fine as the guest cannot modify this
> >>value.
> 
> I forgot to comment on this. I missed this paragraph at the first read and
> was wondering why MPIDR_EL1 was not accessed using sysreg in
> vcpu_{read,write}_sys_reg. It might be worth considering a comment in those
> functions.
> 

Hmmm, yeah, probably.  I'll see if I can stick it somewhere suitable.

Thanks,
-Christoffer
