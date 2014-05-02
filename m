From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 May 2014 12:41:34 +0100
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <CAGzjT4d8H6YE6P6A1E4aHiPAenJFvZH01LHXaNzVwhF2MRBvWQ@mail.gmail.com>
References: <OF42C103CA.1A3B5524-ON87257CA5.005C7764-87257CA5.0062A13A@grpleg.it>
 <201403242121.58705.marex@denx.de>
 <OF5A7B7FA4.2FEB0248-ON87257CA5.007AE2AE-87257CA5.007C44DB@grpleg.it>
 <20140324234443.GS7528@n2100.arm.linux.org.uk>
 <20140326001135.GV7528@n2100.arm.linux.org.uk>
 <20140401092638.GA10224@n2100.arm.linux.org.uk>
 <OF15BAA4F9.E675BBEF-ON87257CAD.006812E9-87257CAD.006BE81E@grpleg.it>
 <20140401225149.GC7528@n2100.arm.linux.org.uk>
 <OF62048746.594D7A9E-ON87257CB0.006DF18B-87257CB0.006FDEED@grpleg.it>
 <CAGzjT4d8H6YE6P6A1E4aHiPAenJFvZH01LHXaNzVwhF2MRBvWQ@mail.gmail.com>
Message-ID: <20140502114133.GB3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 11:05:04AM +0200, Jaccon Bastiaansen wrote:
> Hello all,
> 
> I tried the FEC patches from Russel
> (http://ftp.arm.linux.org.uk/cgit/linux-arm.git/log/?h=fec-testing),
> but with the following test the FEC complety stops receiving frames:
> 
> 
>  Linux PC <----->  Gigabit Ethernet switch  <------> SabreSD board
> 
> Both ethernet links run at 1 Gigabit, full duplex.
> 
> The SabreSD board runs the fec-testing kernel from Russel.
> 
> On the SabreSD board we run "iperf -s -u"
> 
> On the Linux PC we
> - run the iperf client (command used: ?while [ 1 ]; do iperf ?c ?IP
> address of SabreSD? -u -b 100m -t 300 -l 256;sleep 1;done?)
> - ping the SabreSD board every second
> 
> After a while (sometimes 10 seconds, sometimes a couple of minutes),
> we see that the SabreSD board stops replying to the pings from the
> Linux PC. Closer inspection shows that the FEC doesn't generate
> receive frame interrupts anymore. The attached debugger screenshots
> show the FEC registers when it is in this state. The RXF interrupt is
> enabled and we know that the FEC is still receiving ethernet frames
> (because the IEEE_R_FRAME_OK event counter is increasing), but no
> receive frame interrupts are occurring. We only see MII interrupts
> occurring.

If the RXF interrupt is enabled, it means that we must have received
less than NAPI_POLL_WEIGHT (64) frames from the ring during the previous
NAPI poll - this is the only circumstance when we will re-enable
interrupts.

There are only two conditions where we stop receiving frames from the
receive ring:
1. if we reach the NAPI poll weight number of frames received.
2. if we encounter a packet descriptor marked empty.

It can't be (1) because we would have left the TXF/RXF interrupts
disabled and waited for the next NAPI poll.  So, it can only be (2).

(2) implies that there is a ring descriptor which is marked as being
owned by the FEC, which means that there are descriptors free.  Whether
it's the one which the FEC is expecting to be free or not is something
that's impossible to tell (the FEC hardware doesn't tell us where it
is in its ring, which is a big minus point against debugging.)

It would be useful to see the state of the receive ring, as well as
the rx_next index.  That may be difficult to get though.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
