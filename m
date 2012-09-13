From: robherring2@gmail.com (Rob Herring)
Date: Wed, 12 Sep 2012 21:34:28 -0500
Subject: [PATCH v3 06/25] docs: Xen ARM DT bindings
In-Reply-To: <alpine.DEB.2.02.1209121849200.15568@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1208161618550.4850@kaball.uk.xensource.com>
 <1345131377-14713-6-git-send-email-stefano.stabellini@eu.citrix.com>
 <503BFCD8.5090804@gmail.com>
 <alpine.DEB.2.02.1208281823270.15568@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1209121849200.15568@kaball.uk.xensource.com>
Message-ID: <50514634.3080303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2012 01:14 PM, Stefano Stabellini wrote:
> On Wed, 12 Sep 2012, Stefano Stabellini wrote:
>> On Tue, 28 Aug 2012, Rob Herring wrote:
>>> You should look at ePAPR 1.1 which defines hypervisor related bindings.
>>> While it is a PPC doc, we should reuse or extend what makes sense.
>>>
>>> See section 7.5:
>>>
>>> https://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.1.pdf
>>
>> Thanks for the link, I wasn't aware of ePAPR.
>>
>> The hypervisor node defined by ePAPR is not very different from what I
>> am proposing. Should I try to be compatible with the hypervisor
>> specification above (as in compatible = "epapr,hypervisor-1.1")?
>> Or should I just use it as a reference for my own specification?
>>
>> Personally I would rather avoid full compatibility with ePAPR.
> 
> In particular reading section 7.5, these are the required properties of
> the ePAPR hypervisor node:
> 
> - compatible = "epapr,hypervisor-1.1"
> compared to what I am proposing, it is laking information about what
> hypervisor we are talking about (xen, kvm, vmware, etc) and the version
> of the ABI (xen-4.2).

compatible properties are often changed. If we do deviate on the rest of
the binding, then it needs to be different.

Turns out that powerpc KVM guests use "linux,kvm" and "epapr,hypervisor"
doesn't even appear in the kernel.

We also perhaps have to consider the possibility of Xen on PowerPC. Then
alignment is more important.

> - hcall-instructions
> potentially interesting, but given that for Xen we are quite happy with
> HVC, we are not going to add any secondary hypercall mechanisms,
> therefore at the moment it would just result in a BUG if the specified
> hcall instruction is != HVC. Besides if somebody else wanted to
> implemented the Xen hypercall interface in a different way they could
> just reimplement the hypercall wrappers, that would be easier than
> trying to do it with this property.

It's really about the parameters passed with the HVC. The ePAPR may be a
good model for defining this. Just grepping "hypervisor" under
arch/powerpc, it's pretty clear hypervisor support happened first and
the ePAPR came second. Hopefully we can avoid that for ARM.

> - guest-id
> we usually make a point in trying not to tell the guest its own domid
> because if the VM gets migrated to a different host it acquires a new
> domid, therefore it should not rely on it.
> 
> - guest-name
> we could pass the guest name here, but I don't see how it could be
> of any use.
> 

I have no issue with these being optional.

> 
> On the other hand, thinking more about what Xen needs in the device
> tree, I think we could improve the current spec by clarifying the
> meaning of the memory region and interrupt properties we currently
> require. I thought about moving them to two separate children node with
> an explicit name:
> 
> ---
> 
> * Xen hypervisor device tree bindings
> 

I really think we need to define ARM hypervisor device tree bindings
first, then Xen specific bindings as an addition to that. I worry that
the KVM folks aren't paying attention and then want something different
later on.

> Xen ARM virtual platforms shall have the following properties and
> children nodes:
> 
> - compatible property:
> 	compatible = "xen,xen", "xen,xen-<version>";

"xen,xen" should be last as it is less specific.

>   where <version> is the version of the Xen ABI of the platform.
> 
> - grant_table child with the following properties:
>     - name:
> 	    name = "grant_table";

What's a grant table?

> 	- reg: specifies the base physical address and size of a region in
> 	    memory where the grant table should be mapped to, using an
>         HYPERVISOR_memory_op hypercall. 
> 
> - events child with the following properties:
>     - name:
>         name = "events";
> 	- interrupts: the interrupt used by Xen to inject event notifications.

Why a child node? Just an interrupts property alone should be fine. If
you have cases with different number of interrupts, the compatible
property can distinguish that.

Rob

> 
> 
> Example:
> hypervisor {
> 		compatible = "xen,xen", "xen,xen-4.2";
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		#interrupt-cells = <3>;
> 		ranges = <0xb0000000 0xb0000000 0x20000>;
> 
> 		grant_table {
> 			name = "grant_table";
> 			reg = <0xb0000000 0x20000>;
> 		};
> 
> 		events {
> 			name = "events";
> 			interrupts = <1 15 0xf08>;
> 		};
> 	};
> 
