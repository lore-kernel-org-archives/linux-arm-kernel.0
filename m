From: scottwood@freescale.com (Scott Wood)
Date: Tue, 8 Jan 2013 16:36:32 -0600
Subject: [PATCH v5 01/12] KVM: ARM: Introduce KVM_SET_DEVICE_ADDRESS ioctl
In-Reply-To: <20130108184130.46558.60819.stgit@ubuntu> (from
 c.dall@virtualopensystems.com on Tue Jan  8 12:41:30 2013)
References: <20130108184116.46558.3558.stgit@ubuntu>
 <20130108184130.46558.60819.stgit@ubuntu>
Message-ID: <1357684592.10453.7@snotra>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2013 12:41:30 PM, Christoffer Dall wrote:
> On ARM (and possibly other architectures) some bits are specific to  
> the
> model being emulated for the guest and user space needs a way to tell
> the kernel about those bits.  An example is mmio device base  
> addresses,
> where KVM must know the base address for a given device to properly
> emulate mmio accesses within a certain address range or directly map a
> device with virtualiation extensions into the guest address space.
> 
> We try to make this API slightly more generic than for our specific  
> use,
> but so far only the VGIC uses this feature.
> 
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> ---
>  Documentation/virtual/kvm/api.txt |   37  
> +++++++++++++++++++++++++++++++++++++
>  arch/arm/include/uapi/asm/kvm.h   |   13 +++++++++++++
>  arch/arm/kvm/arm.c                |   23 ++++++++++++++++++++++-
>  include/uapi/linux/kvm.h          |    8 ++++++++
>  4 files changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/virtual/kvm/api.txt  
> b/Documentation/virtual/kvm/api.txt
> index 38066a7a..668956f 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2206,6 +2206,43 @@ This ioctl returns the guest registers that  
> are supported for the
>  KVM_GET_ONE_REG/KVM_SET_ONE_REG calls.
> 
> 
> +4.80 KVM_SET_DEVICE_ADDRESS
> +
> +Capability: KVM_CAP_SET_DEVICE_ADDRESS
> +Architectures: arm
> +Type: vm ioctl
> +Parameters: struct kvm_device_address (in)
> +Returns: 0 on success, -1 on error
> +Errors:
> +  ENODEV: The device id is unknown
> +  ENXIO:  Device not supported on current system
> +  EEXIST: Address already set
> +  E2BIG:  Address outside guest physical address space
> +
> +struct kvm_device_address {
> +	__u64 id;
> +	__u64 addr;
> +};

What about this is really specific to addresses?  Can't we set other  
device parameters this way?

Sort of like a device equivalent of PPC's one-reg interface.

-Scott
