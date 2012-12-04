From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Dec 2012 22:18:51 +0000
Subject: [ARM] head.S change broke platform device registration?
In-Reply-To: <CAHod+GdXfZb1OHapJBYpCD74svYyaGaiZpqHLPtjHbWGa-3eLA@mail.gmail.com>
References: <CAHod+GdVobkgOj6bsFhn6qqLhysQoEzcDtAS05u1kPnssSfObg@mail.gmail.com>
 <50B88A59.6070207@arm.com>
 <CAHod+GeZQx6-pUHPocbyMJCLawMUhrZuZf=mrgWax=L7eNJGhg@mail.gmail.com>
 <20121130143435.GP19440@n2100.arm.linux.org.uk>
 <CAHod+GdXfZb1OHapJBYpCD74svYyaGaiZpqHLPtjHbWGa-3eLA@mail.gmail.com>
Message-ID: <20121204221851.GJ14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 04, 2012 at 10:48:56PM +0100, Marko Kati? wrote:
> I have included the complete dmesg log of vanilla 3.7.0-rc7 in my
> previous mail.
> Here's a relevant snippet of it:
> 
> Linux version 3.7.0-rc7+ (dromede at dromedary) (gcc version 4.7.2 (GCC)
> ) #63 PREEMPT Fri Nov 30 13:49:35 CET 2012
> CPU: XScale-PXA270 [69054117] revision 7 (ARMv5TE), cr=0000397f
> CPU: VIVT data cache, VIVT instruction cache
> Machine: SHARP Akita
> Memory policy: ECC disabled, Data cache writeback
> BUG: mapping for 0x00000000 at 0xff000000 out of vmalloc space
> 
> ....
> 
> Sharp Scoop Device found at 0x10800000 -> 0xc4846000
> 
> 
> It does seem that the kernel boots with the correct platform id.
> I doubt that the second scoop device somehow got registered
> and blocked those gpio numbers. It would fail to register, this would
> be visible in dmesg output. Also, the second scoop device starts at
> 0x08800040. So the above registered scoop device is scoop device 1.

Ok, so the correct boot ID throws my theory out, but I don't see
anything else that would claim those GPIOs and prevent the MAX device
registering its GPIOs.

You're going to have to boot -rc7, mount debugfs and read
/sys/kernel/debug/gpio to find out what is claiming those GPIOs that
the MAX device wants to use.  There is only _one_ other device for PXA
for Sharp devices which is hard-coded to the same GPIO numbers and that's
the Scoop 2 device - but that's not registered for the !machine_is_akita()
case.

Everything you've reported points to machine_is_akita() being false, which
it won't be given your Machine: line above.

So.. I don't know, and no one can explain the behaviour you're seeing.
