From: agraf@suse.de (Alexander Graf)
Date: Thu, 20 Jun 2013 15:54:49 +0200
Subject: [PATCH 0/7] KVM: arm-vgic: Implement save/restore of VGIC state
In-Reply-To: <1370926279-32532-1-git-send-email-christoffer.dall@linaro.org>
References: <1370926279-32532-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <51C309A9.4070207@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2013 06:51 AM, Christoffer Dall wrote:
> This patch series adds support for user space save/restore of the VGIC
> state.  Instead of expanding the ONE_REG interface, which works on
> VCPUs, we first introduce support for the new KVM device control API and
> the VGIC.  Now, instead of calling KVM_CREATE_IRQCHIP, user space can
> call KVM_CREATE_DEVICE and perform operations on the device fd, such as
> KVM_SET_DEVICE_ATTR to set a device attribute.
>
> We leverage the KVM_{SET/GET}_DEVICE_ATTR API to export the state of the
> VGIC to user space.  Instead of coming up with our own custom format for
> exporting the VGIC state, we simply export all the state visible to an
> emulated guest, which must contain the full GIC state to provide
> save/restore of the GIC state for power management purposes.  This
> further provides the benefit of being able to re-use the MMIO emulation
> code for the distributor for save/restore.
>
> However, the need to save/restore cpu-specific state demands that user
> space can save/restore state accessible through the CPU interface, and
> we therefore add an emulation interface for the CPU-specific interface.
>
> This is considered a first attempt, and I am not married to the device
> control API.  If there are good technical arguments to take another
> approach, I am of course willing to discuss this.  However, my attempts
> with the ONE_REG interface did not look very nice.
>
>    [ WARINING: The patch set core functionality is completely untested;
>    the basic KVM system has been briefly tested on TC2 and it doesn't
>    seem like I've broken existing functionality. ]
>
> I wanted to get this out early to get feedback on the overall API and
> idea, and I'm writing some user QEMU for the user space side to test
> the new functionality meanwhile.
>
> Patches are against kvm-arm-next and also available here:
> git://git.linaro.org/people/cdall/linux-kvm-arm.git vgic-migrate

I don't see major glitches :)

Reviewed-by: Alexander Graf <agraf@suse.de>


Alex
