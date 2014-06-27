From: luto@amacapital.net (Andy Lutomirski)
Date: Fri, 27 Jun 2014 15:25:32 -0700
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <20140627221744.GU32514@n2100.arm.linux.org.uk>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
 <20140627200949.GQ32514@n2100.arm.linux.org.uk>
 <20140627210931.GT23102@port70.net>
 <20140627213051.GS32514@n2100.arm.linux.org.uk>
 <20140627215541.GC16724@brightrain.aerifal.cx>
 <20140627221744.GU32514@n2100.arm.linux.org.uk>
Message-ID: <CALCETrUvPV0xmw1jCVdwJ8KW3HMW8JKoCRnHcUyuU-1ze=6X8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 3:17 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jun 27, 2014 at 05:55:41PM -0400, Rich Felker wrote:
>> I think you're assuming that libc is used only as a shared library and
>> that the user installs one appropriate for their kernel. This
>> precludes the use of static-linked binaries which are an extremely
>> important usage case for us, especially on ARM where, for example, we
>> want users to be able to make binaries that have a fully-working libc
>> but that can be run on Android, where neither musl nor any other
>> remotely-working libc is installed by default.
>>
>> Obviously some (many) users will opt to build libc with a particular
>> -march where all of the necessary instructions for TLS and atomics are
>> available without help from the kernel. However, if attempting to
>> build a baseline libc that works on any model results in one that
>> can't work on new hardware/kernel, that's a big problem, and exactly
>> the one which I'm trying to solve.
>
> As I've already said, that's a system integrator bug to have a kernel
> without a kuser page with userspace which requires it.

Shouldn't the goal be to reduce the number of new userspace programs
that require a kuser page on TLS-capable hardware?  In 2012, I made an
effort to do exactly that on x86_64 wrt the vsyscall page, and, these
days, a system booted with vsyscall=none is likely to be fully
functional as long as vdso=0 isn't specified.  Hopefully, in a couple
of years, even vdso=0 vsyscall=none will work with all freshly-built
binaries.

>
> I think you're are missing one obvious solution to this which you can do:
> you are passed the HWCAP fields in the ELF auxinfo.  This will tell you
> if the CPU has TLS support or not.  If it has TLS support, then you don't
> need to use the kuser helpers, and you know that it is a CPU which is ARM
> architecture v6k or later, and it has things like the CP15 barrier
> instructions.  If you want to know that the CPU supports the DMB
> instruction rather than the CP15 barrier instruction, then you have to
> check the uname details, or read /proc/cpuinfo (but I'd rather you
> didn't.)

That sounds helpful.  Would it make sense to try to convince all libc
providers (and Go!) to do this?

If DMB vs CP15 makes a big difference, then adding that to HWCAP might
be a good idea.

--Andy
