From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 09 Dec 2013 23:25:55 +0300
Subject: [PATCH v3 2/3] ARM: shmobile: Koelsch: add Ether support
In-Reply-To: <CAMuHMdWFmO4d4b77JDY0_Z5NuQFoP73-PVho2dwAOY4ES57Dug@mail.gmail.com>
References: <201312082348.17588.sergei.shtylyov@cogentembedded.com>	<201312082352.45265.sergei.shtylyov@cogentembedded.com>
 <CAMuHMdWFmO4d4b77JDY0_Z5NuQFoP73-PVho2dwAOY4ES57Dug@mail.gmail.com>
Message-ID: <52A62753.8060202@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/09/2013 09:52 PM, Geert Uytterhoeven wrote:

>> Register Ether platform device and pin data on  the  Koelsch board.
>> Register platform fixup for Micrel KSZ8041 PHY, just like on the Lager board.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> --- renesas.orig/arch/arm/mach-shmobile/board-koelsch.c
>> +++ renesas/arch/arm/mach-shmobile/board-koelsch.c
>
>> +/* Ether */
>> +static const struct sh_eth_plat_data ether_pdata __initconst = {
>> +       .phy                    = 0x1,
>> +       .edmac_endian           = EDMAC_LITTLE_ENDIAN,
>> +       .phy_interface          = PHY_INTERFACE_MODE_RMII,
>> +       .ether_link_active_low  = 1,
>> +};

> With the above, NFS root is terrible slow,

    Do you get NFS timeout(s) on booting? I do. It's a known issue.

> and ping indicates more than 10% packet loss.

    Hm, that I didn't see...

> I was trying to debootstrap Debian jessie, but gave up
> after a few hours.

> Based on earlier discussions I found in the mailing list archives, I
> replaced the
> ".ether_link_active_low = 1" by ".no_ether_link = 1", and the problem went away.

    That's one way to deal with the issue, but it's not quite correct because 
it'll make Ether LEDs function in a way not matching to the intended one.
I've added PHY platform fixup to force the LED mode to the intended one after 
PHY reset that the driver does. I've also submitted a somewhat naive patch to 
call the fixups after that PHY reset but it got refused by David Miller. 
That's why we have what we have now. Hopefully, this should get resolved in 
3.14 if Florian Fainelli's patch series gets accepted:

http://marc.info/?l=linux-netdev&m=138636384109141

> Debootstrap completed in about one hour.  No more noticable packet loss
> during normal operation.
> I do still get "net eth0: Receive FIFO Overflow" once in a while, though (e.g.
> when running nuttcp).

> # nuttcp -r amd64box
>    112.8022 MB /  10.14 sec =   93.3131 Mbps 2 %TX 15 %RX 0 retrans 0.28 msRTT
> # nuttcp -t amd64box
>     94.1981 MB /  10.04 sec =   78.7000 Mbps 3 %TX 5 %RX 0 retrans

> With ".ether_link_active_low = 1", performance is halved:

> # nuttcp -r amd64box
>     56.0736 MB /  10.11 sec =   46.5290 Mbps 0 %TX 8 %RX 0 retrans 996.39 msRTT
> # nuttcp -t amd64box
>     47.7191 MB /  10.03 sec =   39.8991 Mbps 1 %TX 2 %RX 0 retrans

> BTW, I'm using renesas-devel-v3.13-rc2-20131205, with the following 4 patches
> from you applied on top:
>        sh_eth: add R8A7791 support
>        ARM: shmobile: r8a7791: add Ether clock
>        ARM: shmobile: Koelsch: add Ether support
>        ARM: shmobile: Koelsch: enable Ether in defconfig
> Anything I'm missing?

    You can try my simplistic 'sh_eth' driver patch:

http://marc.info/?l=linux-sh&m=137911743723032

> Thanks!

> Gr{oetje,eeting}s,

>                          Geert

WBR, Sergei
