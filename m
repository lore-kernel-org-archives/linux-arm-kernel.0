From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 9 Oct 2012 12:25:14 -0600
Subject: [PATCH] [ARM] Use AT() in the linker script to create correct
 program headers
In-Reply-To: <20121008104649.GD2302@linaro.org>
References: <20121001160639.GA31620@obsidianresearch.com>
 <20121001175647.GD2100@linaro.org>
 <20121001183543.GC22342@obsidianresearch.com>
 <20121002102346.GB2108@linaro.org>
 <20121002174759.GC23733@obsidianresearch.com>
 <20121003104335.GA2254@linaro.org>
 <20121003184437.GB12231@obsidianresearch.com>
 <20121004113637.GA2117@linaro.org>
 <20121004175907.GB2994@obsidianresearch.com>
 <20121008104649.GD2302@linaro.org>
Message-ID: <20121009182514.GF4124@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2012 at 11:46:49AM +0100, Dave Martin wrote:

> > Yes, but we still need rely on complex code like I2C/MTD to create a
> > correct DTB, which again puts us back to patching the kernel for that
> > functionality.
> 
> I'm still confused as to where this complexity is coming from.
> 
> If you need to run some complex I2C and MTD code to generate the DT, what
> is that code doing?  If it is probing to get the information, then can you
> avoid putting the info in the DT at all?  Primarily the DT is to describe
> those aspects of the hardware which can't be probed.

At manufacturing the unit is programmed with a small datastructure that
contains all the unique ID's (MAC addresses, etc), manufacturing
variations (ie vendor A or B was used for a socket) and other
ancillary data.

So a fair amount of I2C and MTD stack is required just to fetch this
structure - a full CFI probe, for instance, is needed in the NOR flash
case just to locate the structure.

Once read, things like MAC addresses are copied into the DTB, and
certain sections of the DTB are NOP'd out - we have stanzas for chip
vendor A and vendor B, the one that was not put on the board is
replaced with NOP.

Similar to the A/B fix, a further fixup is done based on a runtime
probe of the programmable devices to learn their current
configuration/memory map.

It seems desirable to present a complete/correct DTB to the kernel,
it doesn't seem there are great places to hook in custom discovery
procedures.

>From a maintenance perspective we already have to test/etc the kernel
code for all of this, we don't want to do that twice by duplicating
this stuff outside the kernel.

> Otherwise, you that have a few static configurations: you could have one
> pre-baked DT per hardware platform, and choose the correct one once you
> have detected the platform.

We do that too, for instance the PPC kernel we build supports 4
different circuit boards, each served by a separate DTB, that needs a
fixup pass.

I think the biggest DTB describes about 49 devices..
  
> > Where the 'dev tree provider' would use the stored bootloader
> > registers and any other information to return the proper DTB. 
> 
> It would need developing a bit, but something like that might be
> possible -- it should probably be discussed via devicetree-discuss.
> 
> If it is doing anything less trivial than picking a pre-baked DT, the
> rationale would need to be carefully argued.

I'm not sure there is a great interest in this? What are other folks
working on production embedded stuff doing? I suppose that will be
more clear as device tree is rolled out.

Jason
