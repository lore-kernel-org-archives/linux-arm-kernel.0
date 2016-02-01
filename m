From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 1 Feb 2016 15:26:43 +0100
Subject: [linux-sunxi] Problem with Allwinner H3 clocks
In-Reply-To: <20160201063731.GG32462@lukather>
References: <20160127103714.58312b152adb4148bae2f93b@free.fr>
 <56A8D5E5.30701@gmail.com> <20160127175512.87caf31b5e21a1fec91507f2@free.fr>
 <56A9098A.5010107@redhat.com>
 <20160127200217.14dce96ade71cf81bc82e6f6@free.fr>
 <56A9CE3D.4020906@redhat.com> <56AA14AA.4070502@gmail.com>
 <20160128175918.78a916a8cd7bf4c0b2f2814f@free.fr>
 <20160128192931.GB32462@lukather> <56AB05EF.2090604@redhat.com>
 <20160201063731.GG32462@lukather>
Message-ID: <56AF6B23.1010901@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01-02-16 07:37, Maxime Ripard wrote:
> Hi,
>
> On Fri, Jan 29, 2016 at 07:25:51AM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 01/28/2016 08:29 PM, Maxime Ripard wrote:
>>> On Thu, Jan 28, 2016 at 05:59:18PM +0100, Jean-Francois Moine wrote:
>>
>> <snip>
>>
>>>> The A23/A33/H3 (and surely some other SoCs) documentations about
>>>> the peripheral/periph/periph0/periph1 PLLs say:
>>>>
>>>> 	Note: The PLL Output should be fixed to 600MHz, it is not
>>>> 	recommended to vary this value arbitrarily.
>>>
>>> I don't know if it's worth it at this point. The pll6 seems to work
>>> fine at other rates. Have you experienced any breakage when running at
>>> another frequency?
>>
>> Hmm, are we actually changing the freq of pll6 on any SoCs? I know we've
>> the code to it, but given that it is shared between many pheripherals,
>> I assume we end up never changing it.
>
> We don't, but it works. Back when I was debugging the A31 DMA
> controller, I tried to do just that and nothing broke (at least as
> long as you don't switch halfway through during the boot, but at the
> time the clock is registered).
>
>> I assume / hope that the clock framework protects against reclocking
>> a clock with multiple users ...
>
> There is, but it's opt-in, and we're not using it yet for anything but
> the hstimers (and in that case, we don't prevent the reclocking, we
> just take it into account).

Shouldn't we be opt-ing in then ? At least the mmc driver makes
clk_set_rate calls, it would be bad if that somehow ends up changing the
pll6 rate while other peripherals are using it.

Regards,

Hans
