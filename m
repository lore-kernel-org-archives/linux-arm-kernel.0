From: robherring2@gmail.com (Rob Herring)
Date: Wed, 4 Jun 2014 08:52:42 -0500
Subject: [PATCH v6 1/6] clocksource: Add support for the Mediatek SoCs
In-Reply-To: <538F0230.7090800@free-electrons.com>
References: <1401468964-5307-1-git-send-email-matthias.bgg@gmail.com>
 <1401468964-5307-2-git-send-email-matthias.bgg@gmail.com>
 <CAL_JsqKCTZjh7o2zf_WsVi=iAR1ivTPQpvpNJ6W87jPXakMnZg@mail.gmail.com>
 <538F0230.7090800@free-electrons.com>
Message-ID: <CAL_JsqJGMDNKwJ7M5-mtbbKTa434=pXUTfYZH39Tja0LwJO7_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 4, 2014 at 6:25 AM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Rob,
>
> On 04/06/2014 13:18, Rob Herring wrote:
>
> [...]
>
>>> +
>>> +       if (of_address_to_resource(node, 0, &res))
>>> +               panic("Failed to parse resource\n");
>>
>> panics are a bit pointless at this stage since your console is
>> typically not up yet. Warning and continuing on with boot gives you a
>> better shot at actually seeing the message.
>>
>>> +
>>> +       if (!request_mem_region(res.start, resource_size(&res), "mtk-timer"))
>>> +               panic("Registers are a busy IO resource");
>>> +
>>> +       evt->gpt_base = ioremap(res.start, resource_size(&res));
>>
>> of_iomap instead of these 3 calls.
>
> Actually of_iomap doesn't request_mem_region, that's why for
> mvebu we are trying now to replace of_iomap by request_mem_region/ioremap.

Then perhaps we should add of_iomap_resource which does both. It could
possibly be added into of_iomap, but we'd have to ignore any failures
due to overlapping regions.

Rob
