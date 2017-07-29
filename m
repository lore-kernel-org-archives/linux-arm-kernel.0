From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 29 Jul 2017 13:15:32 -0700
Subject: [RFC PATCH v1] net: ethernet: nb8800: Reset HW block in ndo_open
In-Reply-To: <bfc5678a-0536-7964-0d45-8f6b104e2f1a@free.fr>
References: <823b1540-b528-bbd7-7f99-5dc39a08868a@sigmadesigns.com>
 <yw1xk22slemx.fsf@mansr.com>
 <c1bf54ee-8634-23a1-abda-55bc3fafe2a8@sigmadesigns.com>
 <yw1xfudgl7am.fsf@mansr.com> <446e3a95-80c3-0742-9cb1-69a8dfc9b1ae@free.fr>
 <yw1x7eyrlc3s.fsf@mansr.com> <f04a0cba-6c09-e9e4-f2d1-d8b2a7e276c9@free.fr>
 <yw1x379fla7r.fsf@mansr.com> <bfc5678a-0536-7964-0d45-8f6b104e2f1a@free.fr>
Message-ID: <2b1e69ed-7c95-d99c-5efc-bd5b23767d1e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/29/2017 05:44 AM, Mason wrote:
> On 29/07/2017 14:05, M?ns Rullg?rd wrote:
> 
>> Mason writes:
>>
>>> I'll take this opportunity to change flow control to
>>> off by default (it breaks several 100 Mbps switches).
>>
>> I was told to have it on by default.  This is what most other drivers
>> do too.  If you have faulty switches, that's your problem.
> 
> Or maybe the fault is in the HW implementation, and
> it is the board's fault that the connection is hosed.

If there really is a linkage with pause frames then it's a pretty binary
thing at the electrical interface level, either the (RG)MII connection
works, or or it does not, but pause frames are normal frames as far as
the electrical interface is concerned. Their special handling is at the
MAC level, see below.

> 
> How many switches did you test the driver on?
> 
> We tested 4 switches, and DHCP failed on 3 of them.
> Disabling pause frames "fixed" that.

OK, so it is this problem that you reported about before? Pause frames
are tricky in that receiving pause frames means you should backpressure
your transmitter and sending pause frames happens when your receiver
cannot keep up. It is somewhat conceivable that your HW implementation
is bogus and that you can get the HW in a state where it gets
permanently backpressured for instance? And then only a full re-init
would get you out of this stuck state presumably? Are there significant
differences at the DMA/Ethernet controller level between Tango 3 (is
that the one Mans worked on?) and Tango 4 for instance that could
explain a behavioral difference?

Some Ethernet NICs allow you to actually observe pause frames (AFAIR a
few Intel ones do) so you could conceivably set up a bridge with such a
NIC and snoop traffic between your tango4 board and your switch and see
what happens.

> 
> I could spend weeks testing dozens of switches, but
> I have to prioritize. Ethernet flow control is simply
> not an important feature in the market the SoC is
> intended for.


-- 
Florian
