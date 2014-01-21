From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 20 Jan 2014 22:31:11 -0800
Subject: [PATCH REPOST 5/5] ARM: kvm MMIO support BE host running LE code
In-Reply-To: <CAAhSdy28wyf4ynWwdyhMBZQ983t32n1fkM8AaNXhiew0TVAAEw@mail.gmail.com>
References: <1387558125-3460-6-git-send-email-victor.kamensky@linaro.org>
 <8738l1ffr4.fsf@e102391-lin.cambridge.arm.com>
 <CAA3XUr3sGNQ1==13gcsuz4+ozF1fgUz4YiwbYa6OLFCqFbB5Lg@mail.gmail.com>
 <87r48ldla6.fsf@e102391-lin.cambridge.arm.com>
 <CAFEAcA8bqeqta0+YJ-tsYdgnr8b7kBZP4aQNDz_TSDm72-NA+A@mail.gmail.com>
 <20140106225619.GC27179@cbox>
 <CAA3XUr1=yeO=jJrWZJvrdBWbfes8+dHqkGkccjked=Racz3y_w@mail.gmail.com>
 <20140121011915.GM13432@cbox>
 <CAA3XUr23_Ea8feJNiqV_6ferDCiKVDiE8nvHKqS88tjBeckc9A@mail.gmail.com>
 <CAAhSdy28wyf4ynWwdyhMBZQ983t32n1fkM8AaNXhiew0TVAAEw@mail.gmail.com>
