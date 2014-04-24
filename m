From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Thu, 24 Apr 2014 09:59:59 -0500
Subject: [PATCH v6 0/6] ARM: vdso gettimeofday using generic timer
 architecture
In-Reply-To: <20140423215040.GC26756@n2100.arm.linux.org.uk>
References: <cover.1398213562.git.nathan_lynch@mentor.com>
 <20140423215040.GC26756@n2100.arm.linux.org.uk>
Message-ID: <535926EF.20805@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2014 04:50 PM, Russell King - ARM Linux wrote:
> On Tue, Apr 22, 2014 at 07:48:51PM -0500, Nathan Lynch wrote:
>> - Build vdso.so with -lgcc: calls to __lshrdi3, __divsi3 sometimes
>>   emitted (especially with -Os).  Override certain libgcc functions to
>>   prevent undefined symbols.
> 
> This rather worries me.
> 
> For a start, the toolchain I use for cross-building kernels (which I
> build myself from gnu.org source) never has a libgcc with it - that's
> because in order to build libgcc, I need a libc, and I don't want to
> have a full cross environment on my machine just to build the soddin
> compiler.
> 
> So, I want to be able to build kernels without having a libgcc sitting
> around.

I should be able to accommodate that (see Ard's suggestion for a
possible approach).


> Second point here is that we have multiple different versions of
> userspace crap with multiple different ABIs.  Think about armel vs
> armhf for starters.  There's at least *three* different ELF formats -
> OABI, EABI armel, EABI armhf.  Okay, we can forget about OABI, but
> what about the other two?  What about single zImage where you may
> want a single kernel image which can run on either flavour?

I confess I had not contemplated that use case.


> It is not possible to build a single .so which is compatible with
> both - an armhf dynamic linker rejects armel outright, and vice versa.
> 
> This, to me, sounds like one big fail... and as far as I'm aware, the
> kernel has no idea itself which flavour of userspace is running, so it
> has no idea which flavour of VDSO to offer (if it even had both.)

Maybe I'm confused about something, but I'm able to use the vdso fine
with an armhf userspace:

# readelf -A vdso.txt # dumped from /proc/pid/mem
Attribute Section: aeabi
File Attributes
  Tag_CPU_name: "6K"
  Tag_CPU_arch: v6K
  Tag_ARM_ISA_use: Yes
  Tag_THUMB_ISA_use: Thumb-1
  Tag_FP_arch: VFPv2
  Tag_ABI_PCS_wchar_t: 4
  Tag_ABI_FP_denormal: Needed
  Tag_ABI_FP_exceptions: Needed
  Tag_ABI_FP_number_model: IEEE 754
  Tag_ABI_align_needed: 8-byte
  Tag_ABI_enum_size: int
  Tag_ABI_optimization_goals: Aggressive Speed
  Tag_CPU_unaligned_access: v6
# readelf -A /usr/bin/vdsotest
Attribute Section: aeabi
File Attributes
  Tag_CPU_name: "7-A"
  Tag_CPU_arch: v7
  Tag_CPU_arch_profile: Application
  Tag_ARM_ISA_use: Yes
  Tag_THUMB_ISA_use: Thumb-2
  Tag_FP_arch: VFPv3-D16
  Tag_ABI_PCS_wchar_t: 4
  Tag_ABI_FP_rounding: Needed
  Tag_ABI_FP_denormal: Needed
  Tag_ABI_FP_exceptions: Needed
  Tag_ABI_FP_number_model: IEEE 754
  Tag_ABI_align_needed: 8-byte
  Tag_ABI_align_preserved: 8-byte, except leaf SP
  Tag_ABI_enum_size: int
  Tag_ABI_HardFP_use: SP and DP
  Tag_ABI_VFP_args: VFP registers
  Tag_CPU_unaligned_access: v6
  Tag_MPextension_use: Allowed
  Tag_Virtualization_use: TrustZone
# LD_TRACE_LOADED_OBJECTS=1 /usr/bin/vdsotest
        linux-vdso.so.1 (0xbec96000)
        librt.so.1 => /lib/arm-linux-gnueabihf/librt.so.1 (0xb6fca000)
        libdl.so.2 => /lib/arm-linux-gnueabihf/libdl.so.2 (0xb6fbf000)
        libc.so.6 => /lib/arm-linux-gnueabihf/libc.so.6 (0xb6ed8000)
        libpthread.so.0 => /lib/arm-linux-gnueabihf/libpthread.so.0
(0xb6ebd000)
        /lib/ld-linux-armhf.so.3 (0xb6fd8000)
# vdsotest -v clock-gettime-realtime bench
clock-gettime-realtime: syscalls = 324192, vdso calls = 3282333
clock-gettime-realtime system calls per second: 648309
clock-gettime-realtime vdso calls per second:   6563926 (10.12x speedup)

(That's with a kernel with lots of debugging enabled, don't get excited
about the speedup reported.)

The test program (vdsotest) is using dlsym to get at the vdso and the
glibc is straight from a Linaro toolchain, no vdso patches.
