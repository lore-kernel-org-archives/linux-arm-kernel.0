From: kaloz@openwrt.org (Imre Kaloz)
Date: Thu, 11 Apr 2013 20:37:00 +0200
Subject: Removal of NWFPE in its entirety, and VFP emulation code
In-Reply-To: <20130410190233.GK14496@n2100.arm.linux.org.uk>
References: <20130410104002.GF14496@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1304101307280.17375@syhkavp.arg>
 <20130410185522.GJ14496@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1304101457440.17375@syhkavp.arg>
 <20130410190233.GK14496@n2100.arm.linux.org.uk>
Message-ID: <op.wvd3byc02s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Apr 2013 21:02:33 +0200, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Wed, Apr 10, 2013 at 02:58:57PM -0400, Nicolas Pitre wrote:
>> On Wed, 10 Apr 2013, Russell King - ARM Linux wrote:
>>
>> > On Wed, Apr 10, 2013 at 01:30:35PM -0400, Nicolas Pitre wrote:
>> > > On Wed, 10 Apr 2013, Russell King - ARM Linux wrote:
>> > >
>> > > > I have just committed a patch to remove the arch/arm/nwfpe code from
>> > > > the kernel, and the VFP code emulating the FP operations.
>> > > >
>> > > > This I have done after it has been brought to my attention by the OSADL's
>> > > > GPL-violations project that the license for the softfloat library is
>> > > > incompatible with GPLv2.  This is because the FSF have ruled that
>> > > > indemnification clauses consitute an "additional restriction" which is
>> > > > incompatible with the GPLv2 section 6.  NWFPE contains the softfloat
>> > > > library, and VFP's emulation code is a derivative of softfloat.
>> > > >
>> > > > This will be very disruptive for ARMv4 and ARMv5 CPUs, which will no
>> > > > longer be able to run userspace with NWFPE support removed.  A possible
>> > > > solution there is to resurrect FASTFPE support and merge that into
>> > > > mainline in place of NWFPE.  FASTFPE's hooks are all present in the
>> > > > kernel, and it should just be a case of adding the FASTFPE code.
>> > > > However, FASTFPE is probably lacking GDB and signal stack support.
>> > > > (FastFPE's per-thread workspace is different from NWFPE.)
>> > >
>> > > A point worth mentioning is the EABI availability since 2006 which moved
>> > > away from FPA completely. A soft-float library in user space is used in
>> > > that case.  Major ARM binary producers including all ARM distros moved
>> > > to EABI with user space soft-float since then as it is order of
>> > > magnitude faster than FPA emulation.  So 99.99% of ARMv4 and ARMv5 users
>> > > are unlikely to be affected.
>> > >
>> > > So another option here might imply deprecating OABI support entirely,
>> > > given that it is useless without FPA and people keeping current with the
>> > > latest kernel are very likely to already use EABI user space.
>> >
>> > Unfortunately, I _still_ can't move off OABI.
>>
>> How can this be helped?
>
> I don't think there is a solution - as StrongARM is ARMv4 without Thumb
> support, which means that it's incompatible with EABI which uses bx and
> blx instructions.

May I ask, if you do LFS or are you using some existing distro? Is patching [1] your toolchain a no-go?


Imre


[1]
https://dev.openwrt.org/browser/trunk/toolchain/gcc/patches/4.7-linaro/830-arm_unbreak_armv4t.patch
https://dev.openwrt.org/browser/trunk/toolchain/gcc/patches/4.7-linaro/840-armv4_pass_fix-v4bx_to_ld.patch
