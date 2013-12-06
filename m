From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 6 Dec 2013 10:37:04 -0800
Subject: MCS8142
In-Reply-To: <OF8910DA33.769F3123-ON86257C39.000FEF6A-86257C39.0011CEEC@rockwellcollins.com>
References: <OF98E40A9C.2937821E-ON86257C35.0070EFA2-86257C35.0071D5A4@rockwellcollins.com>
 <CAGVrzcZf+wNXO54-_UDeToUCoqO9b2rosk7ugvQxT0joLRz3yQ@mail.gmail.com>
 <OF178900CD.244DDA78-ON86257C36.004B4D2A-86257C36.004BEEAB@rockwellcollins.com>
 <CAGVrzcb9asBzXqJBatksAXGevtsdpuS+nTZK7SHMgqsnzPYbgQ@mail.gmail.com>
 <OF8910DA33.769F3123-ON86257C39.000FEF6A-86257C39.0011CEEC@rockwellcollins.com>
Message-ID: <CAGVrzcYh4UExtYGvBO64cLOzYxCVuQgNvQdO8e_JrqDrqPuGRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/12/5  <mlweber1@rockwellcollins.com>:
>> Last I looked at their BSP it was total crap, but that's not a surprise.
>
> Ok, good to know :-)
>
> Currently I'm at the point of having a 3.3 kernel image built for fa526,
> but I never get console output beyond the uboot starting kernel message.
>
> I think I have a couple items that I need to get past to make progress.
> The first is get a toolchain I can trust. I've build a newer toolchain
> (GCC4.7) that has fa526 support, but I think I need to back track and
> switch to your 4.6 openWRT toolchain and just make sure I get a kernel
> binary that "should" execute.  Do you happen to know if that toolchain
> would support the fa526 arch?

On the top of my head, the one in OpenWrt might be the only one, I am
not sure of the fa526 patches status in upstream GCC.

> To boot that kernel, I'm using an existing uboot (2010) that seems
> adequate for now.  However I assume I'll have to build a uImage with
> appended device tree to get it to boot correctly without uboot DT
> support.

That is correct. I would not touch the bootloader at this point.

> The other item that I need to figure out is what the default console
> port name ended up as in the 3.3 or latest kernel.  One openWRT dts
> file bootargs defined it as /dev/ttyMCS, but another defined it as the
> standard /dev/ttyS0.

About that, this is because the Moschip BSP came up with a different
UART driver while the 8250 driver is perfectly usable as-is, at least
for MCS8140. We do not even need quirks like if it was some funky 8250
DesignWare UART, the plain 8250 works just fine. Since the 8250 driver
exposes /dev/ttyS* devices, this is the reason why the DT command-line
is using this.

>
> Just to make this all a bit harder I don't currently have jtag
> capability to this board, so I'm not sure the state the kernel is
> getting to.  So to work around that I was going to start modifying
> the initial kernel asm to toggle gpio so I could start narrowing
> in on the failure point, but I'm still working on getting the gpio
> to toggle using uboot reg access (seems to bus hang when I use the
> gpio reg peripheral address defined in the 8140 gpio driver).

Last I looked at the Moschip BSP, the 8142 had a slightly different
register layout, in particular none of the base peripherals were at
the same address as the ones in MCS8140, so this will need some
tuning. First things would probably be to get the
DEBUG_LL/early_printk console to output something.

>
>> > You wouldn't happen to have any technical material or knowledge
>> > about the differences between the 8140 and 8142? (aside from the CPU)
>> In fact I may, but certainly not as detailed for MCS8142 than it is
>> for MCS8142. Let me get back to you on this once I am done with moving
> in.
>> In any case the code I wrote for OpenWrt should not be too bad to begin
> with.
>
> Much appreciated.  Thanks
> Matt
>



-- 
Florian
