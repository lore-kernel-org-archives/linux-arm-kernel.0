From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Wed, 17 May 2017 08:43:34 +0300
Subject: [V2, 2/6] tty: serial: lpuart: add little endian 32 bit register
 support
In-Reply-To: <20170517033139.GB9913@b29396-OptiPlex-7040>
References: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
 <b4a2ed13-c71f-c973-3b09-b632e083a88b@cogentembedded.com>
 <20170517033139.GB9913@b29396-OptiPlex-7040>
Message-ID: <48819894-4943-7d14-ccf8-83cfd2195c9a@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> @@ -2000,6 +2007,7 @@ static int lpuart_probe(struct platform_device *pdev)
>>>  	}
>>>  	sport->port.line = ret;
>>>  	sport->lpuart32 = sdata->is_32;
>>> +	lpuart_is_be = sdata->is_be;
>>
>> Setting a global variable in per-device routine is quite bad design.
>>
> 
> There is a reason for that we don't want to change the exist 
> lpuart32_read[write] API which is widely used in driver.
> Making a global lpuart_is_be is the simplest way to do it.
> 
> Any strong blocking reason?

Code should be consistent.

There is no good reason to have sport->lpuart32 inside sport, but
lpuart_is_be outside of it. Both these values describe properties of
particular device, and thus should be in per-device structure.

If that implies adding sport arg to lpuart32_(read|write), just do that.
