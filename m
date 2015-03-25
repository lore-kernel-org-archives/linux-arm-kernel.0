From: egtvedt@samfundet.no (Hans-Christian Egtvedt)
Date: Wed, 25 Mar 2015 07:14:45 +0100
Subject: [Linux-kernel] [PATCH 12/13] mmc: atmel-mci: use endian agnostic
 IO
In-Reply-To: <55115E55.4090409@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
 <1426693992-31163-13-git-send-email-ben.dooks@codethink.co.uk>
 <1426774966.22122.47.camel@xylophone.i.decadent.org.uk>
 <55115E55.4090409@codethink.co.uk>
Message-ID: <20150325061445.GB3771@samfundet.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Around Tue 24 Mar 2015 12:53:41 +0000 or thereabout, Ben Dooks wrote:
> On 19/03/15 14:22, Ben Hutchings wrote:
>> On Wed, 2015-03-18 at 15:53 +0000, Ben Dooks wrote:
>>> Change the __raw IO functions to endian agnostic relaxed ones to allow
>>> the driver to function on big endian ARM systems.
>>>
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>> --
>>> CC: Ludovic Desroches <ludovic.desroches@atmel.com>
>>> CC: Chris Ball <chris@printf.net>
>>> CC: Ulf Hansson <ulf.hansson@linaro.org>
>>> CC: linux-mmc at vger.kernel.org
>>> ---
>>>  drivers/mmc/host/atmel-mci-regs.h | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/atmel-mci-regs.h b/drivers/mmc/host/atmel-mci-regs.h
>>> index c97001e..711bb53 100644
>>> --- a/drivers/mmc/host/atmel-mci-regs.h
>>> +++ b/drivers/mmc/host/atmel-mci-regs.h
>>> @@ -135,10 +135,17 @@
>>>  #define ATMCI_REGS_SIZE		0x100
>>>  
>>>  /* Register access macros */
>>> -#define atmci_readl(port,reg)				\
>>> +#ifdef CONFIG_AVR32
>>> +#define atmci_readl(port,reg)			\
>>>  	__raw_readl((port)->regs + reg)
>>>  #define atmci_writel(port,reg,value)			\
>>>  	__raw_writel((value), (port)->regs + reg)
>>> +#else
>>> +#define atmci_readl(port,reg)			\
>>> +	readl_relaxed((port)->regs + reg)
>>> +#define atmci_writel(port,reg,value)			\
>>> +	writel_relaxed((value), (port)->regs + reg)
>>> +#endif
>> 
>> This pattern is repeated in a lot of drivers; is it worth defining
>> atmel_{read,write}l_relaxed() in a common header?
>> 
>> #ifdef CONFIG_AVR32
>> 
>> /* CPU and peripherals are both big-endian, so don't byte-swap */
>> #define atmel_readl_relaxed(addr)		__raw_readl(addr)
>> #define atmel_writel_relaxed(value, addr)	__raw_writel(value, addr)
>> 
>> #else
>> 
>> /* Peripherals are little-endian, so byte-swap if CPU isn't */
>> #define atmel_readl_relaxed(addr)		readl_relaxed(addr)
>> #define atmel_writel_relaxed(value, addr)	writel_relaxed(value, addr)
>> 
>> #endif
>> 
>> Ben.
> 
> Hi, I think it will probably be a good idea to have an avr32/at91
> read/write functions however I will put this forward as a separate
> series as it will require both avr32 and at91 maintainers as well
> as driver updates.
> 
> how about:
> 	atmel_readl_onchip{b,w,l}
> 	atmel_writel_onchip{b,w,l}

Common is good, will make it easier for developers to understand why it is
like this as well.

-- 
Hans-Christian Egtvedt
