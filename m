From: james.hogan@imgtec.com (James Hogan)
Date: Mon, 29 Apr 2013 21:16:56 +0100
Subject: [v8,01/12] gpio: add gpio offset in gpio range cells property
In-Reply-To: <CAD6h2NTxmZqaYt6wQU3QrmUbPk9wjSSCy0JxhFp0_4MSdvEdDA@mail.gmail.com>
References: <1359825953-15663-2-git-send-email-haojian.zhuang@linaro.org>
 <517E990D.10101@imgtec.com>
 <CAD6h2NTxmZqaYt6wQU3QrmUbPk9wjSSCy0JxhFp0_4MSdvEdDA@mail.gmail.com>
Message-ID: <517ED538.1010002@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/04/13 17:49, Haojian Zhuang wrote:
> On 30 April 2013 00:00, James Hogan <james.hogan@imgtec.com> wrote:
>> On 02/02/13 17:25, Haojian Zhuang wrote:
>>> Add gpio offset into "gpio-range-cells" property. It's used to support
>>> sparse pinctrl range in gpio chip.
>>>
>>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
>> This is an ABI breakage. I've been using the #gpio-range-cells = <2>
>> since around October. Please can we try and maintain backward
>> compatibility in future, even if it's only temporary.
>>
>> Thanks
>> James
>>
> 
> I've updated all code with #gpio-range-cells = <3> in kernel. If you change this
> back to <2>, you'll break current pinctrl-single driver. I appended this because
> there may be not 1-to-1 mapping between gpio pins & pinmux pins in some
> SoC. So the new parameter is used to specify the gpio pin offset.

Yes, I agree having 3 cells is useful, and I wasn't suggesting reverting
your patch, but it's an ABI now so the change should really be done in a
backwards compatible way so that device tree files that still have
#gpio-range-cells = <2> continue to work.

At the moment in -next, if you use an old device tree then the gpio
ranges are muddled up, with npins set apparently to a random (in my case
very large) number, I'm guessing this is just uninitialised data at the
end of the array. Even if you didn't have to maintain backwards
compatibility, it should at least check the number of cells matches what
it expects before reading all 3 entries.

> 
> So it's not temporary.

Sorry, what I meant was "even if maintaining the backwards compatibility
(supporting both <2> and <3>) is only temporary".

Cheers
James
