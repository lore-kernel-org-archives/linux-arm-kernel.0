From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Fri, 13 Apr 2018 07:32:08 +0000
Subject: [PATCH 15/17] media: st_rc: Don't stay on an IRQ handler forever
In-Reply-To: <20180412222132.z7g5enhin2uodbk7@gofer.mess.org>
References: <d20ab7176b2af82d6b679211edb5f151629d4033.1523546545.git.mchehab@s-opensource.com>
 <16b1993cde965edc096f0833091002dd05d4da7f.1523546545.git.mchehab@s-opensource.com>
 <20180412222132.z7g5enhin2uodbk7@gofer.mess.org>
Message-ID: <eb6ed8db-2805-63f2-acb0-a262b07c76b7@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro, Sean

On 04/13/2018 12:21 AM, Sean Young wrote:
> On Thu, Apr 12, 2018 at 11:24:07AM -0400, Mauro Carvalho Chehab wrote:
>> As warned by smatch:
>> 	drivers/media/rc/st_rc.c:110 st_rc_rx_interrupt() warn: this loop depends on readl() succeeding
>>
>> If something goes wrong at readl(), the logic will stay there
>> inside an IRQ code forever. This is not the nicest thing to
>> do :-)
>>
>> So, add a timeout there, preventing staying inside the IRQ
>> for more than 10ms.
> 
> If we knew how large the fifo was, then we could limit the loop to that many
> iterations (maybe a few extra in case IR arrives while we a reading, but
> IR is much slower than a cpu executing this loop of course).
> 
> Patrice is something you could help with?

Unfortunately, i will not be able to give you an answer regarding the Rx 
fifo size.

For information, currently, none of upstreamed ST boards are using this 
driver. It was used in the past internally and by customers.

Regards

> 
> Thanks
> 
> Sean
> 
>>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
>> ---
>>   drivers/media/rc/st_rc.c | 16 ++++++++++------
>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/media/rc/st_rc.c b/drivers/media/rc/st_rc.c
>> index d2efd7b2c3bc..c855b177103c 100644
>> --- a/drivers/media/rc/st_rc.c
>> +++ b/drivers/media/rc/st_rc.c
>> @@ -96,19 +96,24 @@ static void st_rc_send_lirc_timeout(struct rc_dev *rdev)
>>   
>>   static irqreturn_t st_rc_rx_interrupt(int irq, void *data)
>>   {
>> +	unsigned long timeout;
>>   	unsigned int symbol, mark = 0;
>>   	struct st_rc_device *dev = data;
>>   	int last_symbol = 0;
>> -	u32 status;
>> +	u32 status, int_status;
>>   	DEFINE_IR_RAW_EVENT(ev);
>>   
>>   	if (dev->irq_wake)
>>   		pm_wakeup_event(dev->dev, 0);
>>   
>> -	status  = readl(dev->rx_base + IRB_RX_STATUS);
>> +	/* FIXME: is 10ms good enough ? */
>> +	timeout = jiffies +  msecs_to_jiffies(10);
>> +	do {
>> +		status  = readl(dev->rx_base + IRB_RX_STATUS);
>> +		if (!(status & (IRB_FIFO_NOT_EMPTY | IRB_OVERFLOW)))
>> +			break;
>>   
>> -	while (status & (IRB_FIFO_NOT_EMPTY | IRB_OVERFLOW)) {
>> -		u32 int_status = readl(dev->rx_base + IRB_RX_INT_STATUS);
>> +		int_status = readl(dev->rx_base + IRB_RX_INT_STATUS);
>>   		if (unlikely(int_status & IRB_RX_OVERRUN_INT)) {
>>   			/* discard the entire collection in case of errors!  */
>>   			ir_raw_event_reset(dev->rdev);
>> @@ -148,8 +153,7 @@ static irqreturn_t st_rc_rx_interrupt(int irq, void *data)
>>   
>>   		}
>>   		last_symbol = 0;
>> -		status  = readl(dev->rx_base + IRB_RX_STATUS);
>> -	}
>> +	} while (time_is_after_jiffies(timeout));
>>   
>>   	writel(IRB_RX_INTS, dev->rx_base + IRB_RX_INT_CLEAR);
>>   
>> -- 
>> 2.14.3
