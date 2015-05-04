From: philipp.tomsich@theobroma-systems.com (Dr. Philipp Tomsich)
Date: Mon, 4 May 2015 12:32:30 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <3908616.DHRS6D2Ytk@wuerfel>
References: <025BB233-8D14-457A-B3B2-C6BD6C3B32EF@theobroma-systems.com>
 <0394DFCE-2D52-4028-A9F5-BE4285AFC5D9@theobroma-systems.com>
 <6299275.Ntfb3Dzi12@wuerfel> <3908616.DHRS6D2Ytk@wuerfel>
Message-ID: <7C69BC10-51BC-4276-95A6-9BE6B70A6D75@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Where can I pull this prototype implementation from?
As we are working on getting a final ILP32 change-set ready, I?d like to make
sure that we base this on the latest consensus for new ILP32 ABIs on 64bit
machines.

Thanks,
Philipp.

> On 04 May 2015, at 12:29, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> On Saturday 18 April 2015 21:24:19 Arnd Bergmann wrote:
>> Given Catalin's comments from yesterday, I think we can just fix the
>> definitions of 'struct stat64' for asm-generic to make it have the same
>> layout as the 64-bit version of 'struct stat', and use that for aarch64-ilp32.
>> 
>> Similarly for the four sysvipc headers, we can have a modified version of
>> the asm-generic ones in arch/arm64/uapi/asm, which will use the same layout
>> for ilp32 and lp64 without having to set __kernel_ulong_t to 64-bit.
> 
> To pick up that earlier thread, I now have a prototype implementation for
> converting all 32-bit architectures to use 64-bit time_t.
> 
> For 'struct stat', I ended up introducing a new structure on arm32 that
> matches the layout of arm64 (and I did the same for all other 32-bit
> architectures that have a 64-bit counterpart). This means we can share
> the same system calls between arm64-lp64, arm64-ilp32 and arm32 with
> 64-bit time_t and arm64-aarch32 emulation for 32-bit time_t, while
> using the existing compat handling for the original 'struct stat'
> emulation in both arm32 and arm64-aarch32.
> 
> However, for ipc, the situation is different: I found a way to use
> extra padding fields in semid64_ds/shmid64_ds/msqid64_ds, so the
> ipc system calls will still use normal 32-bit data structures
> on arm32 and arm64-aarch64, but you cannot use them arm64-ilp32,
> and will have to #ifdef the three header files there to choose between
> the two implementations.
> 
> 	Arnd
