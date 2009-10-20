From: 914059751@qq.com (=?gbk?B?uvrR7sr3?=)
Date: Tue, 20 Oct 2009 17:49:45 +0800
Subject: ARM1176 goes wild when MMU on line
Message-ID: <tencent_238CF8B63259E7C90B7B75AF@qq.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, guys:)
      I'm porting Linux-2.6.30 to a ARM1176 core based SOC from scratch.
When i turned MMU off in arch/arm/boot/compressed/Head.S , kernel can decompress easily, and boot onto start_kernel, while it's a little bit slow for decompressing.
But when MMU is on line, functions call in decompress_kernel go wild!
      I checked the page tables, it's definitely OK with my memory space and ARM1176 has ARMv7 VMSA.  Am I?missing something obvious?

      DDR2 space 0x00000000 ~ 0x0fffffff ,256M
       I load zImage at 0x0
      zreladdr-y    := 0x00608000
      params_phys-y    := 0x00600100
 
 
The page table looks like this:
|0x0000_0C1E | address:0x604000  DDR bufferable/cachable
|0x0010_0C1E | address:0x604004  DDR bufferable/cachable
|0x0020_0C1E | address:0x604008  DDR bufferable/cachable
         X
         X       
|0x0FF0_0C1E | address:0x6043FC DDR bufferable/cachable
|0x0100_0C12 | address:0x604400 Peripheral unbufferable/uncachable
         X
         X
|0xFFD0_0C12 | address:0x607FF4 Peripheral unbufferable/uncachable
|0xFFE0_0C12 | address:0x607FF8 Peripheral unbufferable/uncachable
|0xFFF0_0C12 | address:0x607FFC Peripheral unbufferable/uncachable
