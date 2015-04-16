From: philipp.tomsich@theobroma-systems.com (Dr. Philipp Tomsich)
Date: Thu, 16 Apr 2015 13:19:14 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <20150416110325.GB819@e104818-lin.cambridge.arm.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <025BB233-8D14-457A-B3B2-C6BD6C3B32EF@theobroma-systems.com>
 <20150415100153.GA11626@localhost> <2243754.JW5bGY74bP@wuerfel>
 <20150415153800.GG22741@localhost>
 <C342B5CD-D1E2-4364-B99E-C85470A869BB@theobroma-systems.com>
 <20150415172219.GE26099@e104818-lin.cambridge.arm.com>
 <552EE560.9070205@suse.de>
 <20150416110325.GB819@e104818-lin.cambridge.arm.com>
Message-ID: <09A21550-3538-4A8E-AB12-A9A516D3E866@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just for the record (and to avoid anyone wasting their time on what?s available
today): we are migrating this over to option (a) now, even though we would
prefer to see option (b) implemented.

If we get a consensus on (b) in the next couple of days, we?ll redo things for
option (b). If not, we will have an implementation for option (a) available that
we can hopefully all agree on merging.

Best,
Phil.

> On 16 Apr 2015, at 13:03, Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> On Thu, Apr 16, 2015 at 12:25:36AM +0200, Alexander Graf wrote:
>> We've just started to bootstrap openSUSE for ILP32 with the non-final
>> abi. However, keep in mind that at least for us bootstrapping is a
>> manual process. So changing syscall numbers means we'll need to go
>> through the manual process again.
>> 
>> So if you need any help on getting you an environment that allows you to
>> build LTP with whatever syscall abi people come up with, feel free to
>> poke Andreas or me.
> 
> Thanks for the offer. It's great to see a full distro being built (even
> though no commitment).
> 
> But I'm a bit worried that people started using these patches and we
> haven't agreed on the ABI yet (well, for a while we thought that the x32
> approach was fine until I've seen objections from others).
> 
> Maybe a quick poll on the options, ignoring syscall number details (we
> go for the generic ones) or syscall tables sharing:
> 
> a) AArch32-like ILP32 ABI, 32-bit time_t, 32-bit __kernel_long_t
>   (POSIX-compliant)
> b) Future-proof ILP32 ABI, 64-bit time_t, 32-bit __kernel_long_t (as
>   seen by the user) (POSIX-compliant)
> c) LP64-like ILP32 ABI, 64-bit time_t, 64-bit __kernel_long_t
>   (non-POSIX-compliant)
> 
> Option (a) is the easiest from the kernel perspective and has the
> highest chance of not breaking legacy AArch32 applications.
> 
> Option (b) is more future looking (beyond 2038) but it introduces a
> third ABI in the kernel (incompatible with both compat and native).
> There is also a risk that legacy applications assume a 32-bit time_t.
> 
> Option (c) is pretty much what we currently have in these patches. While
> many syscalls are native LP64, it doesn't fully solve pointers in
> structures shared between user and kernel (ioctl being one of the
> affected areas)
> 
> I can't tell how bad the impact of non-POSIX compliance is. If this is
> essential, between (a) and (b) I'm more in favour of (a) as the easiest
> for both kernel and user. If we were to start a new ABI from scratch
> without legacy applications, I would have definitely gone for (b) but
> I'm worried about legacy applications still not fully working with this
> option while adding more maintenance burden in the kernel.
> 
> -- 
> Catalin
