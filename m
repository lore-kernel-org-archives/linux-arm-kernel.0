From: tiwai@suse.de (Takashi Iwai)
Date: Wed, 09 Dec 2015 07:59:20 +0100
Subject: [RFC] ARM: remove VIRT_TO_BUS
In-Reply-To: <1630488.4B57tj3Z8o@wuerfel>
References: <1630488.4B57tj3Z8o@wuerfel>
Message-ID: <s5hsi3cyunr.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 08 Dec 2015 22:54:45 +0100,
Arnd Bergmann wrote:
> 
> All drivers that are relevant for rpc or footbridge have stopped
> using virt_to_bus a while ago, so we can remove it and avoid some
> harmless randconfig warnings for drivers that we do not care about:
> 
> drivers/atm/zatm.c: In function 'poll_rx':
> drivers/atm/zatm.c:401:18: warning: 'bus_to_virt' is deprecated [-Wdeprecated-declarations]
>    skb = ((struct rx_buffer_head *) bus_to_virt(here[2]))->skb;
> 
> FWIW, the remaining drivers using this are:
> 
> ATM:  firestream, zatm, ambassador, horizon
> ISDN: hisax/netjet
> V4L:  STA2X11, zoran
> Net:  Appletalk LTPC, Tulip DE4x5, Toshiba IrDA
> WAN:  comtrol sv11, cosa, lanmedia, sealevel
> SCSI: DPT_I2O, buslogic
> VME:  CA91C142
> 
> My best guess is that all of the above are so hopelessly obsolete that
> we are best off removing all of them form the kernel, but that can be
> done another time.
> 
> The sound drivers used to rely on virt_to_bus, but don't any more.
> As a lot of architectures don't provide VIRT_TO_BUS any more, removing
> the dependency in sounds/oss/ would make the deprecated drivers appear
> there, which we probably don't want. Instead I'm replacing the
> simple dependency with 'VIRT_TO_BUS || RPC || NETWINDER' so we can
> still build these sound drivers for the platforms that need them,
> but don't change anything on other architectures.

Yeah, agreed.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> No hurry for this one. If we can agree that it's a good idea, we
> can probably do the sound/oss change first, and then do the
> rest for the following merge window. If nobody cares about picking
> up the sound/oss patches, we can also just do it as one patch.

I'm willing to apply sound/oss one now.  Could you split the patch for
that?


thanks,

Takashi
