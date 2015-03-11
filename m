From: stsp@list.ru (Stas Sergeev)
Date: Wed, 11 Mar 2015 21:38:53 +0300
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <20150311191118.1edb2ed8@free-electrons.com>
References: <54FF21BE.2040506@list.ru>	<20150311175227.499612af@free-electrons.com>	<55007ADD.6080505@list.ru>	<20150311174618.GE8656@n2100.arm.linux.org.uk>	<550081E2.5030807@list.ru>
 <20150311191118.1edb2ed8@free-electrons.com>
Message-ID: <55008BBD.5010800@list.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

11.03.2015 21:11, Thomas Petazzoni ?????:
> Dear Stas Sergeev,
>
> On Wed, 11 Mar 2015 20:56:50 +0300, Stas Sergeev wrote:
>
>> It doesn't look like it works as intended.
>> Got the crash below.
>> Please note the mappings beyond 0xe0000000, so I wonder if
>> the option worked as expected?
> Are you sure you're not confusing virtual addresses and physical
> addresses?
OK, so I changed Russel's printk to the following way:

+printk("vmalloc: mapping page %p (0x%08lx000) at 0x%08lx 0x%08zx\n",
+    page, page_to_pfn(page), addr, __pa(addr));

(added __pa(addr)) and now I hope I am seeing the physical
addresses at the last column:

[   19.023836] vmalloc: mapping page ef7f1fa0 (0x000bfc7d000) at
0xf04a3000 0x304a3000
[   19.031515] vmalloc: mapping page ef7f3360 (0x000bfd1b000) at
0xf04a4000 0x304a4000
[   19.039221] vmalloc: mapping page ef7f18e0 (0x000bfc47000) at
0xf04a5000 0x304a5000

and they do not exceed mem= option.
Not sure though if this was the right thing to do though. :)

Anyway, with mem=0xc000000 it seems to boot, so many
thanks to everyone!

I'll check the value of the register 0xf1020254 tomorrow and will post back.
