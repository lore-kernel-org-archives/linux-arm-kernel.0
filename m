From: ian.molton@codethink.co.uk (Ian Molton)
Date: Mon, 30 Jul 2012 17:32:39 +0100
Subject: [PATCH 3/6] mv643xx.c: Add basic device tree support.
In-Reply-To: <CANTYSESY0A7LaKpqUOjyR42e72Rw_6yn9fvarVFUWWJxw43Jcw@mail.gmail.com>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-4-git-send-email-ian.molton@codethink.co.uk>
 <CANTYSESY0A7LaKpqUOjyR42e72Rw_6yn9fvarVFUWWJxw43Jcw@mail.gmail.com>
Message-ID: <5016B727.2030909@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/07/12 17:19, Amar Nath wrote:
> Hi Ian,
>
> On Mon, Jul 30, 2012 at 8:45 PM, Ian Molton <ian.molton@codethink.co.uk>wrote:
>
>> -       pd = pdev->dev.platform_data;
>> +       if (pdev->dev.of_node) {
>> +               struct device_node *np = NULL;
>> +
>> +               /* when all users of this driver use FDT, we can remove
>> this */
>> +               pd = kzalloc(sizeof(*pd), GFP_ATOMIC);
>> +               if (!pd) {
>> +                       dev_dbg(&pdev->dev, "Could not allocate platform
>> data\n");
>> +                       return -ENOMEM;
>> +               }
>> +
>> +               of_property_read_u32(pdev->dev.of_node,
>> +                       "port_number", &pd->port_number);
>> +               of_property_read_u32(pdev->dev.of_node,
>> +                       "phy_addr", &pd->phy_addr);
>> +               np = of_parse_phandle(pdev->dev.of_node, "mdio", 0);
>> +               if (np) {
>> +                       pd->shared = of_find_device_by_node(np);
>> +               } else {
>> +                       kfree(pd);
>> +                       return -ENODEV;
>> +               }
>> +       } else {
>> +               pd = pdev->dev.platform_data;
>> +       }
>> +
>>         if (pd == NULL) {
>>                 dev_err(&pdev->dev, "no mv643xx_eth_platform_data\n");
>>                 return -ENODEV;
>>
> Can this check for pd be moved in the else part above as well, as for the
> pd allocation with kzalloc,
> we have already made a check for memory allocation failure?

Yes, Folded in for v2.

-Ian
