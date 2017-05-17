From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Wed, 17 May 2017 08:50:39 +0300
Subject: [V2, 2/6] tty: serial: lpuart: add little endian 32 bit register
 support
In-Reply-To: <20170517054356.GE9913@b29396-OptiPlex-7040>
References: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
 <fb9fe0cd-5ca7-74e6-33dc-7638e205b2e3@cogentembedded.com>
 <20170517033927.GC9913@b29396-OptiPlex-7040>
 <8f4cf45e-45ab-e6e6-d95c-f3d4243697f4@cogentembedded.com>
 <20170517054356.GE9913@b29396-OptiPlex-7040>
Message-ID: <f096009a-9bcd-e575-2c81-49d08f99fc44@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>>  static u32 lpuart32_read(void __iomem *addr)
>>>>>  {
>>>>> -	return ioread32be(addr);
>>>>> +	return lpuart_is_be ? ioread32be(addr) : readl(addr);
>>>>>  }
>>>>>  
>>>>>  static void lpuart32_write(u32 val, void __iomem *addr)
>>>>>  {
>>>>> -	iowrite32be(val, addr);
>>>>> +	if (lpuart_is_be)
>>>>> +		iowrite32be(val, addr);
>>>>> +	else
>>>>> +		writel(val, addr);
>>>>>  }
>>>>
>>>> What if this is ever executed on big endian system?
>>>>
>>>
>>> Sorry, not catching the point...
>>>
>>> What issues will meet?
>>
>> Isn't writel() in host endian?
> 
> On big endian systems, it is supposed to run iowrite32be.

Your code states, "force BE if lpuart_is_be, don't care otherwise".
This semantics looks questionable for code reviewer.
If driver handles endian, should't it be explicit in both cases?
And if indeed driver means handling BE explicitly, but don't caring
otherwise, maybe variable name should suggest that (i.e. "force_be")?

Although driver maintainer could think differently. I won't insist on this.

Nikita
