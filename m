From: robherring2@gmail.com (Rob Herring)
Date: Tue, 17 Apr 2012 10:36:42 -0500
Subject: [PATCH v2] plat-versatile: modernize FPGA IRQ controller
In-Reply-To: <CACRpkdZTacwxc=sn8qiKMjrCRZyymwet3cZb=OE87JkuVSj-MA@mail.gmail.com>
References: <1334422936-28856-1-git-send-email-linus.walleij@linaro.org>
 <4F89EE5B.5080709@gmail.com>
 <CACRpkdZTacwxc=sn8qiKMjrCRZyymwet3cZb=OE87JkuVSj-MA@mail.gmail.com>
Message-ID: <4F8D8E0A.7040006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2012 02:31 PM, Linus Walleij wrote:
> On Sat, Apr 14, 2012 at 11:38 PM, Rob Herring <robherring2@gmail.com> wrote:
> 
>>> +     fpga_irq_init(VA_SIC_BASE, "SIC", IRQ_SIC_START,
>>> +             IRQ_VICSOURCE31, ~PIC_MASK, np);
>>
>> This needs some work...
>>
>> For DT, you want to be calling of_irq_init and have a fpga_irq_dt_init
>> function which gets all this info from the dts. That's fine to do as a
>> follow on patch.
> 
> Yeah I need to do this stepwise or I'll end up tearing my hair.
> 
>>>       for (i = 0; i < 32; i++) {
>>
>> This loop should be replaced by the domain .map function. For a legacy
>> domain, .map will be called by irq_domain_add_legacy 32 times.
> 
> OK ... of course it works like a charm. Will post v3 soon-ish.
> 
> On small obstacle: the .map function does not pass the
> void *host_data, so I worked around this by using a static
> file-local but this is a bit ugly...

You can't use domain->host_data ptr?

>> If you have a valid mask, then I think you should be able to skip the holes.
> 
> Sure can. Works fine.
> 
>>> +     f->domain = irq_domain_add_legacy(node, 32, f->irq_start, 0,
>>
>> I think the fact that you always pass in 32 is your problem. You should
>> use "fls(valid) - 1" here.
> 
> Since the function takes an absolute number of IRQs I guess
> it's just fls(valid)? It worked for me anyway...

Ah, you're right. I was thinking bit position, not number.

Rob
> 
> Thanks a lot Rob!
> Linus Walleij
