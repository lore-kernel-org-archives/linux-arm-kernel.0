From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Apr 2014 11:32:06 +0100
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <f5dfa7eca60346e884768bf821594d06@BY2PR03MB377.namprd03.prod.outlook.com>
References: <20140401225149.GC7528@n2100.arm.linux.org.uk>
 <b974be3a995f41029b54cfcc10c732ef@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140402085914.GG7528@n2100.arm.linux.org.uk>
 <deb03b2af59a4fe7a46bc66278335826@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140402104644.GI7528@n2100.arm.linux.org.uk>
 <ebffe60db89d45ce883b1b9aff121152@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140402165113.GJ7528@n2100.arm.linux.org.uk>
 <a52a4e6119c143799220667a25781844@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140403085636.GL7528@n2100.arm.linux.org.uk>
 <f5dfa7eca60346e884768bf821594d06@BY2PR03MB377.namprd03.prod.outlook.com>
Message-ID: <20140403103206.GN7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 03, 2014 at 09:55:06AM +0000, fugang.duan at freescale.com wrote:
> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Data: Thursday, April 03, 2014 4:57 PM
> 
> >To: Duan Fugang-B38611
> >Cc: robert.daniels at vantagecontrols.com; Marek Vasut; Detlev Zundel; Troy Kisky;
> >Grant Likely; Bernd Faust; Fabio Estevam; linux-arm-kernel at lists.infradead.org
> >Subject: Re: FEC ethernet issues [Was: PL310 errata workarounds]
> >
> >On Thu, Apr 03, 2014 at 02:41:46AM +0000, fugang.duan at freescale.com wrote:
> >> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> >> Data: Thursday, April 03, 2014 12:51 AM
> >>
> >> >Checksum and... presumably you're referring to NAPI don't get you to
> >> >that kind of speed.  Even on x86, you can't get close to wire speed
> >> >without GSO, which you need scatter-gather for, and you don't support
> >> >that.  So I don't believe your 900Mbps figure.
> >> >
> >> >Plus, as you're memcpy'ing every packet received, I don't believe you
> >> >can reach 940Mbps receive either.
> >> >
> >> Since Imx6sx enet still don't support TSO and Jumbo packet,
> >> scatter-gather cannot improve ethernet performance in Most cases
> >> special for iperf test.
> >
> >Again, you are losing credibility every time you deny stuff like this.
> >I'm now at the point of just not listening to you anymore because you're
> >contradicting what I know to be solid fact through my own measurements.
> >
> >This seems to be Freescale's overall attitude - as I've read on Freescale's
> >forums.  Your customers/users are always wrong, you're always right.  Eg, any
> >performance issues are not the fault of Freescale stuff, it's tarnished
> >connectors or similar.
> >
> Hi, Russell,
> 
> I don't contradict your thinking/solution and measurements.  You are
> expert on arm/modules, we keep study attitude to dicuss with you.
> For imx6sx, we indeed get the result. For imx6q/dl linux upstream, you
> did great job on performance tuning, and the test result is similar
> To our internal test result. Your suggestion for the optimiztion is
> meaningful. Pls understand my thinking.  

The reason I said what I said is because I'm not talking about TSO.  I'm
talking about GSO.  They're similar features, but are done in totally
different ways.

TSO requires either hardware support, or driver cooperation to segment
the data.  GSO does not.

There's several points here which make me discount your figures:

1. The overhead of routing packets is not insigificant.

   GSO is a feature where the higher levels (such as TCP) can submit
   large socket buffers to the lower levels, all the way through to
   packet queues to just before the device.

   At the very last moment, just before the buffer is handed over to
   the driver's start_xmit function, the buffer is carved into
   appropriately sized chunks, and new skbuffs allocated.  Each skbuff
   "head" contains the protocol headers, and the associated fragments
   contain pointers/lengths into the large buffer.  (This is why SG is
   required for GSO.)

   What this means is that all the overhead from the layers such as
   TCP / IP / routing / packet queuing are all reduced because rather
   than those code paths having to be run for every single 1500 byte
   packet, they're run once for maybe 16 to 32K of data to be sent.
   This avoids the overhead from a lot of code.

   I have monitored the RGMII TX_CTL signal while performing iperf
   tests without GSO, and I can see from that the gap between packets,
   it is very rare that it gets to the point of transmitting two
   packets back to back.

2. At 500Mbps transmit on the iMX6S, performance testing shows the
   majority of CPU time is spent in the cache cleaning/flushing code.
   This overhead is necessary and can't be removed without risking
   data corruption.

3. I discount your receive figure because even with all my work, if
   I set my x86 box to perform a UDP iperf test with x86 sending to
   iMX6S, the result remains extremely poor, with 95% (modified) to 99%
   (unmodified) of UDP packets lost.  This is not entirely the fault
   of the FEC.  Around 70% of the packet loss is in the UDP receive
   path - iperf seems to be unable to read the packets from UDP fast
   enough.  (This confirmed by checking the statistics in /proc/net/snmp.)
   This means 30% of packet loss is due to the FEC not keeping up with
   the on-wire packet rate (which is around 810Mbps.)

   Therefore, I place the maximum receive packet rate of the FEC with
   the current packet-copy strategy in the receive path and 128 entry
   receive ring size at around 550Mbps, and again, much of the overhead
   comes from the cache handling code according to perf.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
