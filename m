From: saeed@marvell.com (Saeed Bishara)
Date: Thu, 21 Oct 2010 10:11:24 +0200
Subject: [PATCH 1/2] [ARM] Kirkwood: enhance TLCK detection
In-Reply-To: <20101021075318.GB22363@mail.wantstofly.org>
References: <20101020085720.GA12979@mail.wantstofly.org>
	<1287647127-1434-1-git-send-email-simon@sequanux.org>
	<20101021075318.GB22363@mail.wantstofly.org>
Message-ID: <FCBE654890C0334289D0AD3AF4EF009FD18F0B3FA2@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

>-----Original Message-----
>From: Lennert Buytenhek [mailto:buytenh at wantstofly.org] 
>Sent: Thursday, October 21, 2010 9:53 AM
>To: Simon Guinot
>Cc: Nicolas Pitre; linux-arm-kernel at lists.infradead.org; 
>Benoit Canet; Saeed Bishara; Simon Guinot
>Subject: Re: [PATCH 1/2] [ARM] Kirkwood: enhance TLCK detection
>
>In the patch title:
>
>> [PATCH 1/2] [ARM] Kirkwood: enhance TLCK detection
>
>s/TLCK/TCLK/
>
>
>
>On Thu, Oct 21, 2010 at 09:45:26AM +0200, Simon Guinot wrote:
>
>> From: Simon Guinot <sguinot@lacie.com>
>> 
>> According to the Marvell LSP, the Sample at Reset regiter 
>bit 21 can be
>> used to detect TCLK on 6281 and 6282 devices.
>> 
>> This patch has only been tested on LaCie boards.
>>
>> [snip]
>>  
>> -	if ((dev == MV88F6281_DEV_ID && (rev == MV88F6281_REV_A0 ||
>> -					rev == MV88F6281_REV_A1)) ||
>> -	    (dev == MV88F6282_DEV_ID))
>> -		return 200000000;
>> +	if (dev == MV88F6281_DEV_ID || dev == MV88F6282_DEV_ID)
>> +		if ((readl(SAMPLE_AT_RESET) >> 21 & 1) == 0)
>> +			return 200000000;
>>  
>>  	return 166666667;
>>  }
>
>Can we not just make this:
>
>	if ((readl(SAMPLE_AT_RESET) >> 21 & 1) == 0)
>		return 200000000;
>	else
>		return 166666667;
>
>(I don't have the necessary docs, Saeed might have to answer this one.)
Lennert, the docs and our reference code shows that the original code of Simor is correct,s o I suggest to do :
	if ((dev == MV88F6281_DEV_ID || dev == MV88F6282_DEV_ID) && 
		((readl(SAMPLE_AT_RESET) & BIT(21)) == 0))
		return 200000000;
	else
		return 166666667;
>
>
>thanks,
>Lennert
>
