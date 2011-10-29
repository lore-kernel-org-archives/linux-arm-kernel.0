From: marco.stornelli@gmail.com (Marco Stornelli)
Date: Sat, 29 Oct 2011 13:04:30 +0200
Subject: [PATCH] ramoops appears geared to not support ARM
In-Reply-To: <20111029093458.GX19187@n2100.arm.linux.org.uk>
References: <1319844110-23062-1-git-send-email-bfreed@chromium.org>
	<4EABBBD3.5030700@gmail.com>
	<20111029093458.GX19187@n2100.arm.linux.org.uk>
Message-ID: <4EABDDBE.5080407@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Il 29/10/2011 11:34, Russell King - ARM Linux ha scritto:
> On Sat, Oct 29, 2011 at 10:39:47AM +0200, Marco Stornelli wrote:
>> (Added linux-arm)
>>
>> Il 29/10/2011 01:21, Bryan Freed ha scritto:
>>> I had some difficulty in getting ramoops to work on our ARM systems.
>>> The driver maps memory with ioremap() which is supposed to map IO memory,
>>> not physical RAM.  This happens to work on x86 and apparently some other
>>> architectures, but it does not work on ARM.
>>> Specifically, I see this comment in __arm_ioremap_pfn_caller():
>>> 	Don't allow RAM to be mapped - this causes problems with ARMv6+
>>>
>>> So here is a patch that hacks around the issue using page_is_ram() to
>>> differentiate between the two.
>>>
>>> Am I missing something here?
>>> Is ramoops working on any ARM systems yet, and I am just doing something wrong?
>>>
>>> My ARM platform reserves a section of RAM for use by ramoops, but it is still
>>> mapped along with the rest of main memory.  This is so /dev/mem can find it
>>> with xlate_dev_mem_ptr().
>>> On x86, I see our BIOS reserves the memory so that it is not counted as main
>>> memory, and it is not mapped until ramoops ioremaps it.
>>>
>>> Bryan Freed (1):
>>>     ramoops: Add support for ARM systems.
>>>
>>>    drivers/char/ramoops.c |   67 +++++++++++++++++++++++++++++++++++++----------
>>>    1 files changed, 52 insertions(+), 15 deletions(-)
>>>
>>
>> Can some ARM guys give an opinion about that?
>
> Opinion about the patch which isn't present in this email (so we can't
> see it) or about the commentry above?
>

About the ioremap problem. It seems there is a problem on some ARM arch 
to use ioremap (ramoops driver) to remap a piece of RAM even if it's not 
used by kernel (reserved at boot with mem option, Bryan can you 
confirm?). It has been suggested by Bryan to use xlate_dev_mem_ptr(), 
but I'm not sure if the problem is how to reserve the memory on these 
ARM archs. I believe ioremap is a general way to do it, of course not 
using kernel already used by kernel, am I right? Or to be compliant with 
all archs (in this particular case with ARMv6+) we should use 
xlate_dev_mem_ptr()?

Marco