Message-ID: <20140121063111.GO13432@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 11:16:46AM +0530, Anup Patel wrote:
> On Tue, Jan 21, 2014 at 10:54 AM, Victor Kamensky
> <victor.kamensky@linaro.org> wrote:
> > On 20 January 2014 17:19, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> >> On Mon, Jan 06, 2014 at 05:59:03PM -0800, Victor Kamensky wrote:
> >>> On 6 January 2014 14:56, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> >>> > On Mon, Jan 06, 2014 at 10:31:42PM +0000, Peter Maydell wrote:
> >>> >> On 6 January 2014 18:20, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >>> >> >  No matter how data is stored in memory (BE, LE, or
> >>> >> > even PDP endianness), CPU registers always have a consistent
> >>> >> > representation. They are immune to CPU endianness change, and storing
> >>> >> > to/reading from memory won't change the value, as long as you use the
> >>> >> > same endianness for writing/reading.
> >>> >>
> >>> >> Ah, endianness. This always confuses me, but I hope the following
> >>> >> is correct... (in all the following when I say BE I mean BE8, not BE32,
> >>> >> since BE32 and virtualization never occur in the same CPU).
> >>> >>
> >>> >> Certainly registers don't have endianness, but the entire point
> >>> >> of the CPSR.E bit is exactly that it changes the value as it is
> >>> >> stored to / read from memory, isn't it? -- that's where and when the
> >>> >> byte-lane flipping happens.
> >>> >>
> >>> >> Where this impacts the hypervisor is that instead of actually sending
> >>> >> the data out to the bus via the byte-swapping h/w, we've trapped instead.
> >>> >> The hypervisor reads the original data directly from the guest CPU
> >>> >> registers, and so it's the hypervisor and userspace support code that
> >>> >> between them have to emulate the equivalent of the byte lane
> >>> >> swapping h/w. You could argue that it shouldn't be the kernel's
> >>> >> job, but since the kernel has to do it for the devices it emulates
> >>> >> internally, I'm not sure that makes much sense.
> >>> >
> >>> > As far as I understand, this is exactly what vcpu_data_guest_to_host and
> >>> > vcpu_data_host_to_guest do; emulate the byte lane swapping.
> >>> >
> >>> > The problem is that it only works on a little-endian host with the
> >>> > current code, because be16_to_cpu (for example), actually perform a
> >>> > byteswap, which is what needs to be emulated.  On a big-endian host, we
> >>> > do nothing, so we end up giving a byteswapped value to the emulated
> >>> > device.
> >>>
> >>> Yes, that was my point on the thread: vcpu_data_guest_to_host and
> >>> vcpu_data_host_to_guest functions for any given host endianity should
> >>> give opposite endian results depending on CPSR E bit value. And
> >>> currently it is not happening in BE host case. It seems that Peter and
> >>> you agree with that and I gave example in another email with
> >>> dynamically switching E bit illustrating this problem for BE host.
> >>>
> >>> > I think a cleaner fix than this patch is to just change the
> >>> > be16_to_cpu() to a __swab16() instead, which clearly indicates that
> >>> > 'here is the byte lane swapping'.
> >>>
> >>> Yes, that may work, but it is a bit orthogonal issue.
> >>
> >> Why?  I don't think it is, I think it's addressing exactly the point at
> >> hand.
> >>
> >>> And I don't think
> >>> it is better. For this to work one need to change canonical endianity on
> >>> one of the sides around vcpu_data_guest_to_host and
> >>> vcpu_data_host_to_guest functions.
> >>
> >> You have to simply clearly define which format you want mmio.data to be
> >> in.
> >
> > I believe it is already decided. 'mmio.data' in 'struct kvm_run' is not
> > an integer type - it is bytes array. Bytes array does not have endianity.
> > It is endian agnostic. Here is snippet from linux/kvm.h
> >
> >                 /* KVM_EXIT_MMIO */
> >                 struct {
> >                         __u64 phys_addr;
> >                         __u8  data[8];
> >                         __u32 len;
> >                         __u8  is_write;
> >                 } mmio;
> >
> > it is very natural to treat it as just a piece of memory. I.e when code reads
> > emulated LE device address as integer, this array will contain integer
> > placed in memory in LE order, data[3] is MSB, as it would be located in
> > regular memory. When code reads emulated BE device address as
> > integer this array will contain integer placed in memory in BE order,
> > data[0] is MSB.
> >
> > You can think about it in that way: ARM system emulator runs on x86
> > (LE) and on PPC (BE). How mmio.data array for the same emulated
> > device should look like in across these two cases? I believe it should
> > be identical - just a stream of bytes.
> >
> > Emulator code handles this situation quite nicely. For example check
> > in qemu endianness field of MemoryRegionOps structure. Depending
> > of the field value and current emulator endianity code will place
> > results into 'mmio.data' array in right order. See [1] as an example
> > in qemu where endianity of certain ARM devices were not declared
> > correctly - it was marked as DEVICE_NATIVE_ENDIAN whereas
> > it should be DEVICE_LITTLE_ENDIAN. After I changed that BE qemu
> > pretty much started working. I strongly suspect if one would run
> > ARM system emulation on PPC (BE) he/she would need the same
> > changes.
> >
> > Note issue with virtio endianity is very different problem - there it
> > is not clear for given arrangement of host/emulator how to treat
> > virtio devices as LE or BE, and in what format data in rings
> > descriptors are.
> 
> IMHO, device endianess should be taken care by device emulators only
> because we can have Machine Model containing both LE devices and
> BE devices. KVM ARM/ARM64 should only worry about endianess of
> in-kernel emulated devices (e.g. VGIC). In general, QEMU or KVMTOOL
> should be responsible of device endianess and for this QEMU or KVMTOOL
> should also know whether Guest (or VM) is little-endian or big-endian.
> 

Specifying the interface to say that this is a store of the register
value directly using the endianness of the host kernel is an option.
However, user space must fetch the CPSR on each MMIO from the kernel and
look at the E-bit to understand how it should interpret the data, which
may add overhead, and it doesn't change the fact that this needs to be
specified in the API.

The E bit on ARM specifies that the CPU will swap the bytes before
putting the register value on the memory bus.  That's all it does.

Something has to emulate this, and given that KVM emulates the CPU, I
think KVM should emulate the E-bit.

>From my point of view, the mmio.data API as the signal you would receive
if you're any consumer of the memory operation externally to the CPU,
which would be in the form of a bunch of wires and a length, with no
endianness.

