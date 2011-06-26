From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 26 Jun 2011 15:08:43 +0200
Subject: [PATCH] arm: fix regression in ixp4xx clocksource
In-Reply-To: <19955.20458.788309.51588@pilspetsen.it.uu.se> (Mikael
	Pettersson's message of "Sat, 11 Jun 2011 13:22:18 +0200")
References: <20110530084307.GA28953@riccoc20.at.omicron.at>
	<20110601225826.GR3660@n2100.arm.linux.org.uk>
	<20110611051510.GA3283@riccoc20.at.omicron.at>
	<19955.20458.788309.51588@pilspetsen.it.uu.se>
Message-ID: <m3aad4pwo4.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mikael Pettersson <mikpe@it.uu.se> writes:

> ARM cores often have software-controllable endianess (see the ARM ARM).
> Off the top of my head:
> - ixp4xx: natively BE core and peripherals, but some people like to
>   switch the core to LE for user-space SW compatibility reasons
>   (I run my ixp4xx in BE as intended though)


Ok I'm back to work.

IXP4xx have some problems working in LE mode, namely:
- the network drivers (at least Ethernet and HSS) have to swap buffers
  because the NPE (network coprocessors) are BE,
- the hw crypto stuff doesn't mostly work on LE - parts work, but the
  rest seems to be broken in firmware (NPE microcode) - or so it seems
  (swapping the data buffers would work).

There is a special hardware in IXP4xx which makes it possible to
effectively switch the NPEs to LE. Unfortunately the first CPU revision
(IXP42x rev. A0) doesn't support it. And while I have the code working,
it's not "yet" upstream.

In short:
- all IXP4xx can work BE,
- IXP42x rev. A0 can work LE with impaired network transfers and hw
  crypto,
- later IXP4xx can work "fully" LE (not upstream).
-- 
Krzysztof Halasa
