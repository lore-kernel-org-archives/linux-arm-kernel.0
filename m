From: luto@amacapital.net (Andy Lutomirski)
Date: Fri, 27 Jun 2014 16:17:52 -0700
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <20140627230736.GX32514@n2100.arm.linux.org.uk>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
 <20140627200949.GQ32514@n2100.arm.linux.org.uk>
 <20140627210931.GT23102@port70.net>
 <20140627213051.GS32514@n2100.arm.linux.org.uk>
 <20140627215541.GC16724@brightrain.aerifal.cx>
 <20140627221744.GU32514@n2100.arm.linux.org.uk>
 <20140627223328.GB17988@brightrain.aerifal.cx>
 <20140627230736.GX32514@n2100.arm.linux.org.uk>
Message-ID: <CALCETrVFvYNPHMozB2E2L0LWSPv=o6JHfmoz4_pBC2gQwRLpug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 4:07 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> The kuser helpers can NOT be removed unless the CPU is v6k+.  Let me
> put that a different way: the kuser helpers can not be removed unless
> the ELF HWCAPs indicate TLS support.

Why?  (This is an honest question -- there may be an excellent
answer.)  I understand why they're needed in the first place, but I
don't understand why they need to live at a fixed address.

The closest thing to this that I'm familiar with is x86_32's sysenter.
It's a very useful instruction, but it's basically impossible for libc
to contain a sysenter instruction in the libc image.  So the kernel
provides one *at a randomized address*, and libc calls it.

Admittedly, x86_32 has an advantage over ARM here: libc without a
sysenter helper is completely functional; it's just slower.
Nonetheless, ISTM it should be possible to start advertising the kuser
helper address to libc, get all the libcs to play along, and then
offer an option of randomizing it for people who know that they don't
have any old libcs on their systems.

--Andy
