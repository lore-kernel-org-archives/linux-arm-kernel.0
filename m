From: andrew.pinski@caviumnetworks.com (Andrew Pinski)
Date: Wed, 2 Sep 2015 22:52:05 +0800
Subject: [PATCHv2] ARM64: Add AT_ARM64_MIDR to the aux vector
In-Reply-To: <20150902165752.782e75be@i7>
References: <1440873982-44062-1-git-send-email-apinski@cavium.com>
 <20150901163304.GC16430@leverpostej>
 <A9115CAF-0C57-4810-97F6-6245E7D0CE48@gmail.com>
 <4C8DD5E0-E1EA-40C6-B947-72189241023C@caviumnetworks.com>
 <20150901173043.GE16430@leverpostej>
 <9AA83792-C973-4642-88BA-3C59F23EB048@gmail.com>
 <20150901221254.5e08ab6e@i7>
 <8C837F8F-050A-45DD-882B-02E107EFD663@caviumnetworks.com>
 <20150902165752.782e75be@i7>
Message-ID: <CA+=Sn1=27ibpBokqJj3vLZ7NsnovKRdq7mR22ReeJJya4ona-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 2, 2015 at 9:57 PM, Siarhei Siamashka
<siarhei.siamashka@gmail.com> wrote:
> On Wed, 2 Sep 2015 00:28:28 +0000
> "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com> wrote:
>
>> > On Sep 2, 2015, at 3:13 AM, Siarhei Siamashka <siarhei.siamashka@gmail.com> wrote:
>> >
>> > On Wed, 2 Sep 2015 01:58:56 +0800
>> > pinskia at gmail.com wrote:
>> >
>> >>> On Sep 2, 2015, at 1:30 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> >>>
>> >>> [...]
>> >>>
>> >>>>>>> On Sat, Aug 29, 2015 at 07:46:22PM +0100, Andrew Pinski wrote:
>> >>>>>>> It is useful to pass down MIDR register down to userland if all of
>> >>>>>>> the online cores are all the same type.  This adds AT_ARM64_MIDR
>> >>>>>>> aux vector type and passes down the midr system register.
>> >>>>>>>
>> >>>>>>> This is alternative to MIDR_EL1 part of
>> >>>>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/358995.html.
>> >>>>>>> It allows for faster access to midr_el1 than going through a trap and
>> >>>>>>> does not exist if the set of cores are not the same.
>> >>>>>>
>> >>>>>> I'm not sure I follow the rationale. If speed is important the
>> >>>>>> application can cache the value the first time it reads it with a trap.
>> >>>>>
>> >>>>> It is also about compatibility also. Exposing the register is not backwards compatible but using the aux vector is.
>> >>>>
>> >>>> That would also break big.little too. So either break it with hot plug or break it in userland, your choice.
>> >>>
>> >>> The value wouldn't be representative of the system as a whole; that is
>> >>> true. However, we never guaranteed that it was, while the aux vector
>> >>> code implied that we did.
>> >>
>> >> Yes but I guess you talk about caching the value in userspace but doing
>> >> it via the aux vector is the same as your suggestion. Just one
>> >> difference is you don't get the aux vector entry if there is a CPU
>> >> that is online which is different. No difference from your suggestion
>> >> of caching it. Without considering hot pug for a second (that is a
>> >> huge different issue all together), if userland wants to know if all
>> >> up CPUs have the same midr, they would either read /sys entries (lots
>> >> of syscalls) or bind to each CPU and do the trap. That means at least
>> >> three or two syscalls/traps for each CPU. My way is none and gets a
>> >> value of midr if they are all the Same for free.
>> >
>> > Andrew, how do you propose to get the value of MIDR? Open the
>> > "/proc/self/auxv", read it, do a linear search in the buffer to find
>> > the required entry and then read the value? Or use the glibc specific
>> > getauxval() function (https://lwn.net/Articles/519085) ?
>>
>> This is inside glibc I am talking about so getauxval.
>
> OK. Point taken.
>
>> > Regarding the caching implementation, one can open and parse the
>> > "/proc/cpuinfo" file (with older kernels) or read the new sysfs
>> > entries to get the MIDR value for each core. Then create a lookup
>> > table. As an additional bonus, this lookup table can contain not
>> > just the MIDR values, but any arbitrary data in any format (for
>> > example, a function pointer to the memcpy function or anything else).
>>
>> You don't want to do that early on in ld.so each time a program
>> starts up. Too much overhead.
>
> Right.
>
>> > After the lookup table is available, one can use the getcpu() syscall
>> > for getting the CPU number and do the table lookup. And for getting
>> > reasonable performance, implement the vdso variant of the getcpu()
>> > syscall.
>> >
>> > All of this internal ugliness would be best abstracted inside
>> > of the GCC __builtin_cpu_init(), __builtin_cpu_is() and
>> > __builtin_cpu_supports() builtins:
>> >    http://gcc.gnu.org/gcc-4.8/changes.html
>>
>> Yes but this is about glibc support and not other userland
>> support. Having glibc depend on that is even worse.
>
> Well, basically you are saying that you only care about your
> individual use case (glibc only, 64-bit only, no support for
> big.LITTLE) and just don't give rats about anything else. This
> is not necessarily wrong, but we are not getting the problem
> solved on a wider scale with such approach.
>
> Regarding the reliance on the getauxval() function. Appears that
> at least it seems to be also supported in recent versions of Android
> and in musl too. So it already has a wide support in the Linux
> different flavours and just needs a configure check in regular
> applications/libraries. This is not perfect, but not bad either
> and will only get better in the future.
>
> Regarding the performance. Avoiding to open and read any files
> surely helps to make the setup cost lower. In this sense, the
>     http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/359127.html
> patch is not very good because we would have to deal with multiple
> files, increasing the overhead even more.
>
> Regarding the big.LITTLE hardware. We can't just ignore it and
> pretend that it does not exist. This would be rather short-sighted.
> Just like not thinking about allowing userspace access to the MIDR
> register was a short-sighted decision in the past for ARMv8 and
> earlier architectures.
>
> So let's review everything. You are suggesting that we should try
> to read AT_ARM64_MIDR via getauxval (btw, why ARM64 in the name?) and
> if it is found, then all the CPU cores are identical and we have the
> MIDR value. If it is not found, then we should check AT_HWCAP for the
> HWCAP_CPUID bit and read the MIDR register directly (which will be
> trapped, but emulated in the kernel).
>
> The HWCAP_CPUID approach and emulation looks interesting, because it
> might probably motivate ARM to actually implement direct userspace
> access to the MIDR register in the future revisions of hardware :-)
>
> Now I wonder about the performance difference between the kernel
> emulated MIDR read and the performance of doing a table lookup, using
> sched_getcpu() result as an index. And I have done some preliminary
> tests. On my Cortex-A7 processor, running "sched_getcpu()" in a loop
> takes ~200 cycles per iteration. Running "getauxval(AT_PLATFORM)" in
> the same loop takes ~100 cycles per iteration. The emulated SWP and
> unaligned LDM instructions take around ~500 and ~400 cycles. But the
> emulation of the MIDR register read should be much more lightweight
> than SWP/LDM, so it might be more competitive with sched_getcpu()
> and I will benchmark this later.
>
> I wonder if we still can try to make "sched_getcpu()" use vDSO
> instead of the syscall to make it faster? Now that there exists a
> vDSO implementation for gettimeofday(), everything should be easy if
> we can find an unused userspace readable coprocessor register.
> In the past, Catalin Marinas mentioned that "We have a user read-only
> thread register unused on arm64":
>     http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/220664.html
> And if I understand it correctly, also one of the "scratch registers"
> should exist in 32-bit ARM, which "isn't present in ARMv8/AArch64":
>     http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/221056.html
> What kind of registers are these exactly?
>
> In principle, the aux vector can be extended to also contain a pointer
> to an array of MIDR values for all the CPU cores if reducing the setup
> overhead is critical.

That is not a bad idea.  Put this array in the data section of the
VDSO too.  It should be small enough though on systems with 96 or more
cores (dual socket ThunderX has 96 cores total), it is slightly
getting big.
The struct would be something like:
struct
{
  int32 numcores;
  int32 midr[];
};

Which you place right after the current data.  This would allow for
shared read only data between the processes and not needed to waste
other space.
I will try to  program this up in a few days and that will solve my
issue really.  I can cache in userspace if they are the same.  Also it
avoids a trap which can be more expensive than a cache misses.

Thanks,
Andrew Pinski

>
> The GCC __builtin_cpu_is() and __builtin_cpu_supports() builtins are
> unrelated to the kernel and not really needed for glibc, but it's
> important to ensure that they can be implemented efficiently on ARM.
> It would be great if we could delegate all this ugly and hairy
> runtime CPU features detection task to GCC. Instead of implementing
> it in every application and library, which makes use of assembly
> optimizations.
>
> --
> Best regards,
> Siarhei Siamashka
