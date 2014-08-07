From: Mattis.Lorentzon@autoliv.com (Mattis Lorentzon)
Date: Thu, 7 Aug 2014 11:11:06 +0000
Subject: Oops: 17 SMP ARM (v3.16-rc2)
In-Reply-To: <20140806125550.GO30282@n2100.arm.linux.org.uk>
References: <C4A61A5CA4AD2246942F4BA6F20ACB804356534D@ALVA-EXMB04.alv.autoliv.int>
 <20140626140115.GQ32514@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB80435655E9@ALVA-EXMB04.alv.autoliv.int>
 <20140626151424.GT32514@n2100.arm.linux.org.uk>
 <20140627112151.GF32514@n2100.arm.linux.org.uk>
 <3FFB61A7A8473C49831AF20FA193534A43CADFA7@ALVA-EXMB01.alv.autoliv.int>
 <20140627163108.GP32514@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043575072@ALVA-EXMB04.alv.autoliv.int>
 <20140806095012.GN30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043575172@ALVA-EXMB04.alv.autoliv.int>
 <20140806125550.GO30282@n2100.arm.linux.org.uk>
Message-ID: <C4A61A5CA4AD2246942F4BA6F20ACB804357526C@ALVA-EXMB04.alv.autoliv.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

> Can you ascertain whether these stalls are a result of some failure of the
> receive side or the transmit side - you should be able to tell that if you watch
> the packet counts via ifconfig on the stalled card.  Also, it would be useful to
> know whether the FEC interrupt was firing.

grep eth /proc/interrupts
151:          0          0          0          0       GIC 151  2188000.ethernet
166:    1205661          0          0          0  gpio-mxc   6  2188000.ethernet

The interrupt counter 166 increases regularly during the stalls.
Ifconfig indicates that the RX and TX  counters do not increase.

> I hope you have some kind of serial console on these cards?

Yes, indeed. Local stimuli seems to be able to unstall the network in a
somewhat random fashion. Running e.g. ifconfig or ping locally may
immediately or after up to about half a minute make the network responsive.
However, it usually degenerates again to a complete stall within seconds.
Without local stimuli the network does not appear to recover at all. The card
does not even respond to pings (again, most often without any apparent
error messages).

Running both of the following commands in parallel from the FC server seems
to trigger the problem within minutes (please note that the arm card stops
responding to both ping and ssh):

# while :; do ssh arm-card echo Ok; done
# ping arm-card

We have noticed the same problem on both the i.MX6 and the Zynq cards
(using KSZ9021 and Cadence GEM drivers). However, the number of
iterations required to trigger the problem vary. Sometimes it might stall after
less than 100, but in other cases the stalls begin after nearly 10000 iterations.
Once stalled (and unstalled after stimuli), the network on that particular card
degenerates a lot more often. Apart from the kernel, IP numbers and MAC
addresses, the software configurations are identical between the Zynq and
the i.MX6. Perhaps the fault is unrelated to the Freescale driver?

> Hmm.  Okay, I think the first thing we need to do is to work out why the
> silent stalls are happening.

Would you have any ideas on what to check next?

Best regards,
Mattis Lorentzon
***************************************************************
Consider the environment before printing this message.

To read Autoliv's Information and Confidentiality Notice, follow this link:
http://www.autoliv.com/disclaimer.html
***************************************************************
