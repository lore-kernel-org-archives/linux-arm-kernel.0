From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 28 Mar 2011 13:25:57 +0100
Subject: CPUv6K (ARM1176) and wfi()
Message-ID: <20110328122557.GB2738@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin, Will,

I'm respinning some PM patches for my platform (ARM1176JZ-S) and looking 
at arch/arm/include/asm/system.h, for CPU_32v6K wfi() uses the "wfi" 
instruction, but when I use this on my system the instruction returns 
immediately.  Replacing this with:

	asm volatile("mcr   p15, 0, %0, c7, c0, 4\n" :: "r"(0));

makes everything work properly.  The ARM1176 TRM doesn't mention the wfi 
instruction afaict but does say to use the cp15 instruction in section 
10.2.2 (Standby mode).  It doesn't look to me that the SEV or WFE 
instructions are implemented on ARM1176 so I'm guessing that these are 
only in mpcore?

Jamie
