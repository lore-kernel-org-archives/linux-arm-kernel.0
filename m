From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 06 Aug 2013 18:06:21 +0100
Subject: [PATCH 0/3] ARM: vexpress: TC2 MCPM/SPC cleanups
In-Reply-To: <20130806165459.GB28176@e102568-lin.cambridge.arm.com>
References: <1375675793-16492-1-git-send-email-olof@lixom.net>
 <20130805094709.GA29090@e102568-lin.cambridge.arm.com>
 <1375805993.12043.80.camel@hornet>
 <20130806165459.GB28176@e102568-lin.cambridge.arm.com>
Message-ID: <1375808781.12043.98.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-08-06 at 17:55 +0100, Lorenzo Pieralisi wrote:
> > And here comes the V2P-CA15_A7, also known as TC2 ;-) where the
> > interface was re-(or ab-?)used as a "convenient" communication channel
> > between the test chip and the microcontroller. And the SPC is even
> > described as "being merged" with the SCC. Uh...
> 
> Yes, the "merging" of SCC and SPC is the root cause of this hopefully happy
> ended story, they lumped together pieces of HW that should have been kept
> separate.

Show me an SOC when the silicon people didn't try to save silicon area
and pads, for the cost of "solutions" like this...

> > Now, the bottom line. How about keeping the driver look for
> > "arm,vexpress-spc,v2p-ca15_a7" because it's a driver for the SPC bit
> > after all and doing the following in the tree:
> > 
> > scc at 7fff0000 {
> > 	compatible = "arm,vexpress-scc,v2p-ca15_a7", "arm,vexpress-scc";
> > 	reg = <0x7fff0000 0x1000>;
> > 	interrupts = <0 95 4>;
> > 
> > 	spc at b00 {
> > 		compatible = "arm,vexpress-spc,v2p-ca15_a7", "arm,vexpress-spc";
> > 		reg = <0xb00 0x100>;
> > 	};
> > };
> > 
> > This, I believe, would represent the actual situation, require no change
> > in the driver (except for the retirement of SPC_BASE which is good :-)
> > and allowed as, if and when necessary, to drive the SCC as a MFD/syscon
> > device.
> 
> I do need some SCC registers to check the cluster ID against the MPIDR in
> order to carry out powerdown operations. So if we do what you suggest we have
> to change the driver, I would avoid doing that at this stage.

That's what I'm saying - if we do the binding right, you won't have to
change the driver at all. It will do the same 
	of_find_compatible_node(NULL, NULL, "arm,vexpress-spc,v2p-ca15_a7");
as previously.

Pawe?
