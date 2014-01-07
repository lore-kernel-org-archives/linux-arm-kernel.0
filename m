From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon, 6 Jan 2014 17:59:03 -0800
Subject: [PATCH REPOST 5/5] ARM: kvm MMIO support BE host running LE code
In-Reply-To: <20140106225619.GC27179@cbox>
References: <1387558125-3460-1-git-send-email-victor.kamensky@linaro.org>
 <1387558125-3460-6-git-send-email-victor.kamensky@linaro.org>
 <8738l1ffr4.fsf@e102391-lin.cambridge.arm.com>
 <CAA3XUr3sGNQ1==13gcsuz4+ozF1fgUz4YiwbYa6OLFCqFbB5Lg@mail.gmail.com>
 <87r48ldla6.fsf@e102391-lin.cambridge.arm.com>
 <CAFEAcA8bqeqta0+YJ-tsYdgnr8b7kBZP4aQNDz_TSDm72-NA+A@mail.gmail.com>
 <20140106225619.GC27179@cbox>
Message-ID: <CAA3XUr1=yeO=jJrWZJvrdBWbfes8+dHqkGkccjked=Racz3y_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 January 2014 14:56, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Mon, Jan 06, 2014 at 10:31:42PM +0000, Peter Maydell wrote:
>> On 6 January 2014 18:20, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> >  No matter how data is stored in memory (BE, LE, or
>> > even PDP endianness), CPU registers always have a consistent
>> > representation. They are immune to CPU endianness change, and storing
>> > to/reading from memory won't change the value, as long as you use the
>> > same endianness for writing/reading.
>>
>> Ah, endianness. This always confuses me, but I hope the following
>> is correct... (in all the following when I say BE I mean BE8, not BE32,
>> since BE32 and virtualization never occur in the same CPU).
>>
>> Certainly registers don't have endianness, but the entire point
>> of the CPSR.E bit is exactly that it changes the value as it is
>> stored to / read from memory, isn't it? -- that's where and when the
>> byte-lane flipping happens.
>>
>> Where this impacts the hypervisor is that instead of actually sending
>> the data out to the bus via the byte-swapping h/w, we've trapped instead.
>> The hypervisor reads the original data directly from the guest CPU
>> registers, and so it's the hypervisor and userspace support code that
>> between them have to emulate the equivalent of the byte lane
>> swapping h/w. You could argue that it shouldn't be the kernel's
>> job, but since the kernel has to do it for the devices it emulates
>> internally, I'm not sure that makes much sense.
>
> As far as I understand, this is exactly what vcpu_data_guest_to_host and
> vcpu_data_host_to_guest do; emulate the byte lane swapping.
>
> The problem is that it only works on a little-endian host with the
> current code, because be16_to_cpu (for example), actually perform a
> byteswap, which is what needs to be emulated.  On a big-endian host, we
> do nothing, so we end up giving a byteswapped value to the emulated
> device.

Yes, that was my point on the thread: vcpu_data_guest_to_host and
vcpu_data_host_to_guest functions for any given host endianity should
give opposite endian results depending on CPSR E bit value. And
currently it is not happening in BE host case. It seems that Peter and
you agree with that and I gave example in another email with
dynamically switching E bit illustrating this problem for BE host.

> I think a cleaner fix than this patch is to just change the
> be16_to_cpu() to a __swab16() instead, which clearly indicates that
> 'here is the byte lane swapping'.

Yes, that may work, but it is a bit orthogonal issue. And I don't think
it is better. For this to work one need to change canonical endianity on
one of the sides around vcpu_data_guest_to_host and
vcpu_data_host_to_guest functions.

Changing  it on side that faces hypervisor (code that handles guest spilled
CPU register set) does not make sense at all - if we will keep guest CPU
register set in memory in LE form and hypervisor runs in BE (BE host),
code that spills registers would need to do constant byteswaps. Also any
access by host kernel and hypervisor (all running in BE) would need to do
byteswaps while working with guest saved registers.

Changing canonical form of data on side that faces emulator and mmio
part of kvm_run does not make sense either. kvm_run mmio.data field is
bytes array, when it comes to host kernel from emulator, it already contains
device memory in correct endian order that corresponds to endianity of
emulated device. For example for LE device word read access, after call is
emulated, mmio.data will contain mmio.data[0], mmio.data[1], mmio.data[2]
mmio.data[3] values in LE order (mmio.data[3] is MSB). Now look at
mmio_read_buf function introduced by Marc's 6d89d2d9 commit, this function
will byte copy this mmio.data buffer into integer according to ongoing mmio
access size. Note in BE host case such integer, in 'data' variable of
kvm_handle_mmio_return function, will have byteswapped value. Now when it will
be passed into vcpu_data_host_to_guest function, and it emulates read access
of guest with E bit set, and if we follow your suggestion, it will be
byteswapped.
I.e 'data' integer will contain non byteswapped value of LE device. It will be
further stored into some vcpu_reg register, still in native format (BE
store), and
further restored into guest CPU register, still non byteswapped (BE hypervisor).
And that is not what BE client reading word of LE device expects - BE client
knowing that it reads LE device with E bit set, it will issue additional rev
instruction to get device memory as integer. If we really want to follow your
suggestion, one may introduce compensatory byteswaps in mmio_read_buf
and mmio_write_buf functions in case of BE host, rather then just do
memcpy ... but I am not sure what it will buy us - in BE case it will swap data
twice.

Note in above description by "canonical" I mean some form of data regardless
of current access CPSR E value. But it may differ depending on host endianess.

Also as far as working with VGIC concerned: PATCH 2/5 [1] of this
series reads real
h/w vgic values from #GICH_HCR, #VGIC_CPU_VMCR, etc and byteswapps them in
case of BE host. So now VGIC "integer" values are present in kernel in cpu
native format. When mmio_data_read, and mmio_data_write functions of vgic.c
are called to fill mmio.data array because VGIC values are now in native format
but mmio.data array should contain memory in device endianity (LE for VGIC) my
PATCH 4/5 [2] of this series cpu_to_le32 and le32_to_cpu function to byteswap. I
admit that PATCH 4/5 comment is a bit obscure.

Thanks,
Victor

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/221168.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/221167.html

> But admittedly this hurts my brain, so I'm not 100% sure I got this last
> part right.
>
> -Christoffer
>
>>
>> > What you seems to be missing is that the emulated devices must be
>> > LE. There is no such thing as a BE GIC.
>>
>> Right, so a BE guest would be internally flipping the 32 bit value
>> it wants to write so that when it goes through the CPU's byte-lane
>> swap (because CPSR.E is set) it appears to the GIC with the correct
>> bit at the bottom, yes?
>>
>> (At least I think that's what the GIC being LE means; I don't think
>> it's like the devices on the Private Peripheral Bus on the M-profile
>> cores which are genuinely on the CPU's side of the byte-lane
>> swapping h/w and thus always LE regardless of the state of the
>> endianness bit. Am I wrong there?)
>>
>> It's not necessary that *all* emulated devices must be LE, of
>> course -- you could have a QEMU which supported a board
>> with a bunch of BE devices on it.
>>
>> thanks
>> -- PMM
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
