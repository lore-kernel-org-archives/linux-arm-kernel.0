From: Yisen.zhuang@huawei.com (Yisen Zhuang)
Date: Wed, 22 Jun 2016 09:43:49 +0800
Subject: [PATCH net-next 10/19] net: hns: bugfix about pfc pause frame
 statistics
In-Reply-To: <1466505178.30123.201.camel@linux.intel.com>
References: <1466481399-70080-1-git-send-email-Yisen.Zhuang@huawei.com>
 <1466481399-70080-11-git-send-email-Yisen.Zhuang@huawei.com>
 <1466505178.30123.201.camel@linux.intel.com>
Message-ID: <5769ED55.3000408@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2016/6/21 18:32, Andy Shevchenko ??:
> On Tue, 2016-06-21 at 11:56 +0800, Yisen Zhuang wrote:
>> From: Daode Huang <huangdaode@hisilicon.com>
>>
>> For SoC hip06, PFC pause handled in dsaf, while hip05 in XGMAC,
>> so change the statistics of pfc pause in dsaf and remove the old
>> pfc pause frame statistics.
>>
> 
> 
>> +static char *hns_dsaf_get_node_stats_strings(char *data, int node,
>> +					     struct dsaf_device
>> *dsaf_dev)
>>  {
>>  	char *buff = data;
>> +	int i;
>> +	bool is_ver1 = AE_IS_VER1(dsaf_dev->dsaf_ver);
>>  
>>  	snprintf(buff, ETH_GSTRING_LEN, "innod%d_pad_drop_pkts",
>> node);
>>  	buff = buff + ETH_GSTRING_LEN;
>> @@ -2502,6 +2530,18 @@ static char
>> *hns_dsaf_get_node_stats_strings(char *data, int node)
>>  	buff = buff + ETH_GSTRING_LEN;
>>  	snprintf(buff, ETH_GSTRING_LEN, "innod%d_stp_drop_pkts",
>> node);
>>  	buff = buff + ETH_GSTRING_LEN;
>> +	if ((node < DSAF_SERVICE_NW_NUM) && (!is_ver1)) {
> 
> Redundant parens.
> 
>> +		for (i = 0; i < DSAF_PRIO_NR; i++) {
>> +			snprintf(buff, ETH_GSTRING_LEN,
>> +				 "inod%d_pfc_prio%d_pkts", node, i);
>> +			buff = buff + ETH_GSTRING_LEN;
> 
> buff += ...
> 
>> +		}
>> +		for (i = 0; i < DSAF_PRIO_NR; i++) {
>> +			snprintf(buff, ETH_GSTRING_LEN,
>> +				 "onod%d_pfc_prio%d_pkts", node, i);
>> +			buff = buff + ETH_GSTRING_LEN;
> 
> Ditto.
> 
>>  {
>>  	u64 *p = data;
>> +	int i;
>>  	struct dsaf_hw_stats *hw_stats = &ddev->hw_stats[node_num];
>> +	bool is_ver1 = AE_IS_VER1(ddev->dsaf_ver);
>>  
>>  	p[0] = hw_stats->pad_drop;
>>  	p[1] = hw_stats->man_pkts;
>> @@ -2527,8 +2569,16 @@ static u64 *hns_dsaf_get_node_stats(struct
>> dsaf_device *ddev, u64 *data,
>>  	p[10] = hw_stats->local_addr_false;
>>  	p[11] = hw_stats->vlan_drop;
>>  	p[12] = hw_stats->stp_drop;
>> -	p[13] = hw_stats->tx_pkts;
>> +	if ((node_num < DSAF_SERVICE_NW_NUM) && (!is_ver1)) {
>> +		for (i = 0; i < DSAF_PRIO_NR; i++) {
>> +			p[13 + i] = hw_stats->rx_pfc[i];
>> +			p[13 + i + DSAF_PRIO_NR] = hw_stats-
>>> tx_pfc[i];
>> +		}
> 
> Two different approaches how to assign data. Above uses 2 for-loops,
> here you put everything to one.

Above cann't be merged to 1 for-loop, because lenght of the string is unknowable.

And here we put everything to one to reduce codes.

I will generate a new patch to fix other comments.

Thanks,

Yisen

> 
>> +		p[29] = hw_stats->tx_pkts;
>> +		return &p[30];
>> +	}
>>  
>> +	p[13] = hw_stats->tx_pkts;
>>  	return &p[14];
>>  }
> 
