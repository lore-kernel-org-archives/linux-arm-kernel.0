From: james.morse@arm.com (James Morse)
Date: Fri, 05 Jan 2018 18:28:29 +0000
Subject: [PATCH v5 04/13] arm64: kernel: Survive corrected RAS errors
 notified by SError
In-Reply-To: <43942acd-f6ff-ec58-aafb-a6f3ba40fab9@huawei.com>
References: <20171215155101.23505-1-james.morse@arm.com>
 <20171215155101.23505-5-james.morse@arm.com>
 <43942acd-f6ff-ec58-aafb-a6f3ba40fab9@huawei.com>
Message-ID: <5A4FC3CD.3030809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi gengdongjiu,

On 16/12/17 02:53, gengdongjiu wrote:
> 
> On 2017/12/15 23:50, James Morse wrote:
>> +asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
>> +{
>> +	nmi_enter();
> 
>         How about firstly let APEI kernel driver to handle it by adding patch[1]? if the handling is successful, do_serror() direct return;
>         Otherwise continue check the ESR value, for example:
> 	if (!ghes_notify_sei())
> 		return;

This is where I think we will end up. Adding that could should be part of a
future firmware-first series.
We can't do it until APEI can share its in_nmi() path with multiple users. (what
happens if we take an SError while handling an NOTIFY_SEA).

I still haven't managed to get the RFC of what I think is required out.
(I need this for SDEI too),


>> +
>> +	/* non-RAS errors are not containable */
>> +	if (!arm64_is_ras_serror(esr) || arm64_is_fatal_ras_serror(regs, esr))
>> +		arm64_serror_panic(regs, esr);
>>  
>> -	panic("Asynchronous SError Interrupt");
>> +	nmi_exit();
>>  }


Thanks,

James
