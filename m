From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Nov 2012 10:32:18 +0000
Subject: [PATCH V2 1/5] arm: mvebu: Added support for coherency fabric in
 mach-mvebu
In-Reply-To: <50A69341.2090202@free-electrons.com>
References: <20121105140258.GO3351@mudshark.cambridge.arm.com>
 <50A15A33.60405@free-electrons.com>
 <20121113104340.GD3940@mudshark.cambridge.arm.com>
 <50A3F860.5010601@free-electrons.com>
 <20121115101752.GA26453@mudshark.cambridge.arm.com>
 <50A5103F.1040903@free-electrons.com>
 <20121115162123.GC5885@mudshark.cambridge.arm.com>
 <50A51D0D.4090009@free-electrons.com>
 <20121116185610.GA1019@mudshark.cambridge.arm.com>
 <50A69341.2090202@free-electrons.com>
Message-ID: <20121119103218.GB3205@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 07:25:53PM +0000, Gregory CLEMENT wrote:
> On 11/16/2012 07:56 PM, Will Deacon wrote:
> > 
> > The code paths are fine, I would just like to see less duplication. Can you
> > make the asm function PCS compliant and call it from C for the primary
> > (setting the link register to secondary_startup for the secondary cores)?
> 
> Have you a pointer on how to do it (make the asm function PCS compliant)?

Take a look at the PCS document:

  http://infocenter.arm.com/help/topic/com.arm.doc.ihi0042d/IHI0042D_aapcs.pdf

For your case it's really simple though as you don't need to use the stack:
just take the base address in r0 and use a subset of r1-r3 for temporaries
while setting up the control registers. Then mov pc, lr at the end.

> I will also need to add a parameter, because the base address are not the
> same between primary CPU and secondary CPUS. With the first we use virtual
> address whereas with the second the physical address.

Should be simple enough to add a secondary entry point immediately before,
which initialises r0 and lr.

Will
