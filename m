From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 11 Jan 2015 16:22:39 +0100
Subject: [PATCH v6 18/20] KVM: introduce kvm_check_device_type()
In-Reply-To: <54AFDAD2.7010505@arm.com>
References: <1420804478-17354-1-git-send-email-andre.przywara@arm.com>
 <1420804478-17354-19-git-send-email-andre.przywara@arm.com>
 <20150109123345.GR21092@cbox> <54AFDAD2.7010505@arm.com>
Message-ID: <20150111152239.GD21444@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 01:42:42PM +0000, Andre Przywara wrote:
> Hi Christoffer,
> 
> On 09/01/15 12:33, Christoffer Dall wrote:
> > On Fri, Jan 09, 2015 at 11:54:36AM +0000, Andre Przywara wrote:
> >> While we can easily register and unregister KVM devices, there is
> >> currently no easy way of checking whether a device has been
> >> registered.
> >> Introduce kvm_check_device_type() for that purpose and use it in two
> >> existing functions. Also change the return code for an invalid
> >> type number from ENOSPC to EINVAL.
> >> This function will be later used by another patch set to check
> >> whether a KVM_CREATE_IRQCHIP ioctl is valid.
> > 
> > I feel like this is misguided and the vgic should be able to figure this
> > stuff out internally.  Did you have code for this approach somewhere
> > that I can take a look at?
> 
> I pushed my WIP patch on top of the kvm-gicv3/v6 tree.
> Given how that looks I reckoned the generic solution would be more
> preferable.
> Basically we internally decide in the _probe function whether we support
> GICv2 emulation or not, which is mostly driven by device tree
> properties. So at the moment I just register the GIC_V2 KVM device or
> not. Now with the "vgic internal" solution I misuse the GICV address
> base as a hint of the GICv2 emulation availability. Alternatively I have
> to introduce a new variable to mirror what the KVM device array already
> holds, which seems kind of exerted to me.
> Besides that I am not sure if the GICV address hint will always be a
> reliable indicator and what we will do if there will be another GIC
> model to be emulated in the future (maybe we need that for the ITS
> emulation already?)

I don't think it looks that bad.

Only your gicv3 and gicv2 code files know what they are capable of
emulating, how you choose to store this state internally in those files
is a somewhat orthogonal discussion from using the kvm device API.

Using the KVM device api is just another way of storing and exposing the
information globally (you take registering the device types as an
indication of the state).

Finally, I don't even think you ned the can_emulate function, I think
you should just return an error from init_vgic_model (which happens to
collide with my suggestion on making those functions a void function in
one of the previous patches) and you're done.

> 
> So I prefer the more generic solution.
> Let me know what you think, I can as well drop 18/20 and merge the above
> mentioned patch.
> 
> > I forget: Are we still requiring KVM_CREATE_IRQCHIP for VGICv3 or are we
> > just relying on users to use KVM_CREATE_DEVICE for anything in the
> > future?
> 
> Since KVM_CREATE_IRQCHIP does not take an argument, we cannot use it for
> GICv3. So GICv3 mandates KVM_CREATE_DEVICE. We need userspace
> adjustments for GICv3 anyway, so that's not a problem.

ok, so KVM_CREATE_IRQCHIP is a direct alias for KVM_CREATE_DEVICE(GIC_V2)
and is deprecated for GICv3?  If so, we should probably update the
documentation to indicate the KVM_CREATE_IRQCHIP creates a GICv2 and
should not be used for any other in-kernel GIC versions.

Thanks,
-Christoffer
