From: angus.clark@st.com (Angus Clark)
Date: Fri, 13 Dec 2013 14:35:00 +0000
Subject: [PATCH v3 04/36] mtd: st_spi_fsm: Supply framework for device
 requests
In-Reply-To: <20131210201943.GC27149@ld-irv-0074.broadcom.com>
References: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
 <1385727565-25794-5-git-send-email-lee.jones@linaro.org>
 <20131210201943.GC27149@ld-irv-0074.broadcom.com>
Message-ID: <52AB1B14.6030905@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2013 08:19 PM, Brian Norris wrote:
> On Fri, Nov 29, 2013 at 12:18:53PM +0000, Lee Jones wrote:
>> --- a/drivers/mtd/devices/st_spi_fsm.c
>> +static void stfsm_wait_seq(struct stfsm *fsm)
>> +{
>> +	unsigned long timeo = jiffies + HZ;
>> +
>> +	while (time_before(jiffies, timeo)) {
>> +		if (stfsm_is_idle(fsm))
>> +			return;
>> +
>> +		cond_resched();
>> +	}
>> +
>> +	dev_err(fsm->dev, "timeout on sequence completion\n");
> 
> I believe the timeout logic is incorrect. What if we wait a "long time"
> to call stfsm_wait_seq() (due to scheduling, or otherwise)? Then the
> while loop might not even run once (time_before(x, y) is false). Or what
> if cond_resched() waits for a long time...
> 
> So you need an extra check of stfsm_is_idle() after the while loop,
> before you declare a timeout.

Yes, good catch, this needs to updated.

Cheers,

Angus
