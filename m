From: achandran@mvista.com (Arun Chandran)
Date: Fri, 12 Jun 2015 12:28:48 +0530
Subject: [PATCH v1] ARM: zynq: Fix earlyprintk in big endian mode
In-Reply-To: <5579CFCC.60905@xilinx.com>
References: <1433945584-16379-1-git-send-email-achandran@mvista.com>
 <5579CFCC.60905@xilinx.com>
Message-ID: <CAFdej02+PtnRb_s8mxYu2rgAzihEMWekGyDfVGvkmszjf0x1pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 11:43 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 06/10/2015 04:13 PM, Arun Chandran wrote:
>> earlyprintk messages are not appearing on the terminal
>> emulator during a big endian kernel boot. If we
>> byte swap the sending data it comes properly.
>>
>> Signed-off-by: Arun Chandran <achandran@mvista.com>
>> ---
>> ---
>> This can be tested by adding 'early_print("early print test\n");'
>> to setup_arch() in arch/arm/kernel/setup.c
>> ---
>>  arch/arm/include/debug/zynq.S | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/include/debug/zynq.S b/arch/arm/include/debug/zynq.S
>> index bd13ded..0d274fe 100644
>> --- a/arch/arm/include/debug/zynq.S
>> +++ b/arch/arm/include/debug/zynq.S
>> @@ -38,6 +38,7 @@
>>               .endm
>>
>>               .macro  senduart,rd,rx
>> +ARM_BE8(     rev     \rd, \rd )
>>               str     \rd, [\rx, #UART_FIFO_OFFSET]   @ TXDATA
>>               .endm
>>
>>
>
> Tested-by: Michal Simek <michal.simek@xilinx.com>
>

I think just using strb instead of str will do the work
much better. I have send v2 with that logic

Thanks for testing it.

--Arun
