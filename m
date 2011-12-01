From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Thu, 01 Dec 2011 14:46:11 +0400
Subject: [PATCH] arm: prevent inlining in arxescsi.c causing build failures
In-Reply-To: <20111201080613.GF26618@pengutronix.de>
References: <1322713611-30003-1-git-send-email-paul.gortmaker@windriver.com>
 <20111201080613.GF26618@pengutronix.de>
Message-ID: <4ED75AF3.2090901@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01.12.2011 12:06, Uwe Kleine-K?nig wrote:

>> The following failure is seen in routine coverage builds:

>>    CC [M]  drivers/scsi/arm/arxescsi.o
>> /tmp/cccEyiO7.s: Assembler messages:
>> /tmp/cccEyiO7.s:334: Error: symbol `.loop_1' is already defined
>> /tmp/cccEyiO7.s:337: Error: symbol `.loop_2' is already defined
>> /tmp/cccEyiO7.s:343: Error: symbol `.loop_3' is already defined
>> /tmp/cccEyiO7.s:365: Error: symbol `.loop_1' is already defined
>> /tmp/cccEyiO7.s:368: Error: symbol `.loop_2' is already defined
>> /tmp/cccEyiO7.s:374: Error: symbol `.loop_3' is already defined
>> make[4]: *** [drivers/scsi/arm/arxescsi.o] Error 1

>> It is caused by multiple inline of arxescsi_pseudo_dma_write()
>> which is responsible for the above labels.  Marking the fcn
>> as non-inline fixes the issue.

>> Signed-off-by: Paul Gortmaker<paul.gortmaker@windriver.com>

> Is that a compiler or a code issue? If it's the compiler please fix
> that. If it's the code, then please document why you added the noinline.

> Having said that, "my" compiler compiles drivers/scsi/arm/arxescsi.o
> just fine (using rpc_defconfig on v3.2-rc2).

>> diff --git a/drivers/scsi/arm/arxescsi.c b/drivers/scsi/arm/arxescsi.c
>> index a750aa7..2608a9e 100644
>> --- a/drivers/scsi/arm/arxescsi.c
>> +++ b/drivers/scsi/arm/arxescsi.c
>> @@ -72,7 +72,8 @@ arxescsi_dma_setup(struct Scsi_Host *host, struct scsi_pointer *SCp,
>>   	return fasdma_pseudo;
>>   }
>>
>> -static void arxescsi_pseudo_dma_write(unsigned char *addr, void __iomem *base)
>> +static noinline void
>> +arxescsi_pseudo_dma_write(unsigned char *addr, void __iomem *base)

> Shouldn't this line get some indention?

    No, usually such lines don't get indented.

WBR, Sergei
