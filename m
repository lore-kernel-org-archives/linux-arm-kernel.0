From: jaccon.bastiaansen@gmail.com (Jaccon Bastiaansen)
Date: Tue, 29 Apr 2014 11:26:30 +0200
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <OF62048746.594D7A9E-ON87257CB0.006DF18B-87257CB0.006FDEED@grpleg.it>
References: <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <20140321173252.GL7528@n2100.arm.linux.org.uk>
 <OF42C103CA.1A3B5524-ON87257CA5.005C7764-87257CA5.0062A13A@grpleg.it>
 <201403242121.58705.marex@denx.de>
 <OF5A7B7FA4.2FEB0248-ON87257CA5.007AE2AE-87257CA5.007C44DB@grpleg.it>
 <20140324234443.GS7528@n2100.arm.linux.org.uk>
 <20140326001135.GV7528@n2100.arm.linux.org.uk>
 <20140401092638.GA10224@n2100.arm.linux.org.uk>
 <OF15BAA4F9.E675BBEF-ON87257CAD.006812E9-87257CAD.006BE81E@grpleg.it>
 <20140401225149.GC7528@n2100.arm.linux.org.uk>
 <OF62048746.594D7A9E-ON87257CB0.006DF18B-87257CB0.006FDEED@grpleg.it>
Message-ID: <CAGzjT4et6kS_mOWN43MY=XM5h82RvKKuYexQF+PjPKk5G=skCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello all,

I tried the FEC patches from Russel
(http://ftp.arm.linux.org.uk/cgit/linux-arm.git/log/?h=fec-testing),
but with the following test the FEC complety stops receiving frames:

     Linux PC <----->  Gigabit Ethernet switch  <------> SabreSD board

Both ethernet links run at 1 Gigabit, full duplex.

The SabreSD board runs the fec-testing kernel from Russel.

On the SabreSD board we run "iperf -s -u"

On the Linux PC we
- run the iperf client (command used: ?while [ 1 ]; do iperf ?c ?IP
address of SabreSD? -u -b 100m -t 300 -l 256;sleep 1;done?)
- ping the SabreSD board every second

After a while (sometimes 10 seconds, sometimes a couple of minutes),
we see that the SabreSD board stops replying to the pings from the
Linux PC. Closer inspection shows that the FEC doesn't generate
receive frame interrupts anymore. Analysis with a debugger shows that
the RXF interrupt is enabled and that the FEC is still receiving
ethernet frames (because the IEEE_R_FRAME_OK event counter is
increasing), but no receive frame interrupts are occurring. We only
see MII interrupts occurring.

The RDAR register has the value 0 meaning that the FEC cannot write
the received frame in main memory because of a lack of available free
receive descriptors.

When the FEC has stopped generating receive interrupts, we used the
ping command on the Sabre board to send some frames from the Sabre
board to the Linux PC. The FEC then starts to generate receive
interrupts again. The driver source code shows that the receive buffer
is also emptied when a transmit interrupt occurs. So it seems that the
FEC completely stops generating receive interrupts when frames are
received and there are no more empty descriptors.

Any ideas or insights?

Regards,
  Jaccon

2014-04-04 22:21 GMT+02:00  <robert.daniels@vantagecontrols.com>:
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote on 04/01/2014
> 04:51:49 PM:
>
>> At initial glance, this is coherent with my idea of the FEC skipping a
>> ring entry on the initial pass around.  Then when a new entry is loaded,
>>
>> Let's say that the problem entry is number 12 that has been skipped.
>> When we get back around to entry 11, the FEC will transmit entries 11
>> and 12, as you rightly point out, and it will then look at entry 13
>> for the next packet.
>>
>> However, the driver loads the next packet into entry 12, and hits the
>> FEC to transmit it.  The FEC re-reads entry 13, finds no packet, so
>> does nothing.
>>
>> Then the next packet is submitted to the driver, and it enters it into
>> entry 13, again hitting the FEC.  The FEC now sees the entry at 13,
>> meanwhile the entry at 12 is still pending.
>
> I've explored the option of providing a work around for this observed
> problem.
> In the 2.6.35 kernel, I've used the BD_ENET_TX_INTR flag which is marked as
> TO2 in the RM and which was being set but never used by the software to
> help
> detect the skip.  In the interrupt handler I clear this bit which allows me
> to use it to know when the bd goes from ready -> clean.  In the error
> situation
> above, you would end up with 12 marked with both READY and INTR and at some
> point
> you would have bd 13 marked as INTR only (as it would have been transmitted
> but
> not cleaned up.)  This allows me to clean up bd 12 despite not actually
> being
> transmitted.  This gets the driver back in sync with the FEC and things
> continue
> on normally... until it happens again.
>
> Of course, this results in the occasional dropped packet but I feel like
> for now
> (until Freescale figures out what's going on) this is better than nothing.
> At
> least the driver is able to recover somewhat from the situation.
>
> I'm not sure if the mainline driver could benefit from a strategy like this
> or not,
> especially since it manifested this problem differently (tx transmit
> timeout).
> Also, in my opinion this is an undesirable hack to make things work
> acceptably.
> There could also be some inherent problem with this strategy that I'm
> unaware of,
> since dealing with linux kernel ethernet drivers is not exactly my area of
> expertise.
>
> Any thoughts or new insights?
>
> Thanks,
>
> Robert Daniels
>
> This email, and any document attached hereto, may contain
> confidential and/or privileged information.  If you are not the
> intended recipient (or have received this email in error) please
> notify the sender immediately and destroy this email.  Any
> unauthorized, direct or indirect, copying, disclosure, distribution
> or other use of the material or parts thereof is strictly
> forbidden.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
