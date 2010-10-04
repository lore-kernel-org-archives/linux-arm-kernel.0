From: notasas@gmail.com (Grazvydas Ignotas)
Date: Mon, 4 Oct 2010 12:03:58 +0300
Subject: [PATCH 02/14] omap: Map only available sram memory
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE18C@dbde02.ent.ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTi=PM1x7zXbSMRxBHVZ5Z2+4iwebvbiGizca_rC8@mail.gmail.com>
	<20101001225303.GF3117@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CDFE18C@dbde02.ent.ti.com>
Message-ID: <AANLkTi=zmgSCCg71NsYMte9K-yeyb1i0VxCA4i_9Y8D-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> >
>> > This hangs OMAP3 pandora:
>> >
>> > [ ? ?0.000000] Linux version
>> > 2.6.36-rc6-next-20101001-00002-ge76bb53-dirty (notaz at pixelinis) (gcc
>> > version 4.3.3 (Sourcery G++ Lite 2009q1-20
>> > [ ? ?0.000000] CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7),
>> cr=10c53c7f
>> > [ ? ?0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing
>> > instruction cache
>> > [ ? ?0.000000] Machine: Pandora Handheld Console
>> > [ ? ?0.000000] Ignoring unrecognised tag 0x54410008
>> > [ ? ?0.000000] bootconsole [earlycon0] enabled
>> > [ ? ?0.000000] Reserving 6422528 bytes SDRAM for VRAM
>> > [ ? ?0.000000] Memory policy: ECC disabled, Data cache writeback
>> > [ ? ?0.000000] OMAP3430/3530 ES2.1 (l2cache iva sgx neon isp )
>> > [ ? ?0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x10000
>> > (stuck here)
>> >
>> > reverting this fixes the problem.
>>
>> Hmm, boots fine here with overo. Any idea what in this patch breaks
>> pandora?
>>
> The change in this patch is not board dependent really. Have tested this
> on 3430SDP. Pandora is OMAP3 based, right ?

OMAP3530 ES2.1, also tried on friend's beagleboard b5 (also ES2.1) and
it has the same problem. Maybe it's because of older Cortex A8 used
there, or I'm missing some errata workaround in defconfig.

BTW, hacking the size to 1M on top of your patch fixes the problem too:

        base = omap_sram_start;
        base = ROUND_DOWN(base, PAGE_SIZE);
        omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
-       omap_sram_io_desc[0].length = ROUND_DOWN(omap_sram_size, PAGE_SIZE);
+       omap_sram_io_desc[0].length = 0x100000;
        iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));
