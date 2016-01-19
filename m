From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Tue, 19 Jan 2016 11:28:56 +0530
Subject: [PATCH v9 5/6] PCI: generic: Make pci-host-generic driver numa
 aware
In-Reply-To: <569D23AF.9050503@gmail.com>
References: <1453134965-6125-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1453134965-6125-6-git-send-email-gkulkarni@caviumnetworks.com>
 <569D23AF.9050503@gmail.com>
Message-ID: <CAFpQJXXESn1EA5kotVOH2oLbRUSpOLf6+MeWG1pY_GhUP+4vVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2016 at 11:11 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 01/18/2016 08:36 AM, Ganapatrao Kulkarni wrote:
>>
>> update numa_node of device associated with pci bus.
>> moved down devm_kzalloc to allocate from node memory.
>>
>> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>> ---
>>   drivers/pci/host/pci-host-generic.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/host/pci-host-generic.c
>> b/drivers/pci/host/pci-host-generic.c
>> index 5434c90..0e1ce06 100644
>> --- a/drivers/pci/host/pci-host-generic.c
>> +++ b/drivers/pci/host/pci-host-generic.c
>> @@ -215,11 +215,9 @@ static int gen_pci_probe(struct platform_device
>> *pdev)
>>         const struct of_device_id *of_id;
>>         struct device *dev = &pdev->dev;
>>         struct device_node *np = dev->of_node;
>> -       struct gen_pci *pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
>> +       struct gen_pci *pci;
>>         struct pci_bus *bus, *child;
>>
>> -       if (!pci)
>> -               return -ENOMEM;
>>
>>         type = of_get_property(np, "device_type", NULL);
>>         if (!type || strcmp(type, "pci")) {
>> @@ -230,6 +228,11 @@ static int gen_pci_probe(struct platform_device
>> *pdev)
>>         of_pci_check_probe_only();
>>
>>         of_id = of_match_node(gen_pci_of_match, np);
>> +       set_dev_node(dev, of_node_to_nid(np));
>
>
> This shouldn't be done in individual platform_drivers, but instead in the
> device probing code.
>
> There is code that does this in drivers/of/platform.c and
> drivers/of/device.c  Is that not being called for the pci-host-gweneric
> devices?  If not, we should figure out why, and perhaps attempt to fix it
> rather than doing it here.
is it more appropriate to call of_platform_device_create ?

--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -24,6 +24,7 @@
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/platform_device.h>
+#include <linux/of_platform.h>

 struct gen_pci;

@@ -466,7 +467,7 @@ static int gen_pci_probe(struct platform_device *pdev)
        of_pci_check_probe_only();

        of_id = of_match_node(gen_pci_of_match, np);
-       set_dev_node(dev, of_node_to_nid(np));
+       of_platform_device_create(np, NULL, NULL);
        pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
        if (!pci)
                return -ENOMEM;

>
>
>
>> +       pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
>> +       if (!pci)
>> +               return -ENOMEM;
>> +
>>         pci->cfg.ops = (struct gen_pci_cfg_bus_ops *)of_id->data;
>>         pci->host.dev.parent = dev;
>>         INIT_LIST_HEAD(&pci->host.windows);
>>
>
thanks
Ganapat
