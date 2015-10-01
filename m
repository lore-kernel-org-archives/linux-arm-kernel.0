From: Andrew.Pinski@caviumnetworks.com (Pinski, Andrew)
Date: Thu, 1 Oct 2015 21:49:46 +0000
Subject: [PATCH v5 00/23] ILP32 for ARM64
In-Reply-To: <1708349.DFbfvHcnCR@wuerfel>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
 <20150930101918.GA9753@e104818-lin.cambridge.arm.com>
 <20151001191520.GA25295@yury-N73SV>,<1708349.DFbfvHcnCR@wuerfel>
Message-ID: <F6B719D8-1FC0-4B26-A926-40FB6953AAE3@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Oct 1, 2015, at 2:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
>> On Thursday 01 October 2015 22:15:20 Yury Norov wrote:
>> 
>> Regarding time_t, it, of course, doesn't takes much time to make it
>> 32-bit, but I think 64 bit is better because of Y2038. X32 and mips
>> n32 has time_t 64-bit (and ppc, not sure), and that's OK for them.
> 
> I'm pretty sure that n32 has 32-bit time_t, and we know that it still
> causes real-world problems on x32: socket timestamps, v4l, alsa and
> other subsystems all have bugs in this area that are hard to fix.
> 
>> That's OK for BSD as well. The objection may come from users of ABI,
>> complaining portability problems, but I found no such complains in
>> public discussions.
>> 
>> Nevertheless, as I told, I do not see any problem to rework time_t.
>> But some arguments supporting this decision are appreciated.
>> 
>> The downside of 32 bit time_t is that we still face Y2038 problem,
>> but that's the other story fixing it.
> 
> The main reason for 32-bit time_t is compatibility with existing
> ioctls (also getsockopts and some others), and having a sane way
> for fixing them. We cannot change compat_time_t to be 64-bit
> without breaking arm32 compat mode, and we can't use the native
> 64-bit ioctl implementation on ARM64/ILP32 because that breaks
> all interfaces that pass 'long' or a pointer.
> 
> This means drivers that currently pass a time_t (or timeval, timespec
> etc) need to not only have a compat_ioctl handler to convert it,
> they also need to check whether which of the two compat modes they
> are talking to. This is a mess to add (I know, because I'm working
> on this for y2038 compliance for normal 32-bit mode), and making
> the two behave differently makes it even harder to get right for
> all cases.
> 
>> __kernel_long_t is the same. Now it's 64 bits length. Compatibility
>> may suffer, but, again, there're no complains, and in long run it
>> looks better.
> 
> __kernel_long_t isn't actually used that much, and rarely used in
> places where it matters. The idea was to be able to reuse the
> native syscalls rather than the compat syscall calls, but that
> comes with the downside of defining the ABI in a way that is
> incompatible with all other 32-bit user space.
> 
> Having a 64-bit __kernel_off_t is similar to the 64-bit time_t:
> a good idea in principle, but it breaks device drivers that
> expect user space to pass 32-bit arguments. For any interface
> that really needs 64-bit data, we have to fix it for all
> 32-bit architectures, and we're better off avoiding special
> cases.

Ok, we will rewrite these patches using 32bit time_t and 32bit off_t and redo the toolchain support for them.  Note this is going back to the abi I had originally done when I submitted my original version when it was asked to change time_t to be 64bit. 

Thanks,
Andrew


> 
>    Arnd
