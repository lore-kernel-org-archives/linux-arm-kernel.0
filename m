From: scottwood@freescale.com (Scott Wood)
Date: Tue, 8 Jan 2013 17:29:43 -0600
Subject: [PATCH v5 01/12] KVM: ARM: Introduce KVM_SET_DEVICE_ADDRESS ioctl
In-Reply-To: <CANM98qL=tisS_6rqPYHvo+xJUfC_WzypHABK2H_Ac+4Sqwb3-A@mail.gmail.com>
 (from c.dall@virtualopensystems.com on Tue Jan  8 17:17:05 2013)
Message-ID: <1357687783.10453.9@snotra>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2013 05:17:05 PM, Christoffer Dall wrote:
> On Tue, Jan 8, 2013 at 5:36 PM, Scott Wood <scottwood@freescale.com>  
> wrote:
> > On 01/08/2013 12:41:30 PM, Christoffer Dall wrote:
> >> +struct kvm_device_address {
> >> +       __u64 id;
> >> +       __u64 addr;
> >> +};
> >
> >
> > What about this is really specific to addresses?  Can't we set  
> other device
> > parameters this way?
> >
> > Sort of like a device equivalent of PPC's one-reg interface.
> >
> This has been discussed a number of times,

Sorry, this patch was just pointed out to me today.  I googled the  
patch title but couldn't find this discussion.

> and one or the other there
> is a need for userspace to tell KVM to present memory-mapped devices
> at a given address. It was also considered to make this specific to
> irqchip initialization, but irqchips are different and a lot of that
> code is x86-specific, so that approach was discarded.
> 
> This *could* look something like this:
> 
> struct kvm_device_param {
>     u64 dev_id;
>     u64 param_id;
>     u64 value;
> };
> 
> but that has less clear, or at least less specific, semantics.

Why is it less clear?  You need to have device-specific documentation  
for what "id" means, so why not also an enumeration of "param"s?  Or  
just keep it as is, and rename "address" to "value".  Whether "dev" and  
"param" are combined is orthogonal from whether it's used for  
non-address things.

If you leave it as "address", either we'll have it being used for  
non-address things regardless of the name ("Not a typewriter!"), or  
there'll end up being yet more unnecessary ioctls, or device-specific  
things will end up getting shoved into CPU interfaces such as one-reg.   
For example, on MPIC we need to be able to specify the version of the  
chip to emulate in addition to the address at which it lives.

Also, why is it documented as an "arm" interface?  Shouldn't it be a  
generic interface, with other architectures currently not implementing  
any IDs?  What in the kvm_arch_vm_ioctl() wrapper is arm-specific?

-Scott
