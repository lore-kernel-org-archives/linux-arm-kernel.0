From: philipp.tomsich@theobroma-systems.com (Dr. Philipp Tomsich)
Date: Tue, 14 Apr 2015 16:54:22 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <2069111.6po5Xr33Dn@wuerfel>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <3234795.e0Uq9k2nUp@wuerfel>
 <76000FE9-46E5-4883-9E4F-C65444FD406C@theobroma-systems.com>
 <2069111.6po5Xr33Dn@wuerfel>
Message-ID: <38FDDD2B-89C4-43C8-897D-A9DB6D023B7D@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 14 Apr 2015, at 16:07, Arnd Bergmann <arnd@arndb.de> wrote:

>>>> B is just as bad and goes against using the generic syscall numbers. 
>>> 
>>> How so? The newly introduce syscalls then would be the generic ones.
>> 
>> By applying the ?strace-test? (i.e. ?How will this affect the implementation of strace,
>> when considering a ILP32-compiled and a LP64-compiled strace where both should
>> be capable of tracing either ILP32 or LP64 targets??), option (b) appears the cleanest
>> choice, as no test on the dependent?s ABI would be necessary and all internal 
>> dispatching could be performed on syscall numbers alone.
>> 
>> Using the same "strace-test", option (d) would be the least preferred, as it will make 
>> the internal dispatching entirely dependent on the dependent?s ABI.
> 
> I don't understand what you mean here, please elaborate. Why would an ABI that works
> on aarch32 be wrong on aarch64-ilp32 user space when you are using the same header
> files?

AArch32 and AArch64/ILP32 are entirely different instruction set architectures. They have
differently sized register files (AArch64 has about twice as many registers and each one is
64bits in size) and different register usage conventions. 

This affects other ?implementation details? such as the ucontext, too.
For the sake of simplicity, I?ll refer to it just as ?register file? below.

This means that we would end up with very distinct code paths for the ?dependent? in tools
(such as strace), if option (d) was used:
	LP64:	AArch64 context + 64bit syscall interface
	ILP32:	AArch64 context + 32bit syscall interface
	AArch32:	AArch32 context + 32bit syscall interface

If we could agree on option (b), things would be much simpler:
	LP64:	AArch64 context + 64bit syscall interface
	ILP32:	AArch64 context + 64bit syscall interface + ILP32 compat-syscalls
	AArch32:	AArch32 context + 32bit syscall interface

I.e. for all tools involved (whether it?s strace, gdb, etc.), LP64 and ILP32 can and should
look very similar. After all, they differ in their sizeof(ptr_t) and sizeof(long), only.
AArch32, on the other hand, is very dissimilar to AArch64? it?s a different architecture.

But this is talking from a tools-perspective...


Best,
Philipp.
