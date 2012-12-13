From: dromede@gmail.com (=?UTF-8?B?TWFya28gS2F0acSH?=)
Date: Thu, 13 Dec 2012 16:54:05 +0100
Subject: [PATCH] [ARM] sharpsl_param: fix invalid memory access in
 sharpsl_save_param()
In-Reply-To: <20121213145012.GJ26540@mudshark.cambridge.arm.com>
References: <1355409893-24200-1-git-send-email-dromede@gmail.com>
 <20121213145012.GJ26540@mudshark.cambridge.arm.com>
Message-ID: <CAHod+GdXTJ95S=U12M-Dxp+WTmbGhmDo9icMncRZ1zNQA8JiQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 3:50 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Marko,
>
> On Thu, Dec 13, 2012 at 02:44:53PM +0000, dromede at gmail.com wrote:
>> From: Marko Katic <dromede.gmail.com>
>>
>> Devices that call sharpsl_save_param() will hang on boot due to
>> a memcpy call that uses physical addresses that are no longer
>> valid. This is caused by the following commit:
>>
>> commit 72662e01088394577be4a3f14da94cf87bea2591
>> Author: Will Deacon <will.deacon@arm.com>
>> Date:   Wed Nov 23 12:03:27 2011 +0000
>>
>>     ARM: head.S: only include __turn_mmu_on in the initial identity mapping
>>
>> Tested  on Zaurus corgi/poodle/spitz devices.
>>
>> Signed-off-by: Marko Katic <dromede@gmail.com>
>
> Interesting find! Now, I wonder, if you revert Dave's patch conditionalising
> the hyp mode entry (1ecec696c8bb "ARM: 7599/1: head: Remove boot-time HYP
> mode check for v5 and below") and apply your patch below, does your i2c
> still work?

If i revert 1ecec696c8bb my machine simply would not boot. This was
nicely explained by Russell in this post:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/136218.html

In a nutshell, there never was a problem with i2c devices, the problem
was the kernel
booted with the wrong machine ID  and thus machine_is_xxx() checks
would fail and break
i2c init code in mach-pxa/spitz.c.

Sharpsl_param.c patch is a separate issue and is not related to issues
mentioned above.
This is also and older issue, dating back to 3.3-rc1 when 72662e0108
was commited. I posted
this patch earlier but either nobody noticed or my commit message was
bad. Probably the latter.
