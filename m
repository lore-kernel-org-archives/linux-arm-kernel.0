From: w@1wt.eu (Willy Tarreau)
Date: Wed, 23 Jul 2014 08:16:59 +0200
Subject: Issue found in Armada 370: "No buffer space available" error
 during continuous ping
In-Reply-To: <CAB8gEUtmgwfWcuoYZ-wDwHVmzHN0WyOQD9oEOGAZ_gJfbPUm-g@mail.gmail.com>
References: <20140715142431.4eccbcd6@free-electrons.com>
 <20140715124333.GF12333@1wt.eu>
 <CAB8gEUt08QVpgW0fs18tNnCkCw36SD6hxgL8O6p6+oOtX0-yJQ@mail.gmail.com>
 <20140717081527.GJ14723@1wt.eu>
 <CAB8gEUsLmuDkTzGsq8fVs9dZ90d82Brw2cAPBOnobUTcSgQabA@mail.gmail.com>
 <CAB8gEUvwPJUhDN-=tugTyKe93SdNwqNaGtKMF1DRCb8ZNncmmg@mail.gmail.com>
 <20140721054405.GK21834@1wt.eu>
 <CAB8gEUsK9c3YMpAABifNAWU7zec2ePztSqS4KAYtiT7Sbhadvg@mail.gmail.com>
 <20140721070303.GM21834@1wt.eu>
 <CAB8gEUtmgwfWcuoYZ-wDwHVmzHN0WyOQD9oEOGAZ_gJfbPUm-g@mail.gmail.com>
Message-ID: <20140723061659.GE30488@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maggie,

On Tue, Jul 22, 2014 at 07:24:35PM -0700, Maggie Mae Roxas wrote:
> Hi Willy,
> Good day.
> 
> > OK so clearly the issue must be found.
> 
> Actually we have 2 products using Armada 370.
> One has only 1 ethernet port, so it is expected to act as Client only.
> The other one has 2 ethernet ports, so it's more router-like.
> 
> For the product with one port, we have checked the combination patch
> and it seems like Tx IRQ is increasing so it's OK. We checked this via
> /proc/interrupts and mvneta's value there changed from 500000+ to
> around 900000+ after we perform a 10-iteration iperf to the server.
> The throughput is also OK, we're getting around 850Mbits when we use a
> 1Gbit connection, which is roughly just the same as what we've been
> experiencing when we're still using 3.10.x (even 3.2.x).

OK.

> As for the other product with two ports, we do expect that we might be
> encountering the slow performance you mentioned.
> But we are not focusing on this project yet so once it's active again,
> I'll let you know.
> 
> > Just thinking about something, do you have a custom boot loader ?
> > It would be possible that in our case, the Tx IRQ works only because some
> > obscure or undocumented bits are set by the boot loader and that in your
> > case it's not pre-initialized.
> 
> We are indeed using a "custom" boot loader.
> We are using Marvell u-boot 2014_T1.1 (latest QA release, I think).
> We applied some patches to memory (since we have 1Gb DDR), some bits
> and pieces for the interfaces we're going to support and not to
> support, and of course our own environment variables.
> As for the DDR memory/register patches, they came directly from our
> Marvell contact.
> 
> But with what I mentioned above, I think our Tx interrupt is working...?

Yes, seems so.

> BTW, for both products we've designed from Armada 370 RD, we didn't
> use a switch. So we removed all switch-related codes in the boot
> loader.
> I'm not sure if not having switch affects the behavior?

I have no idea, I remember that this code is deeply burried into the
original neta code. There was also a large code for the network
classifier and something like buffer management in the original
Marvell's driver if my memory serves me correctly, I have no idea
if these ones set up anything special.

> How about you? May I know what boot loader you are using?

Just the original ones. I have a mirabox with its original boot loader :

    U-Boot 2009.08 (Sep 16 2012 - 22:50:06)Marvell version: 1.1.2 NQ
    U-Boot Addressing:
           Code:            00600000:006AFFF0
           BSS:             006F8E40
           Stack:           0x5fff70
           PageTable:       0x8e0000
           Heap address:    0x900000:0xe00000
    Board: DB-88F6710-BP
    SoC:   MV6710 A1
    CPU:   Marvell PJ4B v7 UP (Rev 1) LE
           CPU @ 1200Mhz, L2 @ 600Mhz
           DDR @ 600Mhz, TClock @ 200Mhz
           DDR 16Bit Width, FastPath Memory Access
    PEX 0: Detected No Link.
    PEX 1: Root Complex Interface, Detected Link X1
    DRAM:   1 GB
           CS 0: base 0x00000000 size 512 MB
           CS 1: base 0x20000000 size 512 MB
           Addresses 14M - 0M are saved for the U-Boot usage.
    NAND:  1024 MiB
    Bad block table found at page 262016, version 0x01
    Bad block table found at page 261888, version 0x01
    FPU not initialized
    USB 0: Host Mode
    USB 1: Host Mode
    Modules/Interfaces Detected:
           RGMII0 Phy
           RGMII1 Phy
           PEX0 (Lane 0)
           PEX1 (Lane 1)
    phy16= 72 
    phy16= 72 
    MMC:   MRVL_MMC: 0
    Net:   egiga0 [PRIME], egiga1
    Hit any key to stop autoboot:  0 

> > LTS would probably even interest your customer as it's an LTS version.
> > In this case, always pick the most recent one (3.14.12 today). You may
> > even be interested in 3.15.6 which contains another phy fix supposed to
> > fix cd71e2, but if you're saying that it doesn't change anything for you
> > I guess it will have no effet (might be worth testing for the purpose of
> > helping troubleshooting though).
> 
> Thank you for this advise, we'll take note of this.
> We plan to stick on using LTS from now on, as much as possible.
> 
> > OK. I still have a hard time imagining how hardware itself could prevent
> > an IRQ from being delivered from a NIC which is located inside the SoC,
> > but there must be an explanation somewhere :-/
> I also would like to know how. :-/
> But maybe it's our difference in boot loader as you speculated.

I think we could try to dump all of our respective mvneta registers and
compare them, though I have very little time for this today. And if it
comes from extra SoC functions like buffer management or network classifier,
I have no idea how they work nor what to dump :-/

Regards,
Willy
