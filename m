From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Wed, 16 Jan 2013 19:11:21 +0100
Subject: [PATCH 1/5] W1: Add device tree support to MXC onewire master.
In-Reply-To: <20130116163603.GA20855@e106331-lin.cambridge.arm.com>
References: <20130116094821.9660.18278.stgit@localhost>
 <20130116094823.9660.2116.stgit@localhost>
 <20130116163603.GA20855@e106331-lin.cambridge.arm.com>
Message-ID: <50F6ED49.9080306@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/01/13 17:36, Mark Rutland wrote:
> Hi,
>
> This looks nice and simple, I just have a couple of comment.
Thank you
> On Wed, Jan 16, 2013 at 09:48:23AM +0000, Martin Fuzzey wrote:
>> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
>> ---
>>   drivers/w1/masters/mxc_w1.c |    9 ++++++++-
>>   1 files changed, 8 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/w1/masters/mxc_w1.c b/drivers/w1/masters/mxc_w1.c
>> index 708a25f..949e566 100644
>> --- a/drivers/w1/masters/mxc_w1.c
>> +++ b/drivers/w1/masters/mxc_w1.c
>> @@ -186,9 +186,16 @@ static int mxc_w1_remove(struct platform_device *pdev)
>>   	return 0;
>>   }
>>   
>> +static struct of_device_id mxc_w1_dt_ids[] = {
>> +	{ .compatible = "fsl,imx21-owire" },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, mxc_w1_dt_ids);
>> +
>>   static struct platform_driver mxc_w1_driver = {
>>   	.driver = {
>> -		   .name = "mxc_w1",
>> +		.name = "mxc_w1",
>> +		.of_match_table = mxc_w1_dt_ids,
>>   	},
>>   	.probe = mxc_w1_probe,
>>   	.remove = mxc_w1_remove,
>>
> I see there's already a binding for gpio-based w1 -- "w1-gpio". Given this is
> already using the "w1" naming convention in a binding, I think it'd be worth
> using the compatible string "fsl,imx21-w1", for consistency (both with the
> other binding and the driver name).
I don't have any strong opinions on this but the other imx53 bindings
use the names used by Freescale in the hardware documentation hence
the "owire" rather than "w1".

I'm happy to change it if that is the consensus though.

> It's also be worth documenting (in
> Documentation/devicetree/bindings/w1/fsl-imx21-w1, presumably).
Ok, I thought that as the driver doesn't define any properties itself that
this wasn't required. However l see some other drivers do document in this
case.

So I will add a Documentation file.
> When adding bindings, it's also good to Cc devicetree-discuss.
Ok, added to -Cc

Martin
