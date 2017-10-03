From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 3 Oct 2017 17:18:57 +0100
Subject: [PATCH 3/5] firmware: arm_scpi: pre-populate dvfs info in
 scpi_probe
In-Reply-To: <ffb9c571-edd3-7ea0-ecf6-f72c2ddd9fc1@gmail.com>
References: <c245d2fa-2aa0-fa40-21a7-318e8db3b763@gmail.com>
 <c8c0ff86-de14-f157-68e0-9df005defffa@gmail.com>
 <d6578a58-b7ab-9770-d78d-1971d1e702d4@arm.com>
 <db4476f4-df96-6ce5-ca5f-95141364fa62@gmail.com>
 <0e5959a7-6826-1909-1509-f6627a9688ed@arm.com>
 <ffb9c571-edd3-7ea0-ecf6-f72c2ddd9fc1@gmail.com>
Message-ID: <e34ca682-aa86-4057-cf29-172ff5764d07@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/10/17 17:00, Heiner Kallweit wrote:
> Am 03.10.2017 um 12:57 schrieb Sudeep Holla:
>>
>>
>> On 02/10/17 23:07, Heiner Kallweit wrote:
>>> Am 02.10.2017 um 13:17 schrieb Sudeep Holla:
>>>>
>>>>
>>>> On 29/09/17 22:44, Heiner Kallweit wrote:
>>>>> Pre-populating the dvfs info data in scpi_probe allows to make 
>>>>> all memory allocations device-managed. This helps to simplify 
>>>>> scpi_remove and eventually to get rid of scpi_remove completely.
>>>>>
>>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>
>> [...]
>>
>>>> Does it make sense to continue to complete all MAX_DVFS_DOMAINS ? 
>>>> Just wondering if there will be any firmware that returns errors 
>>>> for few domains(e.g. not supported in initial versions of 
>>>> firmware). I don't want to stop probing due to that. Let me know 
>>>> what you think.
>>>>
>>> The (legacy) SCPI firmware on my system seems to ignore the domain
>>> in CMD_GET_DVFS_INFO. It returns the same dvfs info independent of
>>> the domain parameter. So indeed prepopulating may not be the best
>>> idea.
>>>
>>
>> I can't follow that. Does the behavior change probe time vs runtime ?
>> I am fine with probe time populate, just that we can't stop or propagate
>> any error as it fails to probe other dependent drivers which may work
>> fine without DVFS(e.g. clocks, sensors and power domains)
>>
>>> Still we need to do something in the remove callback to deal with the
>>> scenario you describe (error for few domains).
>>
>> devm_* APIs will take care of freeing DVFS domain info, so what else
>> needs to be done ? I just noticed devm_kfree(NULL) can produce WARN_ON
>> splat, is that what you are referring ?
>>
>>>
>>> Remove does for (i = 0; i < MAX_DVFS_DOMAINS && info->dvfs[i]; i++) {
>>> and therefore stops at the first unpopulated domain and doesn't free
>>> the memory for further populated domains. I'll provide a patch for
>>> it.
>>>
>>
>> Does that mean you are re-introducing scpi_remove ? I kind of liked
>> removing it.
>>
> Sorry for the confusion. Then I'll go with the original approach and
> just make sure that errors whilst populating dvfs info are ignored.
> 

Indeed.

If you are fine with the below fixup, then I can add it myself. Let me know.

Regards,
Sudeep

--
drivers/firmware/arm_scpi.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index b0d2d21e6805..f713a64c1052 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -685,17 +685,12 @@ static int scpi_dvfs_populate_info(struct device
*dev, u8 domain)
 	return 0;
 }

-static int scpi_dvfs_populate(struct device *dev)
+static void scpi_dvfs_populate(struct device *dev)
 {
-	int ret, i;
-
-	for (i = 0; i < MAX_DVFS_DOMAINS; i++) {
-		ret = scpi_dvfs_populate_info(dev, i);
-		if (ret)
-			break;
-	}
+	int domain;

-	return i > 0 ? 0 : ret;
+	for (domain = 0; domain < MAX_DVFS_DOMAINS; domain++)
+		scpi_dvfs_populate_info(dev, domain);
 }

 static int scpi_dev_domain_id(struct device *dev)
@@ -1027,9 +1022,7 @@ static int scpi_probe(struct platform_device *pdev)
 		return ret;
 	}

-	ret = scpi_dvfs_populate(dev);
-	if (ret)
-		return ret;
+	scpi_dvfs_populate(dev);

 	_dev_info(dev, "SCP Protocol %d.%d Firmware %d.%d.%d version\n",
 		  PROTOCOL_REV_MAJOR(scpi_info->protocol_version),
