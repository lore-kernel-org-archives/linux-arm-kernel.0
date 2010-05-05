From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 05 May 2010 14:06:45 +0400
Subject: Suspicious compilation warning
In-Reply-To: <20100420230719.GB1432@n2100.arm.linux.org.uk>
References: <k2ncecb6d8f1004191627w3cd36450xf797f746460abb09@mail.gmail.com>	<20100420155122.6f2c26eb.akpm@linux-foundation.org>
	<20100420230719.GB1432@n2100.arm.linux.org.uk>
Message-ID: <4BE14335.10702@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Russell King - ARM Linux wrote:

>>> I get this warning while compiling for ARM/SA1100:
>>>
>>> mm/sparse.c: In function '__section_nr':
>>> mm/sparse.c:135: warning: 'root' is used uninitialized in this function
>>>
>>> With a small patch in fs/proc/meminfo.c, I find that NR_SECTION_ROOTS
>>> is zero, which certainly explains the warning.
>>>
>>> # cat /proc/meminfo
>>> NR_SECTION_ROOTS=0
>>> NR_MEM_SECTIONS=32
>>> SECTIONS_PER_ROOT=512
>>> SECTIONS_SHIFT=5
>>> MAX_PHYSMEM_BITS=32
>>>       
>> hm, who owns sparsemem nowadays? Nobody identifiable.
>>
>> Does it make physical sense to have SECTIONS_PER_ROOT > NR_MEM_SECTIONS?
>>     
>
> Well, it'll be about this number on everything using sparsemem extreme:
>
> #define SECTIONS_PER_ROOT       (PAGE_SIZE / sizeof (struct mem_section))
>
> and with only 32 sections, this is going to give a NR_SECTION_ROOTS value
> of zero.  I think the calculation of NR_SECTIONS_ROOTS is wrong.
>
> #define NR_SECTION_ROOTS        (NR_MEM_SECTIONS / SECTIONS_PER_ROOT)
>
> Clearly if we have 1 mem section, we want to have one section root, so
> I think this division should round up any fractional part, thusly:
>
> #define NR_SECTION_ROOTS        ((NR_MEM_SECTIONS + SECTIONS_PER_ROOT - 1) / SECTIONS_PER_ROOT)
>   

   There's DIV_ROUND_UP() macro for this kind of calculation.

WBR, Sergei
