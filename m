From: computersforpeace@gmail.com (Brian Norris)
Date: Sat, 24 Aug 2013 00:11:08 -0700
Subject: [PATCH V1 4/5] spi: Add Freescale QuadSpi driver
In-Reply-To: <20130823164442.GA30359@sirena.org.uk>
References: <1376885403-12156-1-git-send-email-b32955@freescale.com>
 <1376885403-12156-5-git-send-email-b32955@freescale.com>
 <20130823164442.GA30359@sirena.org.uk>
Message-ID: <52185C8C.3090605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2013 09:44 AM, Mark Brown wrote:
> On Mon, Aug 19, 2013 at 12:10:02PM +0800, Huang Shijie wrote:
>> +static int fsl_qspi_wait_till_ready(struct fsl_qspi *q)
>> +{
>> +	unsigned long deadline;
>> +	u32 sr;
>> +
>> +	deadline = jiffies + msecs_to_jiffies(40000);
>> +
>> +	do {
>> +		if ((sr = fsl_qspi_read_sr(q)) < 0)
>> +			break;
>> +		else if (!(sr & SR_WIP))
>> +			return 0;
>> +
>> +		cond_resched();
>> +
>> +	} while (!time_after_eq(jiffies, deadline));
>> +
>> +	return 1;
>> +}
>
> Return an error code if we time out?

You also need to check that you didn't complete between your last 
fsl_qspi_read_sr() and the time_arter_eq() check. Theoretically, there 
could be a lot of time between them (due to cond_resched(), for 
instance). 40000 milliseconds is also a lot of time, but still...

IOW, add a check before the "return -ESOMETHING", something like this:

if (!(fsl_qspi_read_sr(q) & SR_WIP))
	return 0;

Brian
