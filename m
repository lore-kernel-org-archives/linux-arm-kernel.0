From: scottwood@freescale.com (Scott Wood)
Date: Tue, 8 Jan 2013 18:12:59 -0600
Subject: [PATCH v5 01/12] KVM: ARM: Introduce KVM_SET_DEVICE_ADDRESS ioctl
In-Reply-To: <CANM98q+=5gZ+=muw4UHy5hQ8D6zqz--BLa4Z0C39dnUxeCOWfA@mail.gmail.com>
 (from c.dall@virtualopensystems.com on Tue Jan  8 17:49:40 2013)
Message-ID: <1357690379.10453.10@snotra>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2013 05:49:40 PM, Christoffer Dall wrote:
> On Tue, Jan 8, 2013 at 6:29 PM, Scott Wood <scottwood@freescale.com>  
> wrote:
> > On 01/08/2013 05:17:05 PM, Christoffer Dall wrote:
> >> This *could* look something like this:
> >>
> >> struct kvm_device_param {
> >>     u64 dev_id;
> >>     u64 param_id;
> >>     u64 value;
> >> };
> >>
> >> but that has less clear, or at least less specific, semantics.
> >
> >
> > Why is it less clear?  You need to have device-specific  
> documentation for
> > what "id" means, so why not also an enumeration of "param"s?  Or  
> just keep
> > it as is, and rename "address" to "value".  Whether "dev" and  
> "param" are
> > combined is orthogonal from whether it's used for non-address  
> things.
> 
> less clear in the sense that you have to look at more code to see what
> it does. I'm not saying that it's too unclear, at all, I'm actually
> fine with it, but to make my point, we can make an ioctl that's called
> do_something() that takes a struct with val0, val1, val2, val3, ...

Such an IOCTL would add nothing other than trading the limited and  
cumbersome ioctl namespace for something structured a bit differently  
(which isn't such a bad thing...).  A set device attribute ioctl would  
constrain it to "take this number and convey it to the enumerated  
device for the enumerated configuration purpose".  There's already room  
for device-specific semantics since you can have multiple address types.

Regarding the dev/param split, it looks like you're doing the split  
anyway -- might as well make them separate struct fields rather than an  
architecture-specific bitfield encoding.

> > If you leave it as "address", either we'll have it being used for
> > non-address things regardless of the name ("Not a typewriter!"), or  
> there'll
> > end up being yet more unnecessary ioctls, or device-specific things  
> will end
> > up getting shoved into CPU interfaces such as one-reg.  For  
> example, on MPIC
> > we need to be able to specify the version of the chip to emulate in  
> addition
> > to the address at which it lives.
> >
> > Also, why is it documented as an "arm" interface?  Shouldn't it be  
> a generic
> > interface, with other architectures currently not implementing any  
> IDs?
> > What in the kvm_arch_vm_ioctl() wrapper is arm-specific?
> >
> As I remember the argument for keeping this the point was that there
> were other preferred methods for other archs to do this, and that ARM
> was the only platform that had this explicit need, but maybe I'm
> making this up.

Well, at least PPC has this explicit need as well. :-)

Only the toplevel mechanism would be generic; it would be up to each  
device to decide which (if any) configuration parameters it wants to  
expose through it.

-Scott