But, the thread I pointed Victor to is focused purely on this
discussion, so you should probably respond there.

-Christoffer

> 
> >
> > Thanks,
> > Victor
> >
> > [1]  https://git.linaro.org/people/victor.kamensky/qemu-be.git/commitdiff/8599358f9711b7a546a2bba63b6277fbfb5b8e0c?hp=c4880f08ff9451e3d8020153e1a710ab4acee151
> >
> >> This is a user space interface across multiple architectures and
> >> therefore something you have to consider carefully and you're limited in
> >> choices to something that works with existing user space code.
> >>
> >>>
> >>> Changing  it on side that faces hypervisor (code that handles guest spilled
> >>> CPU register set) does not make sense at all - if we will keep guest CPU
> >>> register set in memory in LE form and hypervisor runs in BE (BE host),
> >>> code that spills registers would need to do constant byteswaps. Also any
> >>> access by host kernel and hypervisor (all running in BE) would need to do
> >>> byteswaps while working with guest saved registers.
> >>>
> >>> Changing canonical form of data on side that faces emulator and mmio
> >>> part of kvm_run does not make sense either. kvm_run mmio.data field is
> >>> bytes array, when it comes to host kernel from emulator, it already contains
> >>> device memory in correct endian order that corresponds to endianity of
> >>> emulated device. For example for LE device word read access, after call is
> >>> emulated, mmio.data will contain mmio.data[0], mmio.data[1], mmio.data[2]
> >>> mmio.data[3] values in LE order (mmio.data[3] is MSB). Now look at
> >>> mmio_read_buf function introduced by Marc's 6d89d2d9 commit, this function
> >>> will byte copy this mmio.data buffer into integer according to ongoing mmio
> >>> access size. Note in BE host case such integer, in 'data' variable of
> >>> kvm_handle_mmio_return function, will have byteswapped value. Now when it will
> >>> be passed into vcpu_data_host_to_guest function, and it emulates read access
> >>> of guest with E bit set, and if we follow your suggestion, it will be
> >>> byteswapped.
> >>> I.e 'data' integer will contain non byteswapped value of LE device. It will be
> >>> further stored into some vcpu_reg register, still in native format (BE
> >>> store), and
> >>> further restored into guest CPU register, still non byteswapped (BE hypervisor).
> >>> And that is not what BE client reading word of LE device expects - BE client
> >>> knowing that it reads LE device with E bit set, it will issue additional rev
> >>> instruction to get device memory as integer. If we really want to follow your
> >>> suggestion, one may introduce compensatory byteswaps in mmio_read_buf
> >>> and mmio_write_buf functions in case of BE host, rather then just do
> >>> memcpy ... but I am not sure what it will buy us - in BE case it will swap data
> >>> twice.
> >>>
> >>> Note in above description by "canonical" I mean some form of data regardless
> >>> of current access CPSR E value. But it may differ depending on host endianess.
> >>>
> >>
> >> There's a lot of text to digest here, talking about a canonical form
> >> here doesn't help; just define the layout of the destination byte array.
> >> I also got completely lost in what you're referring to when you talk
> >> about 'sides' here.
> >>
> >> The thing we must decide is how the data is stored in
> >> kvm_exit_mmio.data.  See Peter's recent thread "KVM and
> >> variable-endianness guest CPUs".  Once we agree on this, the rest should
> >> be easy (assuming we use the same structure for the data in the kernel's
> >> internal kvm_exit_mmio declared on the stack in io_mem_abort()).
> >>
> >> The format you suggest requires any consumer of this data to consider
> >> the host endianness, which I don't think makes anything more clear (see
> >> my comment on the vgic patch).
> >>
> >> The in-kernel interface between the io_mem_abort() code and any
> >> in-kernel emulated device must do exactly the same as the interface
> >> between KVM and QEMU must do for KVM_EXIT_MMIO.
> >>
> >> --
> >> Christoffer
> > _______________________________________________
> > kvmarm mailing list
> > kvmarm at lists.cs.columbia.edu
> > https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm

-- 
Christoffer
