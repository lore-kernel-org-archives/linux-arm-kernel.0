From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 12 Mar 2015 13:47:56 +0100
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid
 crash on armada-xp
In-Reply-To: <55018A3C.7020409@list.ru>
References: <54FF21BE.2040506@list.ru>
 <20150311175227.499612af@free-electrons.com>
 <55007ADD.6080505@list.ru>
 <20150311174618.GE8656@n2100.arm.linux.org.uk>
 <55008483.8050603@list.ru>
 <20150311193343.0317e3e1@free-electrons.com>
 <55018A3C.7020409@list.ru>
Message-ID: <20150312134756.5335cb32@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Stas Sergeev,

On Thu, 12 Mar 2015 15:44:44 +0300, Stas Sergeev wrote:

> Hello Thomas, I haven't got to look into that register:
> uboot is updated to v2011.12-2014_T2.0 and everything
> is working! So thanks once again.

Well if everything is working now, and seeing your boot log, the
register 0xf1020254 will contain 0xf0000000.

> The only problem I now have is the lack of 256Mb of
> ram.
> 
> [    0.000000] MEMBLOCK
> configuration:                                         
> [    0.000000]  memory size = 0x1f0000000 reserved size =
> 0x70d6e3             
> [    0.000000]  memory.cnt  =
> 0x2                                              
> [    0.000000]  memory[0x0]     [0x00000000000000-0x000000efffffff],
> 0xf0000000
> bytes flags:
> 0x0                                                               
> [    0.000000]  memory[0x1]     [0x00000100000000-0x000001ffffffff],
> 0x100000000
>  bytes flags: 0x0 
> 
> There is a 8Gb in a single dimm.
> Do you have any idea why 0xf0000000-0xffffffff range is missing?
> I suspect this is something with uboot too.

No, this is expected. Your physical address space is shared between RAM
and I/O devices. So the space 0xf0000000 -> 0xffffffff in the physical
address space is where all the registers for your SoC and PCIe devices
will be located. You are therefore indeed losing 256 MB of RAM, but
there's nothing that can be done about this.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
