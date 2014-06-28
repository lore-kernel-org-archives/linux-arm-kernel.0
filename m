From: dalias@libc.org (Rich Felker)
Date: Fri, 27 Jun 2014 20:11:43 -0400
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <20140627225445.GV32514@n2100.arm.linux.org.uk>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
 <20140627200949.GQ32514@n2100.arm.linux.org.uk>
 <20140627210931.GT23102@port70.net>
 <20140627213051.GS32514@n2100.arm.linux.org.uk>
 <20140627215541.GC16724@brightrain.aerifal.cx>
 <20140627221744.GU32514@n2100.arm.linux.org.uk>
 <CALCETrUvPV0xmw1jCVdwJ8KW3HMW8JKoCRnHcUyuU-1ze=6X8A@mail.gmail.com>
 <20140627225445.GV32514@n2100.arm.linux.org.uk>
Message-ID: <20140628001143.GA19165@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 11:54:45PM +0100, Russell King - ARM Linux wrote:
> Oh, I should also have mentioned: for a libc, if you want to stretch
> across from ARMv4 all the way up to ARMv7, then you have to do lots
> more than just worry about thread local storage.  You also have the
> problem that you can't just fall back on the SWP instruction to
> provide atomic implementations - this instruction has been deprecated
> and for the latest CPUs, the kernel may be configured to emulate this
> instruction.  Besides, on ARMv6 and later, you really want to use the
> load/store exclusive instructions for implementing atomic accesses
> and not the horrid SWP instruction.  So you need to implement atomic
> stuff using SWP for some CPUs and the new load/store exclusive for
> other CPUs.

SWP is mostly useless for implementing the POSIX threads primitives,
most of which need compare-and-swap due to the requirement of
self-synchronized destruction. At the source level we do a swap
operation in a couple places, but so far on ARM it's just implemented
in terms of CAS. We could revisit this once there's runtime selection
of the lock code anyway; using SWP might make a big difference for
internal locks (e.g. in malloc) where the CAS semantics are not
needed.

Rich
