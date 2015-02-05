From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Feb 2015 14:47:43 -0600
Subject: [PATCH 2/4] rtc: sa1100: convert to run-time register mapping
In-Reply-To: <8761bg9ngy.fsf@free.fr>
References: <1423005775-26457-1-git-send-email-robh@kernel.org>
 <1423005775-26457-3-git-send-email-robh@kernel.org> <87h9v1a8k2.fsf@free.fr>
 <CAL_JsqLiiKvzxQqE=bEx7qoLSZXLZOegt87A=+pR3PJuSBK95w@mail.gmail.com>
 <20150205135037.GP8656@n2100.arm.linux.org.uk> <8761bg9ngy.fsf@free.fr>
Message-ID: <CAL_JsqJ5Ju98adz5Y2Ow2JDnvFdKhCRvpH8Xg1OfMYOhJaUUFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 5, 2015 at 1:18 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>
>> On Thu, Feb 05, 2015 at 07:34:50AM -0600, Rob Herring wrote:
>>> > And just for your information, both rtc-sa1100 and rtc-pxa can be used at the
>>> > same time in a pxa kernel.
>>>
>>> Yes, I know. I find that a bit odd. We'll have a bit of a problem
>>> supporting that with DT BTW.
>>
>> I think you're close to that problem without DT anyway.  You modify
>> rtc-sa1100 to use devm_ioremap_resource(), which claims the memory
>> resource exclusively, thus marking the memory region exclusive.
> Ah yes, I have not caught that one.

Yes, I was aware of this.

>> Luckily, rtc-pxa uses devm_ioremap() without claiming the memory
>> resource - which is the only saving grace for why it still works.
>> If rtc-pxa were to be converted to use devm_ioremap_resource(), then
>> they'll become mutually exclusive.
> True.
>
> Since the pxa-rtc begin ([1] and [2]), the idea was that both rtc-pxa and
> rtc-sa1100 could work in the same kernel, each handling a part of RTC
> functionality.
>
> Retrospectively, I think I made an error there, when I agreed the pxa2xx had 2
> distinct RTC IPs. The sharing of ioresource as well of the IRQ should have made
> me decide it was a _single_ IP.

It is also shared registers.

> And it's only a matter of time until rtc-pxa claims the resources too I think,
> probably by some device-tree push.

Blame DT for enforcing proper kernel driver design... ;)

> As a consequence, I'm pretty much in favor of :
>  - making rtc-pxa and rtc-sa1100 exclusive

+1

>  - adding to rtc-pxa driver :
>    - a new rtc device (ie. it will register 2 rtc devices, one of the sa1100
>      kind, one of the pxa specific kind)

I fail to see what the rtc-pxa gets us? Something to do with which
counter has correct time at boot? It has a rollover longer than ~126
years is all I see. Otherwise, it looks like over-engineered h/w to
me.

> This has flaws :
>  - a bit of code will be duplicated between rtc-pxa and rtc-sa1100

That can probably be mitigated with a common file of shared functions.

>  - the ordering in rtc-pxa between the 2 rtc devices will be important, as if I
>  remember correctly /dev/rtc points to the first /dev/rtc0 registered
>
> But it opens up :
>  - DT path to both drivers
>  - isolation between sa1100 architecture changes and pxa architecture changes
>  - Rob's current patches can remain almost the same
>
>> Also note that by including the resource in rtc-sa1100's platform
>> device resource list, you'll have stacked resources between the two
>> platform devices appearing in /proc/iomem (you did look at that
>> before posting the patches, right?)
> I must admit I don't know if there are nasty consequences, I think I need to
> follow up the code to have a clear idea.

I don't follow either. The resources don't appear unless requested and
we only have 1 driver requesting it.

Rob

> Cheers.
>
> --
> Robert
>
> A bit of history for sa1100/pxa-rtc split :
> [1]
>  http://archive.arm.linux.org.uk/lurker/message/20081001.191833.4d220566.en.html
> [2]
>  http://archive.arm.linux.org.uk/lurker/message/20081010.072816.93bd675d.en.html
