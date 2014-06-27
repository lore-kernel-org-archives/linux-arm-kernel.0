From: luto@amacapital.net (Andy Lutomirski)
Date: Fri, 27 Jun 2014 15:51:04 -0700
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <20140627224017.GU23102@port70.net>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
 <20140627200949.GQ32514@n2100.arm.linux.org.uk>
 <20140627210931.GT23102@port70.net>
 <20140627213051.GS32514@n2100.arm.linux.org.uk>
 <20140627215541.GC16724@brightrain.aerifal.cx>
 <20140627221744.GU32514@n2100.arm.linux.org.uk>
 <20140627224017.GU23102@port70.net>
Message-ID: <CALCETrWOfhpT5LCurbQqCd9keSk-fTmwa+OHjCyHYo9LAhBeqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 3:40 PM, Szabolcs Nagy <nsz@port70.net> wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [2014-06-27 23:17:44 +0100]:
>> I think you're are missing one obvious solution to this which you can do:
>> you are passed the HWCAP fields in the ELF auxinfo.  This will tell you
>> if the CPU has TLS support or not.  If it has TLS support, then you don't
>> need to use the kuser helpers, and you know that it is a CPU which is ARM
>> architecture v6k or later, and it has things like the CP15 barrier
>> instructions.  If you want to know that the CPU supports the DMB
>> instruction rather than the CP15 barrier instruction, then you have to
>> check the uname details, or read /proc/cpuinfo (but I'd rather you
>> didn't.)
>>
>
> but cp15 barrier is deprecated on armv7+
>
> and i think the kernel can avoid the barriers on non-smp systems making
> kuser helpers possibly preferable even if TLS HWCAP flag is set

IMO it would be much better to do this by either telling userspace
that the system is !SMP or by allowing the kuser helpers to live at a
randomized address.

There's already been at least one paper describing an exploit
technique that's blocked by vsyscall emulation.  This kind of
hardening takes a while to get deployed, and making new userspace not
depend on fixed-address code is a good thing to get started on, at
least when targetting newer hardware.

--Andy
