From: aospan@netup.ru (Abylay Ospan)
Date: Thu, 12 Jan 2017 23:55:23 -0500
Subject: [PATCH] PCI: iproc: fix kernel crash if dev->of_node not defined
In-Reply-To: <6cfba8af-1e9b-cb43-4898-61d6fb8f12ca@broadcom.com>
References: <1484266817-6725-1-git-send-email-aospan@netup.ru>
 <6891f43f-25e7-1411-800e-97e6788f2f27@gmail.com>
 <e5301de6-9a6c-7deb-4ff7-ccd462c4381e@broadcom.com>
 <6cfba8af-1e9b-cb43-4898-61d6fb8f12ca@broadcom.com>
Message-ID: <CAK3bHNVQ9Rbuwf1i54h7uLLdkUvyGibmfJpD6zRjt1gYiQD7Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

> Still, upstream Linux support for Northstar is Device Tree, and BCMA bus
> should fill in of_nodes accordingly, if not, that's a bug that must be
> fixed at the BCMA layer.

yes, this is a source of the problem. Devices allocated in
'bcma_bus_scan' but of_node doesn't assigned.
Is some code missing in drivers/bcma/ which should assign of_node ?

I can suggest following "hacky" patch for this (works for me):

Author: Abylay Ospan <aospan@netup.ru>
Date:   Fri Jan 13 07:24:13 2017 +0300

    bcma: force assign 'of_node' for devices on the bus

    prevent other code to fail if no 'of_node' defined

    Signed-off-by: Abylay Ospan <aospan@netup.ru>

diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index 2c1798e..4fe1c92 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -301,6 +301,11 @@ void bcma_init_bus(struct bcma_bus *bus)
 static void bcma_register_core(struct bcma_bus *bus, struct bcma_device *core)
 {
        int err;
+       struct device * dev;
+
+       dev = bcma_bus_get_host_dev(bus);
+       if (dev && !core->dev.of_node)
+               core->dev.of_node = dev->of_node;


if it's ok I will send this patch in separate email.

>
>>
>>>
>>>>
>>>> Signed-off-by: Abylay Ospan <aospan@netup.ru>
>>>> ---
>>>>  drivers/pci/host/pcie-iproc.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
>>>> index 3ebc025..f2836a9 100644
>>>> --- a/drivers/pci/host/pcie-iproc.c
>>>> +++ b/drivers/pci/host/pcie-iproc.c
>>>> @@ -952,6 +952,9 @@ static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
>>>>     const int na = 3, ns = 2;
>>>>     int rlen;
>>>>
>>>> +   if (!node)
>>>> +           return -ENOENT;
>>>> +
>>>>     parser->node = node;
>>>>     parser->pna = of_n_addr_cells(node);
>>>>     parser->np = parser->pna + na + ns;
>>>>
>>>
>>>
>
>
> --
> Florian



-- 
Abylay Ospan,
NetUP Inc.
http://www.netup.tv
