From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 9 Dec 2014 16:46:43 +0100
Subject: [PATCH] vgic: move reset initialization into vgic_init_maps()
In-Reply-To: <1417705344-747-1-git-send-email-peter.maydell@linaro.org>
References: <1417705344-747-1-git-send-email-peter.maydell@linaro.org>
Message-ID: <20141209154643.GA28388@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 04, 2014 at 03:02:24PM +0000, Peter Maydell wrote:
> VGIC initialization currently happens in three phases:
>  (1) kvm_vgic_create() (triggered by userspace GIC creation)
>  (2) vgic_init_maps() (triggered by userspace GIC register read/write
>      requests, or from kvm_vgic_init() if not already run)
>  (3) kvm_vgic_init() (triggered by first VM run)
> 
> We were doing initialization of some state to correspond with the
> state of a freshly-reset GIC in kvm_vgic_init(); this is too late,
> since it will overwrite changes made by userspace using the
> register access APIs before the VM is run. Move this initialization
> earlier, into the vgic_init_maps() phase.
> 
> This fixes a bug where QEMU could successfully restore a saved
> VM state snapshot into a VM that had already been run, but could
> not restore it "from cold" using the -loadvm command line option
> (the symptoms being that the restored VM would run but interrupts
> were ignored).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> You could make a good argument for renaming vgic_init_maps() and
> kvm_vgic_init() (eg vgic_init() and vgic_first_run() ?)...
> 
Yes you could.  I've sent out a series today that reworks your patch and
adds some other logic to go along with it.

-Christoffer
