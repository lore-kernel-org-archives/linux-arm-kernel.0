From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Tue, 1 Sep 2015 22:12:54 +0300
Subject: [PATCHv2] ARM64: Add AT_ARM64_MIDR to the aux vector
In-Reply-To: <9AA83792-C973-4642-88BA-3C59F23EB048@gmail.com>
References: <1440873982-44062-1-git-send-email-apinski@cavium.com>
 <20150901163304.GC16430@leverpostej>
 <A9115CAF-0C57-4810-97F6-6245E7D0CE48@gmail.com>
 <4C8DD5E0-E1EA-40C6-B947-72189241023C@caviumnetworks.com>
 <20150901173043.GE16430@leverpostej>
 <9AA83792-C973-4642-88BA-3C59F23EB048@gmail.com>
Message-ID: <20150901221254.5e08ab6e@i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Sep 2015 01:58:56 +0800
pinskia at gmail.com wrote:

> > On Sep 2, 2015, at 1:30 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > [...]
> > 
> >>>>> On Sat, Aug 29, 2015 at 07:46:22PM +0100, Andrew Pinski wrote:
> >>>>> It is useful to pass down MIDR register down to userland if all of
> >>>>> the online cores are all the same type.  This adds AT_ARM64_MIDR
> >>>>> aux vector type and passes down the midr system register.
> >>>>> 
> >>>>> This is alternative to MIDR_EL1 part of
> >>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/358995.html.
> >>>>> It allows for faster access to midr_el1 than going through a trap and
> >>>>> does not exist if the set of cores are not the same.
> >>>> 
> >>>> I'm not sure I follow the rationale. If speed is important the
> >>>> application can cache the value the first time it reads it with a trap.
> >>> 
> >>> It is also about compatibility also. Exposing the register is not backwards compatible but using the aux vector is.
> >> 
> >> That would also break big.little too. So either break it with hot plug or break it in userland, your choice.
> > 
> > The value wouldn't be representative of the system as a whole; that is
> > true. However, we never guaranteed that it was, while the aux vector
> > code implied that we did.
> 
> Yes but I guess you talk about caching the value in userspace but doing
> it via the aux vector is the same as your suggestion. Just one
> difference is you don't get the aux vector entry if there is a CPU
> that is online which is different. No difference from your suggestion
> of caching it. Without considering hot pug for a second (that is a
> huge different issue all together), if userland wants to know if all
> up CPUs have the same midr, they would either read /sys entries (lots
> of syscalls) or bind to each CPU and do the trap. That means at least
> three or two syscalls/traps for each CPU. My way is none and gets a
> value of midr if they are all the Same for free. 

Andrew, how do you propose to get the value of MIDR? Open the
"/proc/self/auxv", read it, do a linear search in the buffer to find
the required entry and then read the value? Or use the glibc specific
getauxval() function (https://lwn.net/Articles/519085) ?

Regarding the caching implementation, one can open and parse the
"/proc/cpuinfo" file (with older kernels) or read the new sysfs
entries to get the MIDR value for each core. Then create a lookup
table. As an additional bonus, this lookup table can contain not
just the MIDR values, but any arbitrary data in any format (for
example, a function pointer to the memcpy function or anything else).

After the lookup table is available, one can use the getcpu() syscall
for getting the CPU number and do the table lookup. And for getting
reasonable performance, implement the vdso variant of the getcpu()
syscall.

All of this internal ugliness would be best abstracted inside
of the GCC __builtin_cpu_init(), __builtin_cpu_is() and
__builtin_cpu_supports() builtins:
    http://gcc.gnu.org/gcc-4.8/changes.html

One big.LITTLE systems, the __builtin_cpu_is() could be implemented
via a single getcpu() syscall and the table lookup, like explained
above. The __builtin_cpu_init() could prepare the lookup table.
And on normal systems with identical cores, the use of the syscall
is not required.

It might be interesting to also optionally allow something like this:
    __builtin_cpu_is("cortex-a7 || cortex-a15")
Which would mean that we are interested in checking for the
Cortex-A7+Cortex-A15 pair in a big.LITTLE system, but are not
interested in knowing whether we are running on A7 or A15 in this
particular moment (and avoid the syscall overhead).

We had an old discussion on a similar CPU type identification topic
in the past:
    http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/220542.html
I have been told that it had been forwarded to the Linaro toolchain
people, but did not track if this resulted in anything useful or not.

I think that it would be best to prefer something that is easily usable
for all applications and libraries, and not just something for a private
use by glibc. To sum everything up:

One the kernel side it means:
  1. Maybe implement vdso for getcpu(), this will make things faster
     on big.LITTLE systems.
  2. Maybe implement sysfs entries for per-core MIDR values from
       http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/359127.html
     This will make things faster and allow to avoid potentially
     messy and cumbersome /proc/cpuinfo text parsing.

On the GCC side it means:
  1. Implement __builtin_cpu_init(), __builtin_cpu_is() and
     __builtin_cpu_supports() builtins, which rely on reading sysfs
     entries (with a fallback to /proc/cpuinfo parsing on old kernels)
     and the getcpu() syscall for the reasonably accurate core type
     runtime identification on big.LITTLE systems.

On the applications/libraries side (including, but not limited to glibc)
it means:
  1. Rely on the GCC __builtin_cpu_init(), __builtin_cpu_is() and
     __builtin_cpu_supports() builtins.
  2. Maybe implement the replacement of these builtins to get all the
     same functionality even with the old versions of GCC.

-- 
Best regards,
Siarhei Siamashka
