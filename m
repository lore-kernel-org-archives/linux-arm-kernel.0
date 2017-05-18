From: ybzhao1989@gmail.com (Zhao Yibin)
Date: Thu, 18 May 2017 17:35:18 +0800
Subject: PROBLEM: ARM Cache policy on single armv7 processor lead to low
 DRAM performance
In-Reply-To: <CAOMZO5DOV9Riho1FO_PNJnXhdxQA9YE55sXqygi8eOvEf+vY+A@mail.gmail.com>
References: <CAOEkoLwq1fdVuhkm_Z4Lf1BL0XxLyumSxLF7gDPyK_NkzUdVgQ@mail.gmail.com>
 <CAOMZO5DOV9Riho1FO_PNJnXhdxQA9YE55sXqygi8eOvEf+vY+A@mail.gmail.com>
Message-ID: <CAOEkoLzpmtoU3bWMgd1mhbhCre2uRLW1AG=f51ar=KMLq7yedQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio,

Thanks,
Enable ACTLR.SMP did change the cache behavior, the result is same as
enable CONFIG_SMP.

The TRM of cortex-a7 did mention this,

[6] SMP Enables coherent requests to the processor:
0  Disables coherent requests to the processor. This is the reset value.
1  Enables coherent requests to the processor.
When coherent requests are disabled:
? loads to cacheable memory are not cached by the processor.
? Load-Exclusive instructions take a precise abort if the memory attributes are:
? Inner Write-Back and Outer Shareable.
? Inner Write-Through and Outer Shareable.
? Outer Write-Back and Outer Shareable.
? Outer Write-Through and Outer Shareable.
? Inner Write-Back and Inner Shareable.
? Inner Write-Through and Inner Shareable.
? Outer Write-Back and Inner Shareable.
? Outer Write-Through and Inner Shareable.
Note
 You must ensure this bit is set to 1 before the caches and MMU are
enabled, or any cache and TLB
maintenance operations are performed. The only time this bit is set to
0 is during a processor power-down
sequence. See Power management on page 2-12.

I think It will be great for kernel to enable ACTLR.SMP for cortex-a7
before enable cache, otherwise the cache is not actually used.
And this is really hard to debug if haven't read the trm carefully.

Thanks
Bob
