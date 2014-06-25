From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 25 Jun 2014 17:14:53 -0600
Subject: [PATCH v1 5/9] of: Add NVIDIA Tegra XHCI controller binding
In-Reply-To: <CAL1qeaHThKVBoY0fikFCh9X00BFNJ=XKfovOBwztEyOVjHBLjg@mail.gmail.com>
References: <1403072180-4944-1-git-send-email-abrestic@chromium.org>	<1403072180-4944-6-git-send-email-abrestic@chromium.org>	<53AB4530.2050106@wwwdotorg.org>
 <CAL1qeaHThKVBoY0fikFCh9X00BFNJ=XKfovOBwztEyOVjHBLjg@mail.gmail.com>
Message-ID: <53AB57ED.7080600@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2014 05:02 PM, Andrew Bresticker wrote:
> On Wed, Jun 25, 2014 at 2:54 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 06/18/2014 12:16 AM, Andrew Bresticker wrote:
>>> Add device-tree binding documentation for the XHCI controller present
>>> on Tegra124 and later SoCs.
>>
>>> diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xhci.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xhci.txt
>>
>>> + - clock-names: Must include the following entries:
>>> +    - xusb_host
>>> +    - xusb_falcon_src
>>> +    - xusb_ss
>>> +    - xusb_ss_src
>>> +    - xusb_hs_src
>>> +    - xusb_fs_src
>>
>> Looking at include/dt-bindings/clock/tegra124-car.h I see a few entries
>> potentially missing here:
>>
>> #define TEGRA124_CLK_XUSB_HOST_SRC 252
>> #define TEGRA124_CLK_XUSB_DEV_SRC 256
>> #define TEGRA124_CLK_XUSB_DEV 257
>> #define TEGRA124_CLK_XUSB_SS_DIV2 312
> 
> The driver doesn't use them, so I didn't put them in the binding.

I think we should add them in case we need them later. Best to fully
describe the HW rather than the parts of the HW that SW currently uses.

>>> +    - pll_u_480m
>>
>> Not just pll_u?
> 
> We specifically want pll_u_480M as that's what we use as the parent of
> xusb_ss_src when scaling it to 120Mhz.

OK. I recall text in the TRM implying that SW should just leave PLL_U
alone and not fiddle with the separate output clocks. Still, if we have
a clock ID for each output, and it's the correct parent for the clock,
then it does make sense to use that ID.
