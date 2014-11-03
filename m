From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 3 Nov 2014 10:54:46 +0100
Subject: [PATCH v2 04/15] arm/arm64: KVM: wrap 64 bit MMIO accesses with
 two 32 bit ones
In-Reply-To: <54539358.2010806@arm.com>
References: <1408626416-11326-1-git-send-email-andre.przywara@arm.com>
 <1408626416-11326-5-git-send-email-andre.przywara@arm.com>
 <20141015162615.GE14272@lvm> <54539358.2010806@arm.com>
Message-ID: <20141103095446.GA11248@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 01:49:12PM +0000, Andre Przywara wrote:
> Hi Christoffer,
> 
> On 15/10/14 17:26, Christoffer Dall wrote:
> > On Thu, Aug 21, 2014 at 02:06:45PM +0100, Andre Przywara wrote:

[...]

> >> +	 * 8 bytes long, caused by a 64-bit access
> >> +	 */
> >> +
> >> +	mmio32.len = 4;
> >> +	mmio32.is_write = mmio->is_write;
> >> +
> >> +	mmio32.phys_addr = mmio->phys_addr + 4;
> >> +	if (mmio->is_write)
> >> +		*(u32 *)mmio32.data = data32[1];
> >> +	ret = range->handle_mmio(vcpu, &mmio32, offset + 4);
> >> +	if (!mmio->is_write)
> >> +		data32[1] = *(u32 *)mmio32.data;
> >> +
> >> +	mmio32.phys_addr = mmio->phys_addr;
> >> +	if (mmio->is_write)
> >> +		*(u32 *)mmio32.data = data32[0];
> >> +	ret |= range->handle_mmio(vcpu, &mmio32, offset);
> >> +	if (!mmio->is_write)
> >> +		data32[0] = *(u32 *)mmio32.data;
> > 
> > won't this break on a BE system?
> 
> Mmh, I remember having this discussed with Marc before. But I see that
> it looks suspicious. This whole endianess thing is even more confusing
> since the GIC is always LE and the guest as well as KVM already do swapping.
> So I rewrote the above function to avoid explicit endianess assumptions,
> but am still struggling to get it tested successfully on a bi-endian setup.
> As I don't want to hold back the newer patches any longer, I will try to
> debug this next week, meanwhile not stating bi-endianness is supported
> for the new series.
> 
Well you're writing code here that just won't work on a big-endian
system and regardless of our ability to test things, you need to at
least put a big fat comment saying "TODO FIXME BROKEN Breaks on BE
systems", but I'm not sure I would ack that given we know it's broken,
so I strongly recommend you do a best-effort implementation in lack of
an environment to test it for now.

-Christoffer
