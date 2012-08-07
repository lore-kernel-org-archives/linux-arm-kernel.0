From: matt@genesi-usa.com (Matt Sealey)
Date: Tue, 7 Aug 2012 17:34:15 -0500
Subject: kernel entry for thumb2-only cpus
In-Reply-To: <alpine.LFD.2.02.1208061935380.5231@xanadu.home>
References: <20120803090452.GE2626@pengutronix.de>
 <20120803114532.GB26925@mudshark.cambridge.arm.com>
 <20120805095528.GO2626@pengutronix.de>
 <alpine.LFD.2.02.1208060026460.5231@xanadu.home>
 <CAKGA1b=Pxif=4qSvK-Odmunbm_T6LjWP_CXid_v2VNmpuyHLDA@mail.gmail.com>
 <20120806190856.GA1120@n2100.arm.linux.org.uk>
 <CAKGA1b=Np8+RMwgQEzwxdJcL6AjC4qiv1Jyq0bTTa_dHCeLokA@mail.gmail.com>
 <20120806194016.GB1120@n2100.arm.linux.org.uk>
 <CAKGA1b=hMZD3nd2sjXzR89-wX4BotxZwHOkkiLFoEL_CSS4zug@mail.gmail.com>
 <alpine.LFD.2.02.1208061829510.5231@xanadu.home>
 <CAKGA1bnJCSaVcErs3R8U3ZjQkhMmZAZPM=2P2R7udVc80ZmoDQ@mail.gmail.com>
 <alpine.LFD.2.02.1208061935380.5231@xanadu.home>
Message-ID: <CAKGA1b=UBEf783egzoKqyXipfgziOy7QremNbFoz_i+r1X_9hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 6, 2012 at 7:08 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Mon, 6 Aug 2012, Matt Sealey wrote:
>
>> I don't have a real *problem* with it, I just think since the kernel
>> can be compiled in both modes, but you may have some kind of remit to
>> not run ARM code (even if it's just a couple instructions at the
>> start) or some toolchain requirement or.. something.. it would be
>> entirely the bootloader's job to determine what mode it is in when it
>> jumps into the kernel. If you boot a Thumb bootloader and load an ARM
>> kernel, you'll get a crash. If you boot an ARM bootloader and a Thumb
>> kernel (with the current ARM instructions in head.S), you'll get a
>> crash. This is well defined, perfectly obvious, and I realise that..
>
> And isn't it also rather silly?

No?

> History has told that the more "entirely the bootloader's job" we rely
> on, the less reliable and interoperable we become.  Because you now have
> to compile two kernels to fully validate your bootloader instead of only
> one, and some people won't bother if the second kernel doesn't match
> their own use case.

That is true from a testing standpoint, and I guess I do agree with yourself and
Russell in this regard. But I do also think the chain of trust from
the bootloader
to kernel is important. I am in full violent disagreement with the
idea that doing
pin mux change operations based on a device tree description is both a necessity
or a requirement in Linux, especially as changing pin muxing this "late" in boot
is something a hardware designer would flip their lid over.

Sure, on some boards this is a requirement because the bootloaders do not do
the right thing, but in actual fact some of these boards (MX51 Babbage, MX6
SabreLite for example) cannot boot a device tree from their shipped bootloaders
anyway. To boot these boards from device tree you need to actually update U-Boot
or provide another compatible, capable bootloader, and in this case this support
should actually be provided in the bootloader (mux everything before
the kernel is
even in memory, and you reduce your device tree sizes by a factor of 3). The
idea that Linux should reinitialize everything anyway just to be sure is both
redundant, and means you're slowing down boot times and potentially causing
odd behavior (electrically) on boards with reset lines flailing around
during a mux
change, and GPIO directions changing on the fly for no good reason.

The device tree model has to imply some level of trust that the
configuration you
have in the device tree is exactly what you get on the board when the kernel has
booted. If that means adding pinctrl information to each device to
make sure it is
set up properly, then so be it. That said..

At Genesi we are proceeding with device tree support for all our platforms and
operating from an assumption that since we control our bootloader (it is U-Boot
after all, so not heavily..), we get to dictate what goes in our
device tree and we
will make a hard and fast stand against ANY pin mux changes going on inside the
kernel. And you guys will have to trust that we sat down and spent weeks and
weeks and weeks testing that this is actually the case before we committed
anything.

Just because there is a ton of absolutely awful, broken firmware code out there
doesn't mean it can and will always be the case, and Linux policy should not
be dictated on an architecture basis on a few bad eggs, especially if it means
developers in the big wide world have to jump through hoops. Surely it is just
as good for Linux to loudly advocate the correct solutions in firmware and
implement the workarounds anyway, like a device quirk, rather than just out and
out say "firmwares suck, ignore what they did, do it again. We don't trust them
and never will."

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
