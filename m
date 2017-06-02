From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 2 Jun 2017 13:27:25 -0700
Subject: [PATCH] ARM: dts: da850-evm: fix tca6416 for use with GPIO hogs
In-Reply-To: <230e0aa5-6545-e546-6822-77ef53c07b3b@ti.com>
References: <20170531012125.12258-1-khilman@baylibre.com>
 <230e0aa5-6545-e546-6822-77ef53c07b3b@ti.com>
Message-ID: <CAOi56cXvsA7b8QFqTpPNeHFFZbMsB4-VVoErMouZk=T-3ZiR9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 1, 2017 at 11:01 PM, Sekhar Nori <nsekhar@ti.com> wrote:
> Hi Kevin,
>
> On Wednesday 31 May 2017 06:51 AM, Kevin Hilman wrote:
>> In order GPIOS from this controller to be used with the "gpio-hogs"
>> property, the tca6416 node has to properly labeled as a gpio-controller,
>> and use #gpio-cells.
>>
>> With that, the SEL_A, SEL_B, SEL_C lines that are used to select VPIF
>> input can be configured using GPIO hogs.
>>
>> As an example, example, the configuration below selects the analog video
>> input on the da850-evm UI board:
>>
>> &tca6416 {
>>        status = "okay";
>>
>>        sel_a {
>>               gpio-hog;
>>               gpios = <7 GPIO_ACTIVE_HIGH>;
>>               output-high;
>>               line-name = "ADC_ENn";
>>        };
>>        sel_b {
>>               gpio-hog;
>>               gpios = <6 GPIO_ACTIVE_HIGH>;
>>               output-high;
>>               line-name = "CAMERA_ENn";
>>        };
>>        sel_c {
>>               gpio-hog;
>>               gpios = <5 GPIO_ACTIVE_HIGH>;
>>               output-low;
>>               line-name = "VIDEO_IN_ENn";
>>        };
>> };
>>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>
> This patch looks good to me. On the topic of using gpio hogs for this
> sort of thing, in the past I felt using enable-gpios property is better.
>
> My reasoning given to Bartosz is here:
> https://patchwork.kernel.org/patch/9578031/

Sure, that's fine when they are used for a specific functionality, but
using gpio-hog is very useful for testing/debugging, so this patch
just aims at fixing the basics.

That being said, I'm still not convinced what the best place for this
is because they're not really part of the VPIF either (e.g. they
control the character LCD which has nothing to do with the VPIF.)

In any case, I'm not trying to solve that problem in this patch, so
thanks for the review.

Kevin
