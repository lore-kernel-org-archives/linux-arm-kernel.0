From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Nov 2015 13:59:57 +0000
Subject: Preprocessor arithmetic in dtsi files (base + offset)
In-Reply-To: <56570620.3070106@free.fr>
References: <56570620.3070106@free.fr>
Message-ID: <20151126135957.GC8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 02:16:16PM +0100, Mason wrote:
> #define SCU_BASE 0x20000000
> 
> 	scu: scu at XXX {
> 		compatible = "arm,cortex-a9-scu";
> 		reg = <SCU_BASE 0x100>;
> 	
> 	gic: interrupt-controller at XXX {
> 		compatible = "arm,cortex-a9-gic";
> 		reg = <SCU_BASE+0x1000 0x1000>, <SCU_BASE+0x100 0x0100>;

You don't get preprocessor arithmetic here.  What you get is this passed
to DTC:

		reg = <0x20000000+0x1000 0x1000>...

The only time the preprocessor does arithmetic is when it needs to
evaluate an expression, eg, in an #if statement.

The @XXX are part of the requirements from ePAPR, and are required to
be conformant with the spec.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
