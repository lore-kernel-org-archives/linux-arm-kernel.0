From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 06 Aug 2013 17:19:53 +0100
Subject: [PATCH 0/3] ARM: vexpress: TC2 MCPM/SPC cleanups
In-Reply-To: <20130805094709.GA29090@e102568-lin.cambridge.arm.com>
References: <1375675793-16492-1-git-send-email-olof@lixom.net>
 <20130805094709.GA29090@e102568-lin.cambridge.arm.com>
Message-ID: <1375805993.12043.80.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-08-05 at 10:47 +0100, Lorenzo Pieralisi wrote:
> For the bindings, you are right, how about this (commit log written just
> for the sake of it, it should be squashed in Nico's original series) ?

So I finally sat down and did what I should have done long time ago...
Read the spec ;-)

SCC is (was?) mainly used to set initial conditions for the cores,
interconnect and all the other bits and pieces inside the test chip. It
could be considered an equivalent of the classic "boot mode" pins, but
as test chips have many more of them comparing to the normal SOCs, the
data is being "injected" to the chip in a serial fashion *before* the
main reset is being de-asserted. This is done by an external entity,
namely the DCC (daughterboard configuration controller, so simply a
microcontroller living next to the test chip). Why is this detail
important at all? Because traditionally the SCC was *not* available in
the normal memory map, otherwise it would be a perfect candidate for
the . In order to change anything one had to go through the usual
Versatile Express config infrastructure. Fortunately there was no need
to do this at all...

And here comes the V2P-CA15_A7, also known as TC2 ;-) where the
interface was re-(or ab-?)used as a "convenient" communication channel
between the test chip and the microcontroller. And the SPC is even
described as "being merged" with the SCC. Uh...

Now, the bottom line. How about keeping the driver look for
"arm,vexpress-spc,v2p-ca15_a7" because it's a driver for the SPC bit
after all and doing the following in the tree:

scc at 7fff0000 {
	compatible = "arm,vexpress-scc,v2p-ca15_a7", "arm,vexpress-scc";
	reg = <0x7fff0000 0x1000>;
	interrupts = <0 95 4>;

	spc at b00 {
		compatible = "arm,vexpress-spc,v2p-ca15_a7", "arm,vexpress-spc";
		reg = <0xb00 0x100>;
	};
};

This, I believe, would represent the actual situation, require no change
in the driver (except for the retirement of SPC_BASE which is good :-)
and allowed as, if and when necessary, to drive the SCC as a MFD/syscon
device.

Does it make some sense?

Pawel
