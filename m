From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 24 Jul 2017 18:09:30 +0200
Subject: [PATCH] ARM64: meson-gxl: disable broken eee
In-Reply-To: <7519c9ee-54f0-d5fb-1683-11d6e24f0822@baylibre.com>
References: <20170707013257.18250-1-joseph.kogut@gmail.com>
 <7ho9scsdbp.fsf@baylibre.com>
 <CAMWSM7hB1e8gJEY3RvQ6UyWsZC0qB-rV2PTxun_4mdzO0e8X-A@mail.gmail.com>
 <cf71b3c2-29d7-3bdb-0d00-872f5e1267e2@baylibre.com>
 <7519c9ee-54f0-d5fb-1683-11d6e24f0822@baylibre.com>
Message-ID: <1500912570.2401.3.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-07-24 at 14:26 +0200, Neil Armstrong wrote:
> On 07/24/2017 02:06 PM, Neil Armstrong wrote:
> > On 07/23/2017 07:03 PM, Joseph Kogut wrote:
> > > Hi Kevin,
> > > 
> > > I tested on a P212 reference board, which is currently the only GXL
> > > based board I have.
> > > 
> > > Before applying the patch, high activity on the ethernet interface
> > > would cause the link to break, requiring the interface to be brought
> > > down and back up before it would work again. After applying the patch,
> > > I could not get the link to break with any transfers.
> > > 
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel at lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > > 
> > 
> > Hi Joseph,
> > 
> > [please keep the history of the conversation when replying]
> > 
> > Is it a original P212 board, or a board based on the P212 ref design ?
> > 
> > I'm currently testing the v4.13-rc2 on the official P212 board we received
> > from Amlogic
> > and using iperf3 in both directions, I have an issue after a few minutes
> > running iperf3 with :
> > 
> > # while true ; do iperf3 -c 192.168.1.21 ; iperf3 -c 192.168.1.21 -R ; done
> > 
> > That cycles between the two iperf directions.
> > 
> > After a few minutes, it stalls with :
> > 
> > Connecting to host 192.168.1.21, port 5201
> > [??4] local 192.168.1.183 port 51286 connected to 192.168.1.21 port 5201
> > [ ID] Interval???????????Transfer?????Bandwidth???????Retr??Cwnd
> > [??4]???0.00-1.00???sec??1.64 MBytes??13.7 Mbits/sec????2???1.41 KBytes
> > [??4]???1.00-2.00???sec??0.00 Bytes??0.00 bits/sec????1???1.41 KBytes
> > [??4]???2.00-3.00???sec??0.00 Bytes??0.00 bits/sec????0???1.41 KBytes
> > [??4]???3.00-4.00???sec??0.00 Bytes??0.00 bits/sec????1???1.41 KBytes
> > [??4]???4.00-5.00???sec??0.00 Bytes??0.00 bits/sec????0???1.41 KBytes
> > [??4]???5.00-6.00???sec??0.00 Bytes??0.00 bits/sec????0???1.41 KBytes
> > [??4]???6.00-7.00???sec??0.00 Bytes??0.00 bits/sec????1???1.41 KBytes
> > [??4]???7.00-8.00???sec??0.00 Bytes??0.00 bits/sec????0???1.41 KBytes
> > [??4]???8.00-9.00???sec??0.00 Bytes??0.00 bits/sec????0???1.41 KBytes
> > 

Same kind of test shows no issue on the libretech-cc and the khadas-vim
In this case, I don't think meson-gxl.dtsi is where you should make your change.

> > 
> > And then, after:
> > # ifconfig eth0 down
> > # ifconfig eth0 up
> > 
> > It cycles between :
> > [ 1483.009919] meson8b-dwmac c9410000.ethernet eth0: Link is Up -
> > 100Mbps/Full - flow control rx/tx
> > [ 1487.105725] meson8b-dwmac c9410000.ethernet eth0: Link is Down
> > [ 1490.177943] meson8b-dwmac c9410000.ethernet eth0: Link is Up -
> > 100Mbps/Full - flow control rx/tx
> > [ 1494.273713] meson8b-dwmac c9410000.ethernet eth0: Link is Down

This does not look like the issue we had on the odroid-c2.
However, I have seen behavior like this (link down/up flickering) when the rgmii
 delays are way off.

Maybe you could try playing with "amlogic,tx-delay-ns" property ?

> > 
> > and so on.
> > 
> > And this patch does not fix this at all.
> > 
> > It seems to be more a PHY driver issue here.
> > 
> > Could you share the results with the same command ?
> > 
> > Neil
> > 
> 
> I forgot to precise, this issue occurs when the "GXL PHY driver" is disabled,
> only relying on the
> Generic PHY Driver.
> 
> [??630.767538] Generic PHY 0.e40908ff:08: attached PHY driver [Generic PHY]
> (mii_bus:phy_addr=0.e40908ff:08, irq=-1)
> 
> 
> When the PHY driver is loaded the issue disappears, with and without your
> patch.
> 
> [???25.355620] Meson GXL Internal PHY 0.e40908ff:08: attached PHY driver
> [Meson GXL Internal PHY] (mii_bus:phy_addr=0.e40908ff:08, irq=-1)
> 
> Could you please check the PHY Driver is loaded ?
> 
> Thanks,
> Neil
