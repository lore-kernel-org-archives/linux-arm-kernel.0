From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 30 Nov 2014 21:19:44 +0900
Subject: [PATCH v2 3/5] pinctrl: exynos: Fix GPIO setup failure because
 domain clock being gated
In-Reply-To: <1417183724.18249.36.camel@AMDC1943>
References: <1417011857-10419-1-git-send-email-k.kozlowski@samsung.com>
 <1417011857-10419-4-git-send-email-k.kozlowski@samsung.com>
 <CACRpkdb8F8YcvFeHPvOKHjx_p4HEpimck3XRabB3oHpZTdmRQQ@mail.gmail.com>
 <1417183724.18249.36.camel@AMDC1943>
Message-ID: <CA+Ln22Ejo51VPWf6DmuRvV_fZr_H=-BXAshSPSOokNE1bz=-QA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

2014-11-28 23:08 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> On pi?, 2014-11-28 at 15:04 +0100, Linus Walleij wrote:
>> On Wed, Nov 26, 2014 at 3:24 PM, Krzysztof Kozlowski
>> <k.kozlowski@samsung.com> wrote:
>>
>> > The audio subsystem on Exynos 5420 has separate clocks and GPIO. To
>> > operate properly on GPIOs the main block clock 'mau_epll' must be
>> > enabled.
>> >
>> > This was observed on Peach Pi/Pit and Arndale Octa (after enabling i2s0)
>> > after introducing runtime PM to pl330 DMA driver. After that commit the
>> > 'mau_epll' was gated, because the "amba" clock was disabled and there
>> > were no more users of mau_epll.
>> >
>> > The system hang just before probing i2s0 because
>> > samsung_pinmux_setup() tried to access memory from audss block which was
>> > gated.
>> >
>> > Add a clock property to the pinctrl driver and enable the clock during
>> > GPIO setup. During normal GPIO operations (set, get, set_direction) the
>> > clock is not enabled.

Could you make sure that possibility of gating this clock is worth the
effort of adding gating code to all affected drivers? If there is no
significant change in power consumption maybe it could be simply keep
running all the time?

Also isn't a similar problem happening due to power domains? I believe
the whole maudio block is located in a separate power domain but
somehow it doesn't get turned off?

Could you investigate the above, please?

Best regards,
Tomasz
