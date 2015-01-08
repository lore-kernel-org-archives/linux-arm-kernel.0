From: mchitale@apm.com (Mayuresh Chitale)
Date: Thu, 8 Jan 2015 12:00:45 +0530
Subject: [PATCH 4/4] dma: X-Gene PCIE DMA Driver
In-Reply-To: <1765004.TVkcxIlmTg@wuerfel>
References: <1420608537-12296-1-git-send-email-mchitale@apm.com>
 <9430055.pMHRTP0RMA@wuerfel>
 <CAL-zptNW81KwWXnMcsh_S5KQFMNGysm=ATmixMge6RXj_U-_zQ@mail.gmail.com>
 <1765004.TVkcxIlmTg@wuerfel>
Message-ID: <CAL-zptM0+K7NLGVankeUDwSwxBEuhhjJqCNsjTrps5WOZYNQ_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 7, 2015 at 9:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 07 January 2015 21:35:22 Mayuresh Chitale wrote:
>> >
>> > I think I'm missing something important here. What exactly is the
>> > interaction with PCI here? Is it possible to use the dmaengine
>> > driver at all when the PCI host controller is not in endpoint mode?
>> Yes. Dmaengine driver can be used when port is configured as RC or EP.
>> >
>> > Does the dmaengine show up as a PCI device when the PCI controller is
>> > in host mode?
>> No. It sits between AXI and PCI interfaces but it needs to be
>> programmed via the config bar.
>
> Ok, I see. So in RC mode, it sounds like this is a regular DMA engine
> that could be used with arbitrary slaves, but in EP mode it would
> actually be controlled by the remote host, right?
No. EP can configure its own DMA engine via config bar, same as RC.
There could be a dependency on RC in terms of which memory region
the EP is allowed to DMA to but I think that is outside the scope of this
driver.
>
> When we are in RC mode, who sets up that BAR? If this is set up by
> the firmware, we can just have the register appear in the DT as well,
> as it's known, and when we are in EP mode, it sounds like we would
> not even use the dmaengine because it's owned by the other host.
The config bar is setup by host controller driver. For e.g you can see
cfg reg in pcie at 1f2b0000 node in arch/arm64/boot/dts/apm/apm-storm.dtsi.
The dmaengine driver is simply going to read this reg to know the config base
and access its own registers accordingly.  In this patch config base
register is present in each node.
For e.g for port0 it is 0x1f2b0154.
>
> Or is there a way that in EP mode, both sides would access the
> dma engine simultaneously?
>
>         Arnd
