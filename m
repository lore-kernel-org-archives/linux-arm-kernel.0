From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 10 Nov 2014 18:07:48 -0800
Subject: [PATCH] tty: serial: msm_serial: Use DT aliases
In-Reply-To: <54616CB3.5000405@gmail.com>
References: <1414024381-12204-1-git-send-email-sboyd@codeaurora.org>
 <CAMAWPa_f1K1qUG_UTmM0w8Sz8wed7+CQkK9tc8t1W=CTJvdjyw@mail.gmail.com>
 <5461150B.2010907@codeaurora.org> <54616CB3.5000405@gmail.com>
Message-ID: <54616F74.5010408@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2014 05:56 PM, Frank Rowand wrote:
> On 11/10/2014 11:42 AM, Stephen Boyd wrote:
>> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
>> index 09364dd8cf3a..d1bc6b6cbc70 100644
>> --- a/drivers/tty/serial/msm_serial.c
>> +++ b/drivers/tty/serial/msm_serial.c
>> @@ -1046,14 +1046,14 @@ static int msm_serial_probe(struct platform_device *pdev)
>>  	const struct of_device_id *id;
>>  	int irq, line;
>>  
>> -	if (pdev->id == -1)
>> -		pdev->id = atomic_inc_return(&msm_uart_next_id) - 1;
>> -
>>  	if (pdev->dev.of_node)
>>  		line = of_alias_get_id(pdev->dev.of_node, "serial");
>>  	else
>>  		line = pdev->id;
>>  
>> +	if (line < 0)
>> +		line = atomic_inc_return(&msm_uart_next_id) - 1;
>> +
>>  	if (unlikely(line < 0 || line >= UART_NR))
> Then this original check for "line < 0" can also be removed.
>
>

Well this matches what was there before. It would do atomic_inc_return
if the line was negative and then still check for a negative value. I
don't mind removing it though. Perhaps we should use an ida?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
