From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 31 Mar 2016 16:58:27 +0100
Subject: [RFC PATCH 1/3] libahci: save port map for forced port map
In-Reply-To: <20160330185706.GQ7822@mtj.duckdns.org>
References: <1459257075-21393-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1459257075-21393-2-git-send-email-srinivas.kandagatla@linaro.org>
 <20160330185706.GQ7822@mtj.duckdns.org>
Message-ID: <56FD4923.3090209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30/03/16 19:57, Tejun Heo wrote:
> Hello,
>
> On Tue, Mar 29, 2016 at 02:11:13PM +0100, Srinivas Kandagatla wrote:
>> In usecases where force_port_map is used saved_port_map is never set,
>> resulting in not programming the PORTS_IMPL register as part of intial
>> config. This patch fixes this by setting it to port_map even in case
>> where force_port_map is used, making it more inline with other parts of
>> the code.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/ata/libahci.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
>> index 3982054..a5d7c1c 100644
>> --- a/drivers/ata/libahci.c
>> +++ b/drivers/ata/libahci.c
>> @@ -507,6 +507,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>>   		dev_info(dev, "forcing port_map 0x%x -> 0x%x\n",
>>   			 port_map, hpriv->force_port_map);
>>   		port_map = hpriv->force_port_map;
>> +		hpriv->saved_port_map = port_map;
>
> So, the only change it'd cause is making the driver write the forced
> value to the PI register.  Does that make sense?

Yes, that is the intention, I guess, This was done exactly in case where 
the port number was fabricated too.

Without this I could not get the sata working on my board with forced 
port map option.

--srini


>
> Thanks.
>
