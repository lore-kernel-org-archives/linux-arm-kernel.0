From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jan 2016 18:55:12 +0000
Subject: r8a7794/alt and CONFIG_PROVE_LOCKING=y
In-Reply-To: <CAMuHMdXGgbpsC+JdbGc5D0fd5YSdogpqvffPAB4PU-7H_-jM_Q@mail.gmail.com>
References: <CAMuHMdXGgbpsC+JdbGc5D0fd5YSdogpqvffPAB4PU-7H_-jM_Q@mail.gmail.com>
Message-ID: <20160111185512.GW19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 07:46:57PM +0100, Geert Uytterhoeven wrote:
> When CONFIG_PROVE_LOCKING=y, r8a7794/alt doesn't boot (no output).
> Earlycon doesn't help, but DEBUG_LL=y and earlyprintk gave me:
> 
>     Error: unrecognized/unsupported machine ID (r1 = 0x18009008).
> 
>     Available machine support:
> 
>     ID (hex) NAME
>     ffffffff    Generic DT based system
>     ffffffff Generic R8A7794 (Flattened Device Tree)
> 
>     Please check your kernel config and/or bootloader.
> 
> I'm booting using
> 
>     tftp 41000000 alt/zImage
>     tftp 40f00000 alt/r8a7794-alt.dtb
>     bootz 41000000 - 40f00000
> 
> just like on r8a7791/koelsch, where CONFIG_PROVE_LOCKING does work.
> 
> If I disable CONFIG_PROVE_LOCKING (e.g. shmobile_defconfig), the same kernel
> boots fine.
> 
> Anyone with a clue?

You're probably overwriting the dtb.  Presumably, RAM starts at
0x40000000, which means if your kernel is larger than 16MB-32k
after decompression, the dtb will get overwritten.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
