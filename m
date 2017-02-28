From: robh@kernel.org (Rob Herring)
Date: Tue, 28 Feb 2017 08:26:37 -0600
Subject: [PATCH v2 3/3] media: dt-bindings: vpif: new optional property
In-Reply-To: <6b392a4a-2de8-9981-ad40-ca7201bf813d@ti.com>
References: <1487771027-7763-1-git-send-email-bgolaszewski@baylibre.com>
 <1487771027-7763-4-git-send-email-bgolaszewski@baylibre.com>
 <20170227225209.26oieqwbafqjga2a@rob-hp-laptop>
 <6b392a4a-2de8-9981-ad40-ca7201bf813d@ti.com>
Message-ID: <CAL_JsqLBYqGgOA1GUi9mHT-51D5k96w-N0FiOyF+qPY6BGStzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2017 at 11:36 PM, Sekhar Nori <nsekhar@ti.com> wrote:
> On Tuesday 28 February 2017 04:22 AM, Rob Herring wrote:
>> On Wed, Feb 22, 2017 at 02:43:47PM +0100, Bartosz Golaszewski wrote:
>>> Add an optional property - enable-gpios - which can be used to specify
>>> the GPIOs that must be requested to select the vpif functionality.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> ---
>>>  Documentation/devicetree/bindings/media/ti,da850-vpif.txt | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/media/ti,da850-vpif.txt b/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
>>> index df7182a..23c5405 100644
>>> --- a/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
>>> +++ b/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
>>> @@ -13,6 +13,9 @@ Required properties:
>>>  - reg: physical base address and length of the registers set for the device;
>>>  - interrupts: should contain IRQ line for the VPIF
>>>
>>> +Optional properties:
>>> +- enable-gpios: phandle of the GPIOs used to select the vpif functionality
>>
>> What does this control exactly? The GPIOs belong in the node they are
>> connected to and having GPIOs routed to this block seems strange.
>
> The DA850 EVM board implements on-board muxing which lets the video
> input (via VPIF) to be routed to a TVP5147 (video decoder) for composite
> input or to a camera header. There are other mux options which use the
> same VPIF SoC pins (RMII ethernet or character LCD).
>
> There is a three-to-eight demux on the board which drives enable signals
> to buffers letting you choose from these options.
>
> From your response, it looks like you want the enable-gpios property to
> be in the TVP5147 or camera node. That does make sense to me.

Well, seems like they should be part of a mux node. I'd suggest you
look at the video-multiplexer binding under review[1].

Though for other non video functions, that would be some sort of board
level pin mux control. There's a new mux binding too, maybe that would
work. In any case, it shouldn't be the VPIF driver controlling the
GPIOs directly.

Rob

[1] https://lkml.org/lkml/2017/1/6/1056
