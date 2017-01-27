From: davem@davemloft.net (David Miller)
Date: Fri, 27 Jan 2017 11:26:00 -0500 (EST)
Subject: [PATCH] Net: ethernet: mediatek - Fix possible NULL derefrence.
In-Reply-To: <20170127124449.GB13611@Red>
References: <CGME20170127111947epcas2p14f5ea86f0069142be02339754fda4a55@epcas2p1.samsung.com>
 <1485515980-3814-1-git-send-email-shailendra.v@samsung.com>
 <20170127124449.GB13611@Red>
Message-ID: <20170127.112600.2185367941561923892.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Fri, 27 Jan 2017 13:44:49 +0100

> On Fri, Jan 27, 2017 at 04:49:40PM +0530, Shailendra Verma wrote:
>> of_match_device could return NULL, and so can cause a NULL
>> pointer dereference later.
>> 
>> Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
>> ---
>>  drivers/net/ethernet/mediatek/mtk_eth_soc.c |    4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
>> index 4a62ffd..4495b7b 100644
>> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
>> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
>> @@ -2369,6 +2369,10 @@ static int mtk_probe(struct platform_device *pdev)
>>  	int i;
>>  
>>  	match = of_match_device(of_mtk_match, &pdev->dev);
>> +	if (!match) {
>> +		dev_err(&pdev->dev, "Error: No device match found\n");
>> +		return -ENODEV;
>> +	}
>>  	soc = (struct mtk_soc_data *)match->data;
>>  
>>  	eth = devm_kzalloc(&pdev->dev, sizeof(*eth), GFP_KERNEL);
>> -- 
> 
> Hello
> 
> You could use of_device_get_match_data() and simplifiy code

Agreed.
