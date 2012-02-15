From: robherring2@gmail.com (Rob Herring)
Date: Wed, 15 Feb 2012 08:14:00 -0600
Subject: [PATCH 13/15] ARM: make mach/io.h include optional
In-Reply-To: <alpine.LFD.2.02.1202141909260.24536@xanadu.home>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <201202140804.49026.arnd@arndb.de> <4F3A7158.2080702@gmail.com>
 <201202141716.26930.arnd@arndb.de>
 <20120214174035.GA29765@n2100.arm.linux.org.uk> <4F3AE98D.7030104@gmail.com>
 <20120214234313.GD29765@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1202141909260.24536@xanadu.home>
Message-ID: <4F3BBDA8.8070801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2012 06:25 PM, Nicolas Pitre wrote:
> On Tue, 14 Feb 2012, Russell King - ARM Linux wrote:
> 
>> On Tue, Feb 14, 2012 at 05:09:01PM -0600, Rob Herring wrote:
>>> BTW, I noticed some static mappings at 0xffxxxxxx. Are those even a
>>> valid address?
>>
>> Nothing invalid about them as such, but I have tried to discourage their
>> use in case we decide that we want to go for a default 14MB DMA region.
> 
> They should be invalid, and would be flagged by this code in 
> create_mapping():
> 
>         if ((md->type == MT_DEVICE || md->type == MT_ROM) &&
>             md->virtual >= PAGE_OFFSET &&
>             (md->virtual < VMALLOC_START || md->virtual >= VMALLOC_END)) 
>         {
>                 printk(KERN_WARNING "BUG: mapping for 0x%08llx"
>                        " at 0x%08lx out of vmalloc space\n",
>                        (long long)__pfn_to_phys((u64)md->pfn), md->virtual);
>         }
> 
> given that VMALLOC_END is now defined as 0xff000000.
> 
> What are those static mappings at 0xffxxxxxx?  I was looking for them 
> while reworking this code but I might have missed some.
> 

TS78XX_FPGA_REGS_VIRT_BASE
IXP4XX_PERIPHERAL_BASE_VIRT
IXP4XX_EXP_CFG_BASE_VIRT
IXP4XX_PCI_CFG_BASE_VIRT
IXP4XX_DEBUG_UART_BASE_VIRT
CLPS7111_VIRT_BASE
u300-regs.h
cns3xxx.h

Rob
