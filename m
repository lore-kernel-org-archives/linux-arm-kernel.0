From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 03 Jun 2013 15:37:39 -0700
Subject: [PATCH] ARM: avoid mis-detecting some V7 cores in the decompressor
In-Reply-To: <20130603222321.GP18614@n2100.arm.linux.org.uk>
References: <1368049671-22879-1-git-send-email-sboyd@codeaurora.org>
 <5193E424.9090605@codeaurora.org> <519E57D2.3050000@codeaurora.org>
 <20130523231531.GT18614@n2100.arm.linux.org.uk>
 <20130524220539.GB599@codeaurora.org> <51AD0703.6050408@codeaurora.org>
 <20130603222321.GP18614@n2100.arm.linux.org.uk>
Message-ID: <51AD1AB3.9050908@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/13 15:23, Russell King - ARM Linux wrote:
> On Mon, Jun 03, 2013 at 02:13:39PM -0700, Stephen Boyd wrote:
>> We
>> can't get any information about why the decompression failed if
>> we have debug_ll enabled. I had to patch the error() routine to
>> not while loop forever to get that print after do_decompress to
>> be useful.)
> Maybe your implementation of puts() for the decompressor is faulty then?
> Because it works for me - when something goes wrong with the decompression,
> I get a message such as:
>
> Decompressing kernel...
>
> CRC error
>
>  -- System halted
>

I was expecting to see

Decompressing kernel...

CRC error

decompressor returned an error


but since we loop forever this code in arch/arm/boot/compressed/misc.c
doesn't do anything:

        if (ret)
                error("decompressor returned an error");


I guess that is desired though because you say we shouldn't do something
stupid.

>>> I see a few solutions.
>>>
>>>  1) Relocate with caches off and then turn on caches after we're
>>>     running in a location where we won't overwrite ourselves.
>>>
>>>  2) Have temporary page tables for the relocation phase that live
>>>     just below the location we're going to relocate to.
>>>
>>>  3) Force bootloaders loading these types of images to load the
>>>     zImage at least as high as the TEXT_OFFSET is compiled to.
>>>
>>> I don't think we can convince everyone that #3 is ok to do. I'm
>>> leaning towards #2 since we get all the benefits of the cache
>>> during the relocation phase but #1 is the obviously simple fix.
> (3) is what we've always required in the past.  We already have code
> to relocate the compressed image, so we _might_ be able to do (1).
>
> The easy solution is to continue saying "minimum of RAM start + 32K"
> as we've always had in the past though.

In my case I'm booting a kernel with textoffset = 0x208000 but RAM
starts at 0x0. Does "minimum of RAM start" mean 0x0 or 0x200000?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
