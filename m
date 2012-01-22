From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 22 Jan 2012 08:46:48 -0700
Subject: [PATCH 3/3] ARM: OMAP: I2C: fix compilation when !CONFIG_OF
In-Reply-To: <4F1C2DEB.50209@gmail.com>
References: <20120122105942.6508.82335.stgit@dusk>
 <20120122110232.6508.68451.stgit@dusk> <4F1C2DEB.50209@gmail.com>
Message-ID: <CACxGe6vmPLi0e0CmJtKhFe9dHHt5mgKQ_A1NPyFSJvqLbk7v=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2012 at 8:40 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 01/22/2012 05:02 AM, Paul Walmsley wrote:
>> Commit 6145197be6cc0583fa1a2f4ec1079d366137061e ("i2c: OMAP: Add DT
>> support for i2c controller") breaks compilation when CONFIG_OF is not
>> defined:
>>
>> ? CC ? ? ?drivers/i2c/busses/i2c-omap.o
>> drivers/i2c/busses/i2c-omap.c: In function 'omap_i2c_probe':
>> drivers/i2c/busses/i2c-omap.c:1021:26: error: 'omap_i2c_of_match' undeclared (first use in this function)
>> drivers/i2c/busses/i2c-omap.c:1021:26: note: each undeclared identifier is reported only once for each function it appears in
>>
>> Fix this by avoiding of_*() functions when !CONFIG_OF.
>>
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> ---
>> ?drivers/i2c/busses/i2c-omap.c | ? ?4 +++-
>> ?1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index f713eac..1008e96 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -989,7 +989,7 @@ omap_i2c_probe(struct platform_device *pdev)
>> ? ? ? struct resource ? ? ? ? *mem, *irq, *ioarea;
>> ? ? ? struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
>> ? ? ? struct device_node ? ? ?*node = pdev->dev.of_node;
>> - ? ? const struct of_device_id *match;
>> + ? ? const struct of_device_id *match = NULL;
>> ? ? ? irq_handler_t isr;
>> ? ? ? int r;
>>
>> @@ -1018,7 +1018,9 @@ omap_i2c_probe(struct platform_device *pdev)
>> ? ? ? ? ? ? ? goto err_release_region;
>> ? ? ? }
>>
>> +#ifdef CONFIG_OF
>> ? ? ? match = of_match_device(omap_i2c_of_match, &pdev->dev);
>> +#endif
>
> How about an empty function for of_match_device instead to avoid the ifdef.

That already exists.  The problem is the undefined omap_i2c_of_match
table reference.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
