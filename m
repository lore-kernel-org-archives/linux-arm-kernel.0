From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 14 Feb 2012 19:25:52 -0500 (EST)
Subject: [PATCH 13/15] ARM: make mach/io.h include optional
In-Reply-To: <20120214234313.GD29765@n2100.arm.linux.org.uk>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <201202140804.49026.arnd@arndb.de> <4F3A7158.2080702@gmail.com>
 <201202141716.26930.arnd@arndb.de>
 <20120214174035.GA29765@n2100.arm.linux.org.uk> <4F3AE98D.7030104@gmail.com>
 <20120214234313.GD29765@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1202141909260.24536@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Feb 2012, Russell King - ARM Linux wrote:

> On Tue, Feb 14, 2012 at 05:09:01PM -0600, Rob Herring wrote:
> > BTW, I noticed some static mappings at 0xffxxxxxx. Are those even a
> > valid address?
> 
> Nothing invalid about them as such, but I have tried to discourage their
> use in case we decide that we want to go for a default 14MB DMA region.

They should be invalid, and would be flagged by this code in 
create_mapping():

        if ((md->type == MT_DEVICE || md->type == MT_ROM) &&
            md->virtual >= PAGE_OFFSET &&
            (md->virtual < VMALLOC_START || md->virtual >= VMALLOC_END)) 
        {
                printk(KERN_WARNING "BUG: mapping for 0x%08llx"
                       " at 0x%08lx out of vmalloc space\n",
                       (long long)__pfn_to_phys((u64)md->pfn), md->virtual);
        }

given that VMALLOC_END is now defined as 0xff000000.

What are those static mappings at 0xffxxxxxx?  I was looking for them 
while reworking this code but I might have missed some.


Nicolas
