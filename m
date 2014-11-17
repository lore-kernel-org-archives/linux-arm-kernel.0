From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 Nov 2014 17:48:03 +0000
Subject: ARM atomics overhaul for musl
In-Reply-To: <20141117165334.GW4042@n2100.arm.linux.org.uk>
References: <20141116055656.GA13940@brightrain.aerifal.cx>
 <20141116163355.GK4042@n2100.arm.linux.org.uk>
 <20141116165017.GT22465@brightrain.aerifal.cx>
 <20141116171055.GM4042@n2100.arm.linux.org.uk>
 <20141117135412.GC29595@e104818-lin.cambridge.arm.com>
 <20141117143905.GQ4042@n2100.arm.linux.org.uk>
 <20141117152624.GF20652@localhost>
 <20141117154739.GT4042@n2100.arm.linux.org.uk>
 <20141117161941.GG29595@e104818-lin.cambridge.arm.com>
 <20141117165334.GW4042@n2100.arm.linux.org.uk>
Message-ID: <20141117174803.GH29595@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 04:53:34PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 17, 2014 at 04:19:42PM +0000, Catalin Marinas wrote:
> > Similarly for AArch32, I think we should switch our focus from version
> > numbers (well, only from v7/v8) to features (exposed by the hardware to
> > the kernel via CPUID). An example is how we got LPAE on ARMv7 without a
> > change in the architecture version number. We even expose this to user
> > space via hwcap because that's how we know we have atomic LDRD/STRD.
> 
> For this case, I disagree.  There is no value (in fact, there is lots of
> harm) to adding a hwcap bit for this.
> 
> If we added such a hwcap bit, it would mean that userspace would have
> to implement the check that I suggested, plus a check for the hwcap bit,
> plus maybe a kernel version check to decide which test to use.
[...]
> So, I really don't see the point in exposing the presence of DMB via
> a hwcap bit - if we wanted to do that, it's something that we should
> have done at the very start, but we didn't.  Now, it's pointless to
> do so.

I agree with you on a HWCAP_DMB bit, it's too late now and code should
rely on the architecture version instead.

But my point is about new features that will appear (or already did) in
the current or next architecture versions (e.g. ARMv8). So far we seem
to have avoided adding HWCAP bits for new features that were mandated by
certain architecture versions, probably under the assumption that
software would check the architecture version number.

For example, on ARMv8, do you want to add a HWCAP_LDACQ (for
acquire/release semantics) or we tell user space to check for "v8l"
instead? There are additional hints available for AArch32 DMB and DSB
(ISHLD, OSHLD, NSHLD, LD), there are LDREX/STREX with acquire/release
semantics, a new SEVL instruction. User space needs to know about these
not only from a backwards compatibility perspective (I don't expect DMB
to ever go away) but from a future optimisation one.

If you are worried about the risk of running out of HWCAP bits (we still
have I think 32 left, we could also introduce elf_hwcap3), what about,
for new features, adding a HWCAP_CPUID (only when the extended CPUID is
present) and, when enabled, allow user space to probe CPUID registers
via an ARM-specific syscall or undef hooks? These would filtered by the
kernel, it doesn't need to always present the real register content,
especially on heterogeneous systems.

-- 
Catalin
