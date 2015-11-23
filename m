From: laura@labbott.name (Laura Abbott)
Date: Mon, 23 Nov 2015 09:52:11 -0800
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <56534212.3000302@redhat.com>
References: <1447858999-26665-1-git-send-email-jeremy.linton@arm.com>
 <20151118152044.GD10644@leverpostej> <564CA29A.9050905@arm.com>
 <20151118162932.GA13355@leverpostej>
 <20151123155132.GC32300@e104818-lin.cambridge.arm.com>
 <5653387A.2000101@redhat.com> <565340C9.7010605@labbott.name>
 <56534212.3000302@redhat.com>
Message-ID: <5653524B.40302@labbott.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/15 8:42 AM, Jeremy Linton wrote:
> On 11/23/2015 10:37 AM, Laura Abbott wrote:
>> Which permissions still need to be cleaned up from your perspective?
>
> IMHO, the vast majority of the linear map should not be executable/read/write, which is what happens today.
>

With CONFIG_DEBUG_RODATA on I'm not seeing any rwx regions

# cat /sys/kernel/debug/kernel_page_tables
---[ vmalloc() Area ]---
0xffffff8000000000-0xffffff8000010000          64K     RW NX SHD AF            UXN DEVICE/nGnRE
0xffffff8000012000-0xffffff8000013000           4K     RW NX SHD AF            UXN DEVICE/nGnRE
0xffffff8000018000-0xffffff8000019000           4K     RW NX SHD AF            UXN DEVICE/nGnRE
0xffffff8000020000-0xffffff8000030000          64K     RW NX SHD AF            UXN DEVICE/nGnRE
0xffffff8000031000-0xffffff8000071000         256K     RW NX SHD AF            UXN MEM/NORMAL-NC
0xffffff8000080000-0xffffff8000180000           1M     RW NX SHD AF            UXN DEVICE/nGnRE
0xffffff80001ae000-0xffffff80001b1000          12K     RW NX SHD AF            UXN MEM/NORMAL
0xffffff8000200000-0xffffff8000300000           1M     RW NX SHD AF            UXN DEVICE/nGnRE
0xffffff8000380000-0xffffff8000480000           1M     RW NX SHD AF            UXN DEVICE/nGnRE
0xffffff8000500000-0xffffff8000600000           1M     RW NX SHD AF            UXN DEVICE/nGnRE
0xffffff8000680000-0xffffff8000780000           1M     RW NX SHD AF            UXN DEVICE/nGnRE
0xffffff8000800000-0xffffff8000900000           1M     RW NX SHD AF            UXN DEVICE/nGnRE
0xffffff8000980000-0xffffff8000a80000           1M     RW NX SHD AF            UXN DEVICE/nGnRE
0xffffff8000b00000-0xffffff8000c00000           1M     RW NX SHD AF            UXN DEVICE/nGnRE
0xffffff8000c80000-0xffffff8000d80000           1M     RW NX SHD AF            UXN DEVICE/nGnRE
0xffffff8000e00000-0xffffff8000f00000           1M     RW NX SHD AF            UXN DEVICE/nGnRE
0xffffff8000f80000-0xffffff8001080000           1M     RW NX SHD AF            UXN DEVICE/nGnRE
0xffffff8001100000-0xffffff8001200000           1M     RW NX SHD AF            UXN DEVICE/nGnRE
0xffffff8001280000-0xffffff8001380000           1M     RW NX SHD AF            UXN DEVICE/nGnRE
0xffffff8001400000-0xffffff8001500000           1M     RW NX SHD AF            UXN DEVICE/nGnRE
0xffffff8001580000-0xffffff8001680000           1M     RW NX SHD AF            UXN DEVICE/nGnRE
0xffffff8001700000-0xffffff8001800000           1M     RW NX SHD AF            UXN DEVICE/nGnRE
---[ vmalloc() End ]---
---[ vmemmap start ]---
0xffffffbdc1000000-0xffffffbdc3000000          32M     RW NX SHD AF        BLK UXN MEM/NORMAL
---[ vmemmap end ]---
---[ Fixmap start ]---
0xffffffbffa800000-0xffffffbffaa00000           2M     ro NX SHD AF        BLK UXN MEM/NORMAL
---[ Fixmap end ]---
---[ PCI I/O start ]---
0xffffffbffae00000-0xffffffbffae10000          64K     RW NX SHD AF            UXN DEVICE/nGnRE
---[ PCI I/O end ]---
---[ Modules start ]---
---[ Modules end ]---
---[ Kernel Mapping ]---
0xffffffc000000000-0xffffffc000080000         512K     RW NX SHD AF    CON     UXN MEM/NORMAL
0xffffffc000080000-0xffffffc000082000           8K     RW NX SHD AF            UXN MEM/NORMAL
0xffffffc000082000-0xffffffc000090000          56K     ro x  SHD AF            UXN MEM/NORMAL
0xffffffc000090000-0xffffffc000200000        1472K     ro x  SHD AF    CON     UXN MEM/NORMAL
0xffffffc000200000-0xffffffc000800000           6M     ro x  SHD AF        BLK UXN MEM/NORMAL
0xffffffc000800000-0xffffffc000980000        1536K     ro x  SHD AF    CON     UXN MEM/NORMAL
0xffffffc000980000-0xffffffc000987000          28K     ro x  SHD AF            UXN MEM/NORMAL
0xffffffc000987000-0xffffffc000990000          36K     RW NX SHD AF            UXN MEM/NORMAL
0xffffffc000990000-0xffffffc000a00000         448K     RW NX SHD AF    CON     UXN MEM/NORMAL
0xffffffc000a00000-0xffffffc000a10000          64K     RW NX SHD AF            UXN MEM/NORMAL
0xffffffc000a10000-0xffffffc000c00000        1984K     RW NX SHD AF    CON     UXN MEM/NORMAL
0xffffffc000c00000-0xffffffc040000000        1012M     RW NX SHD AF        BLK UXN MEM/NORMAL
0xffffffc040000000-0xffffffc080000000           1G     RW NX SHD AF        BLK UXN MEM/NORMAL

are there other parts of the map you're seeing that aren't on my system?

Thanks,
Laura
