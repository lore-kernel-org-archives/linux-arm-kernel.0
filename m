From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 6 Jan 2014 14:56:19 -0800
Subject: [PATCH REPOST 5/5] ARM: kvm MMIO support BE host running LE code
In-Reply-To: <CAFEAcA8bqeqta0+YJ-tsYdgnr8b7kBZP4aQNDz_TSDm72-NA+A@mail.gmail.com>
References: <1387558125-3460-1-git-send-email-victor.kamensky@linaro.org>
 <1387558125-3460-6-git-send-email-victor.kamensky@linaro.org>
 <8738l1ffr4.fsf@e102391-lin.cambridge.arm.com>
 <CAA3XUr3sGNQ1==13gcsuz4+ozF1fgUz4YiwbYa6OLFCqFbB5Lg@mail.gmail.com>
 <87r48ldla6.fsf@e102391-lin.cambridge.arm.com>
 <CAFEAcA8bqeqta0+YJ-tsYdgnr8b7kBZP4aQNDz_TSDm72-NA+A@mail.gmail.com>
Message-ID: <20140106225619.GC27179@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 06, 2014 at 10:31:42PM +0000, Peter Maydell wrote:
> On 6 January 2014 18:20, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >  No matter how data is stored in memory (BE, LE, or
> > even PDP endianness), CPU registers always have a consistent
> > representation. They are immune to CPU endianness change, and storing
> > to/reading from memory won't change the value, as long as you use the
> > same endianness for writing/reading.
> 
> Ah, endianness. This always confuses me, but I hope the following
> is correct... (in all the following when I say BE I mean BE8, not BE32,
> since BE32 and virtualization never occur in the same CPU).
> 
> Certainly registers don't have endianness, but the entire point
> of the CPSR.E bit is exactly that it changes the value as it is
> stored to / read from memory, isn't it? -- that's where and when the
> byte-lane flipping happens.
> 
> Where this impacts the hypervisor is that instead of actually sending
> the data out to the bus via the byte-swapping h/w, we've trapped instead.
> The hypervisor reads the original data directly from the guest CPU
> registers, and so it's the hypervisor and userspace support code that
> between them have to emulate the equivalent of the byte lane
> swapping h/w. You could argue that it shouldn't be the kernel's
> job, but since the kernel has to do it for the devices it emulates
> internally, I'm not sure that makes much sense.

As far as I understand, this is exactly what vcpu_data_guest_to_host and
vcpu_data_host_to_guest do; emulate the byte lane swapping.

The problem is that it only works on a little-endian host with the
current code, because be16_to_cpu (for example), actually perform a
byteswap, which is what needs to be emulated.  On a big-endian host, we
do nothing, so we end up giving a byteswapped value to the emulated
device.

I think a cleaner fix than this patch is to just change the
be16_to_cpu() to a __swab16() instead, which clearly indicates that
'here is the byte lane swapping'.

But admittedly this hurts my brain, so I'm not 100% sure I got this last
part right.

-Christoffer

> 
> > What you seems to be missing is that the emulated devices must be
> > LE. There is no such thing as a BE GIC.
> 
> Right, so a BE guest would be internally flipping the 32 bit value
> it wants to write so that when it goes through the CPU's byte-lane
> swap (because CPSR.E is set) it appears to the GIC with the correct
> bit at the bottom, yes?
> 
> (At least I think that's what the GIC being LE means; I don't think
> it's like the devices on the Private Peripheral Bus on the M-profile
> cores which are genuinely on the CPU's side of the byte-lane
> swapping h/w and thus always LE regardless of the state of the
> endianness bit. Am I wrong there?)
> 
> It's not necessary that *all* emulated devices must be LE, of
> course -- you could have a QEMU which supported a board
> with a bunch of BE devices on it.
> 
> thanks
> -- PMM
