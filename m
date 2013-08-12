From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 12 Aug 2013 17:24:50 +0100
Subject: [Qemu-devel] SCSI bus failures with qemu-arm in kernel 3.8+
In-Reply-To: <52082EF8.10005@roeck-us.net>
References: <5207B3C3.9080508@roeck-us.net>
 <20130811220450.GY23006@n2100.arm.linux.org.uk>
 <52082EF8.10005@roeck-us.net>
Message-ID: <CAFEAcA94ygwRPSsfxs3DvOcTZbdafLiEHys94FG4aXUx+A1t=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 August 2013 01:40, Guenter Roeck <linux@roeck-us.net> wrote:
> On 08/11/2013 03:04 PM, Russell King - ARM Linux wrote:
>> It could be that it's qemu's PCI routing is wrong - it's not the first
>> time that qemu has got something wrong.

QEMU 1.5 has had its Versatile PCI routing code rewritten to
correspond with the hardware (cross-tested versus Arnd Bergmann's
patchset
http://marc.info/?l=linux-arm-kernel&m=128707282403376&w=2
which was run on real versatilePB backplane hardware and
could handle a PCI SATA card). I believe it to be correct,
and I spent a fairly long time wading through the various bits
of documentation and testing those kernel patches on h/w.

(It also includes a back-compatibility fudge so that old
kernels which assumed the old broken QEMU behaviour will
continue to work; it does not attempt to fix up the problems
with kernels from commit 1bc39ac5d to present which don't
work properly on either QEMU or real hardware. A fixed
kernel can force-disable the fudge.)

http://git.qemu.org/?p=qemu.git;a=blob;f=hw/pci-host/versatile.c
has the current PCI code, which includes comments about what
the routing is (in particular tables at lines 321 and 340).

>> Unfortunately, the PCI routing is totally undocumented, and as I
>> understand
>> it, there's very few backplanes out there now that finding out their real
>> routing is virtually impossible.  I'm loathed to change it unless someone
>> can point to a definitive source of information on this.

The Versatile boards have TRMs on infocenter.arm.com; the
backplane's wiring is documented in the circuit diagrams
which were distributed on the CD which came with the board
(ie they are non-confidential information, just difficult
to lay your hands on). It's also possible to just test
the hardware, which is what Arnd and I did to confirm that
his patchset was OK.

If somebody would like to fix the kernel I am happy to
locate the PCI backplane and test everything (again).
I would suggest that producing some patches which work
with QEMU 1.5 or later would be a good start; then we
can test on h/w as confirmation before they are applied.

-- PMM
