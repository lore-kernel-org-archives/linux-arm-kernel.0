From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 3 Feb 2017 16:14:18 +0000
Subject: [RFC v4 00/10] Provide the EL1 physical timer to the VM
In-Reply-To: <1486135208-13415-1-git-send-email-jintack@cs.columbia.edu>
References: <1486135208-13415-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <11908d08-6e2d-010c-2e6f-fd677c7ad8b1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/17 15:19, Jintack Lim wrote:
> The ARM architecture defines the EL1 physical timer and the virtual timer,
> and it is reasonable for an OS to expect to be able to access both.
> However, the current KVM implementation does not provide the EL1 physical
> timer to VMs but terminates VMs on access to the timer.
> 
> This patch series enables VMs to use the EL1 physical timer through
> trap-and-emulate only on arm64. The KVM host emulates each EL1 physical
> timer register access and sets up the background timer accordingly.  When
> the background timer expires, the KVM host injects EL1 physical timer
> interrupts to the VM.  Alternatively, it's also possible to allow VMs to
> access the EL1 physical timer without trapping.  However, this requires
> somehow using the EL2 physical timer for the Linux host while running the
> VM instead of the EL1 physical timer.  Right now I just implemented
> trap-and-emulate because this was straightforward to do, and I leave it to
> future work to determine if transferring the EL1 physical timer state to
> the EL2 timer provides any performance benefit.
> 
> This feature will be useful for any OS that wishes to access the EL1
> physical timer. Nested virtualization is one of those use cases. A nested
> hypervisor running inside a VM would think it has full access to the
> hardware and naturally tries to use the EL1 physical timer as Linux would
> do. Other nested hypervisors may try to use the EL2 physical timer as Xen
> would do, but supporting the EL2 physical timer to the VM is out of scope
> of this patch series. This patch series will make it easy to add the EL2
> timer support in the future, though.
> 
> Note that Linux VMs booting in EL1 will be unaffected by this patch series
> and will continue to use only the virtual timer and this patch series will
> therefore not introduce any performance degredation as a result of
> trap-and-emulate.
> 
> v3 => v4:
>  - Fix a bug that prevents a VM from booting on 32-bit architecture
>  - Clarify that the emulated physical timer is only supported on arm64
>    in the cover letter

Hi Jintack,

I've now applied this to queue, and will push it out later today.

Out of curiosity, is there any reason why this is arm64 only? As far as
I can tell, we're only missing the cp15 handling (both for arm and in
the 32bit handling in arm64).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
