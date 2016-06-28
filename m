From: huangdaode@hisilicon.com (Daode Huang)
Date: Tue, 28 Jun 2016 13:41:35 +0800
Subject: [PATCH net-next 6/9] net: hns: normalize two different loop
In-Reply-To: <1467029589.30123.288.camel@linux.intel.com>
References: <1467021255-95900-1-git-send-email-Yisen.Zhuang@huawei.com>
 <1467021255-95900-7-git-send-email-Yisen.Zhuang@huawei.com>
 <1467028161.1847.101.camel@perches.com>
 <1467028835.30123.287.camel@linux.intel.com>
 <1467029338.1847.106.camel@perches.com>
 <1467029589.30123.288.camel@linux.intel.com>
Message-ID: <57720E0F.8090605@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/6/27 20:13, Andy Shevchenko wrote:
> On Mon, 2016-06-27 at 05:08 -0700, Joe Perches wrote:
>> On Mon, 2016-06-27 at 15:00 +0300, Andy Shevchenko wrote:
>>> On Mon, 2016-06-27 at 04:49 -0700, Joe Perches wrote:
>>>> On Mon, 2016-06-27 at 17:54 +0800, Yisen Zhuang wrote:
>>>>> From: Daode Huang <huangdaode@hisilicon.com>
>>>>>
>>>>> There are two approaches to assign data, one does 2 loops,
>>>>> another
>>>>> does 1 loop. This patch normalize the different methods to 1
>>>>> loop.
>>>> []
>>>>> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
>>>>> b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
>>>> []
>>>>> @@ -2567,15 +2567,15 @@ static char
>>>>> *hns_dsaf_get_node_stats_strings(char *data, int node,
>>>>>   	buff += ETH_GSTRING_LEN;
>>>>>   	if (node < DSAF_SERVICE_NW_NUM && !is_ver1) {
>>>>>   		for (i = 0; i < DSAF_PRIO_NR; i++) {
>>>>> -			snprintf(buff, ETH_GSTRING_LEN,
>>>>> -				 "inod%d_pfc_prio%d_pkts",
>>>>> node,
>>>>> i);
>>>>> -			buff += ETH_GSTRING_LEN;
>>>>> -		}
>>>>> -		for (i = 0; i < DSAF_PRIO_NR; i++) {
>>>>> -			snprintf(buff, ETH_GSTRING_LEN,
>>>>> -				 "onod%d_pfc_prio%d_pkts",
>>>>> node,
>>>>> i);
>>>>> +			snprintf(buff + 0 * ETH_GSTRING_LEN *
>>>>> DSAF_PRIO_NR,
>>>>> +				 ETH_GSTRING_LEN,
>>>>> "inod%d_pfc_prio%d_pkts",
>>>>> +				 node, i);
>>>>> +			snprintf(buff + 1 * ETH_GSTRING_LEN *
>>>>> DSAF_PRIO_NR,
>>>>> +				 ETH_GSTRING_LEN,
>>>>> "onod%d_pfc_prio%d_pkts",
>>>>> +				 node, i);
>>>>>   			buff += ETH_GSTRING_LEN;
>>>> This looks odd and likely incorrect.
>>> Why? the idea is to print stats for Rx and Tx at once.
>>>
>>> I hope it was tested.
>> It changes the order of the strings in buff.
> I don't see how.
Hi Andy,
The patch has been tested when sent out.

>> Is a bug fix or a style fix?
>>
>> If it's a bug fix, then it should likely be added
>> to the stable trees.
> I doubt it's a bug fix.

Because the previous patch is accepted in net-next, and this set is
an appendix to the series, in order to avoid merge conflict, we also
send this bug fix to net-next.

thanks.

>
