From: slash.tmp@free.fr (Mason)
Date: Thu, 26 Nov 2015 15:44:28 +0100
Subject: Preprocessor arithmetic in dtsi files (base + offset)
In-Reply-To: <20151126135957.GC8644@n2100.arm.linux.org.uk>
References: <56570620.3070106@free.fr>
 <20151126135957.GC8644@n2100.arm.linux.org.uk>
Message-ID: <56571ACC.9080306@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/11/2015 14:59, Russell King - ARM Linux wrote:
> On Thu, Nov 26, 2015 at 02:16:16PM +0100, Mason wrote:
>> #define SCU_BASE 0x20000000
>>
>> 	scu: scu at XXX {
>> 		compatible = "arm,cortex-a9-scu";
>> 		reg = <SCU_BASE 0x100>;
>> 	
>> 	gic: interrupt-controller at XXX {
>> 		compatible = "arm,cortex-a9-gic";
>> 		reg = <SCU_BASE+0x1000 0x1000>, <SCU_BASE+0x100 0x0100>;
> 
> You don't get preprocessor arithmetic here.  What you get is this passed
> to DTC:
> 
> 		reg = <0x20000000+0x1000 0x1000>...
> 
> The only time the preprocessor does arithmetic is when it needs to
> evaluate an expression, eg, in an #if statement.

Doh! Brain malfunction. No arithmetic indeed.
Working with the preprocessor would have to involve token-pasting.

#define SCU_BASE(OFFSET)	2000##OFFSET
#define SCU_BASEX(OFFSET)	0x2000##OFFSET

	gic: interrupt-controller at SCU_BASE(1000) {
		reg = <SCU_BASEX(1000) 0x1000>, <SCU_BASEX(0100) 0x0100>;
	};

My very own abomination!

Regards.
