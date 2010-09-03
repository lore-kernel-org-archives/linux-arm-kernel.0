From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Fri, 3 Sep 2010 09:04:43 +0300
Subject: [PATCH] ARM: Implement cpu_v7_reset.
In-Reply-To: <20100902134834.GL25559@gw.healthdatacare.com>
References: <1283349719-21115-1-git-send-email-linus.walleij@stericsson.com>
	<20100901232307.GC25860@n2100.arm.linux.org.uk>
	<20100902083423.GI25559@gw.healthdatacare.com>
	<20100902084101.GA26319@n2100.arm.linux.org.uk>
	<20100902085341.GJ25559@gw.healthdatacare.com>
	<20100902103957.GR26319@n2100.arm.linux.org.uk>
	<20100902115206.GK25559@gw.healthdatacare.com>
	<20100902121838.GB26319@n2100.arm.linux.org.uk>
	<20100902134834.GL25559@gw.healthdatacare.com>
Message-ID: <20100903060443.GM25559@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 04:48:34PM +0300, Mika Westerberg wrote:
> On Thu, Sep 02, 2010 at 01:18:38PM +0100, Russell King - ARM Linux wrote:
> > > 
> > > I tested this patch without that cache invalidate instruction + dsb
> > > and it still hangs. Exactly the same code works perfectly when it is run
> > > via 1:1 mapping.
> > 
> > Where are you ultimately jumping to?
> 
> This is the normal kexec to a new kernel case so jump is to
> relocate_new_kernel(), if that was what you meant.

Hello,

I think I found something which might explain this weird behavior
on OMAP3s. If you look at ARM Cortex-A8 TRM (chapter 6.4 MMU
interaction with memory system):

	http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0344k/Cihfgdif.html

There is following paragraph:

        "After a CP15 c1 instruction disables the MMU, the processor
        flushes all following instructions in the pipeline. The
        processor then begins refetching instructions and uses flat
        address mapping. In flat address mapping, PA = VA."

They even provide a sample flow:

	MRC p15, 0, r1, c1, c0, 0    ; read CP15 Register 1
	BIC r1, r1, #0x1
	MCR p15, 0, r1, c1, c0, 0    ; disabled
	Fetch flat
	Fetch flat
	...

Does this make sense?

Regards,
MW
