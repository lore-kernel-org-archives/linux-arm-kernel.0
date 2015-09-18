From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Sep 2015 09:53:20 +0200
Subject: [PATCH 1/3] clocksource: rockchip: Make the driver more
 readability and compatible
In-Reply-To: <20150917211331.GU21084@n2100.arm.linux.org.uk>
References: <1442476272-31723-1-git-send-email-wxt@rock-chips.com>
 <1442476272-31723-2-git-send-email-wxt@rock-chips.com>
 <55FA83D5.9010504@linaro.org> <55FA87AA.4040807@gmail.com>
 <55FA9099.7000903@linaro.org> <alpine.DEB.2.11.1509171217080.3951@nanos>
 <55FA9CB1.8010402@linaro.org> <20150917211331.GU21084@n2100.arm.linux.org.uk>
Message-ID: <55FBC2F0.7010708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2015 11:13 PM, Russell King - ARM Linux wrote:
> On Thu, Sep 17, 2015 at 12:57:53PM +0200, Daniel Lezcano wrote:
>> Hi Thomas,
>>
>> there is one thing I don't understand.
>>
>> If the IRQ0 is invalid, irq_of_parse_and_map returning zero means an error
>> and from what you said it is ok.
>>
>> But I see the NO_IRQ on ARM is (-1) and the drivers are checking with NO_IRQ
>> the return code of irq_of_parse_and_map. So if there is an error, that won't
>> be detected.

Hi Russel,


> NO_IRQ being -1 is a legacy thing for ARM - all ARM drivers are supposed
> to be converted to use <= 0 or == 0 to detect invalid IRQs, and _eventually_
> once all users are gone, NO_IRQ deleted.
>
> Moreover, there are supposed to be no _new_ users of NO_IRQ ever added to
> the kernel.
>
> Modern drivers should _all_ be using !irq to detect invalid IRQs, and not
> using NO_IRQ.

Ah, ok. Thanks for the clarification.

> The steps here are:
>
> 1. Convert all ARM platforms to start numbering IRQs from 1 rather than 0.
> 2. Convert all drivers used on ARM to detect lack of IRQ by checking for
>     <= 0.
> 3. Replace NO_IRQ assignments with zero-initialisations.
> 4. Remove NO_IRQ.
>
> The reason it hasn't happened is that it requires effort and testing,
> and rather than running around getting old platforms to boot (which
> includes remembering _how_ to get them to boot) with recent kernels,
> I prefer to spend my time doing more productive work with modern code.

I understand. I will take the opportunity track down those NO_IRQ in the 
clocksource directory.

   -- Daniel




-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
