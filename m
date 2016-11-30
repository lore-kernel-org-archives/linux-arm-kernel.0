From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Wed, 30 Nov 2016 09:13:44 -0800
Subject: [PATCH v2] soc: ti: qmss: fix the case when !SMP
In-Reply-To: <d26f37e6-657f-ff42-2d9d-343fa47c2e5d@ti.com>
References: <20161130165351.1154-1-grygorii.strashko@ti.com>
 <d26f37e6-657f-ff42-2d9d-343fa47c2e5d@ti.com>
Message-ID: <92af0586-7deb-9e94-a0e7-377337ebfb9e@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anrd,

Can you apply this to your non critical fixes queue ?

On 11/30/2016 9:09 AM, Grygorii Strashko wrote:
> + Santosh Shilimkar <santosh.shilimkar@oracle.com>
>
> On 11/30/2016 10:53 AM, Grygorii Strashko wrote:
>> The irq_set_affinity_hint() will always fail when !SMP and
>> Networking will fail on Keystone 2 devices in this case.
>> Hence, fix by ignoring IRQ affinity settings when !SMP.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

>>  drivers/soc/ti/knav_qmss_queue.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/ti/knav_qmss_queue.c
>> b/drivers/soc/ti/knav_qmss_queue.c
>> index b73e353..eacad57 100644
>> --- a/drivers/soc/ti/knav_qmss_queue.c
>> +++ b/drivers/soc/ti/knav_qmss_queue.c
>> @@ -1228,7 +1228,7 @@ static int knav_setup_queue_range(struct
>> knav_device *kdev,
>>
>>          range->num_irqs++;
>>
>> -        if (oirq.args_count == 3)
>> +        if (IS_ENABLED(CONFIG_SMP) && oirq.args_count == 3)
>>              range->irqs[i].cpu_map =
>>                  (oirq.args[2] & 0x0000ff00) >> 8;
>>      }
>>
>
