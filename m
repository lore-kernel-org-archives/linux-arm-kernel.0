From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 4 Jun 2014 15:46:00 +0200 (CEST)
Subject: [PATCH v6 1/6] clocksource: Add support for the Mediatek SoCs
In-Reply-To: <538F0230.7090800@free-electrons.com>
References: <1401468964-5307-1-git-send-email-matthias.bgg@gmail.com>
 <1401468964-5307-2-git-send-email-matthias.bgg@gmail.com>
 <CAL_JsqKCTZjh7o2zf_WsVi=iAR1ivTPQpvpNJ6W87jPXakMnZg@mail.gmail.com>
 <538F0230.7090800@free-electrons.com>
Message-ID: <alpine.DEB.2.10.1406041544130.3319@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Jun 2014, Gregory CLEMENT wrote:
> Hi Rob,
> 
> On 04/06/2014 13:18, Rob Herring wrote:
> 
> [...]
> 
> >> +
> >> +       if (of_address_to_resource(node, 0, &res))
> >> +               panic("Failed to parse resource\n");
> > 
> > panics are a bit pointless at this stage since your console is
> > typically not up yet. Warning and continuing on with boot gives you a
> > better shot at actually seeing the message.
> > 
> >> +
> >> +       if (!request_mem_region(res.start, resource_size(&res), "mtk-timer"))
> >> +               panic("Registers are a busy IO resource");
> >> +
> >> +       evt->gpt_base = ioremap(res.start, resource_size(&res));
> > 
> > of_iomap instead of these 3 calls.
> 
> Actually of_iomap doesn't request_mem_region, that's why for
> mvebu we are trying now to replace of_iomap by request_mem_region/ioremap.

What about creating of_io_request_and_map() instead of open coding it ?

Thanks,

	tglx
