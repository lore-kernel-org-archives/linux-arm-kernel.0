From: cdall@linaro.org (Christoffer Dall)
Date: Thu, 2 Feb 2017 13:31:04 +0100
Subject: [RFC v3 00/10] Provide the EL1 physical timer to the VM
In-Reply-To: <1485970990-13775-1-git-send-email-jintack@cs.columbia.edu>
References: <1485970990-13775-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <20170202123104.GJ27852@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jintack,

On Wed, Feb 01, 2017 at 12:43:00PM -0500, Jintack Lim wrote:
> The ARM architecture defines the EL1 physical timer and the virtual timer,
> and it is reasonable for an OS to expect to be able to access both.
> However, the current KVM implementation does not provide the EL1 physical
> timer to VMs but terminates VMs on access to the timer.
> 
> This patch series enables VMs to use the EL1 physical timer through
> trap-and-emulate.  The KVM host emulates each EL1 physical timer register
> access and sets up the background timer accordingly.  When the background
> timer expires, the KVM host injects EL1 physical timer interrupts to the
> VM.  Alternatively, it's also possible to allow VMs to access the EL1
> physical timer without trapping.  However, this requires somehow using the
> EL2 physical timer for the Linux host while running the VM instead of the
> EL1 physical timer.  Right now I just implemented trap-and-emulate because
> this was straightforward to do, and I leave it to future work to determine
> if transferring the EL1 physical timer state to the EL2 timer provides any
> performance benefit.
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
> v2 => v3:
>  - Rebase on kvmarm/queue
>  - Take kvm->lock to synchronize cntvoff across all vtimers
>  - Remove unnecessary function parameters
>  - Add comments

I just gave v3 a test run on my TC2 (32-bit platform) and my guest
quickly locks up trying to run cyclictest or when booting the machine it
stalls with RCU timeouts.

Could you have a look?

Thanks,
-Christoffer
