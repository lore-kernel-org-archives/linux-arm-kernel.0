From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 26 Nov 2013 10:05:40 -0500
Subject: [PATCH 07/12] memory: davinci-aemif: introduce AEMIF driver
In-Reply-To: <52944BD3.90105@ti.com>
References: <1384187188-5776-1-git-send-email-ivan.khoronzhuk@ti.com>,
 <1384187188-5776-8-git-send-email-ivan.khoronzhuk@ti.com>
 <4F5844B3A985794BA902E12C070812375F8D2E@DNCE04.ent.ti.com>
 <52944BD3.90105@ti.com>
Message-ID: <5294B8C4.6040803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 November 2013 02:20 AM, Sekhar Nori wrote:
> On Monday 11 November 2013 10:36 PM, Khoronzhuk, Ivan wrote:
>> Add new AEMIF driver for EMIF16 davinci controller. The EMIF16 module
>> is intended to provide a glue-less interface to a variety of
>> asynchronous memory devices like ASRA M, NOR and NAND memory. A total
>> of 256M bytes of any of these memories can be accessed at any given
>> time via four chip selects with 64M byte access per chip select.
>>
>> Synchronous memories such as DDR1 SD RAM, SDR SDRAM and Mobile SDR
>> are not supported.
>>
>> See http://www.ti.com/lit/ug/sprugz3a/sprugz3a.pdf
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>> ---

[...]

>> +static int davinci_aemif_probe(struct platform_device *pdev)
>> +{
>> +       int ret  = -ENODEV, i;
>> +       struct resource *res;
>> +       struct device *dev = &pdev->dev;
>> +       struct device_node *np = dev->of_node;
>> +
>> +       if (np == NULL)
>> +               return 0;
>> +
>> +       if (aemif) {
>> +               dev_err(dev, "davinci_aemif driver is in use currently\n");
>> +               return -EBUSY;
>> +       }
> 
> Why expressly prevent multiple AEMIF devices? Its entirely conceivable
> to have two memories like NAND and NOR flash connect to two different
> AEMIF interfaces.
> 
Ivan wanted me to clarify the Keystone hardware which supports
1 instance of controller with 4 CS. That allows already four
devices to be connected. Currently NAND and NOR are connected on it
and two more slots are free.

Since driver support what hardware is, lets not build a driver for
hardware which don't exist. And if at all such a support would be
needed in future, we can always add it.

Regards,
Santosh
