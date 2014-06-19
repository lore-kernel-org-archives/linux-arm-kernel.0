From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 19 Jun 2014 12:46:21 +0100
Subject: [PATCH v4 11/13] serial: asc: Adopt readl_/writel_relaxed()
In-Reply-To: <53A2C9A3.9090507@linaro.org>
References: <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
 <1403174303-25456-12-git-send-email-daniel.thompson@linaro.org>
 <53A2C9A3.9090507@linaro.org>
Message-ID: <53A2CD8D.1050106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/06/14 12:29, Srinivas Kandagatla wrote:
> Hi Dan,
> 
> On 19/06/14 11:38, Daniel Thompson wrote:
>> The architectures supported by this driver have expensive
>> implementations of writel(), reliant on spin locks and explicit L2 cache
>> management. These architectures provide a cheaper writel_relaxed() which
>> is much better suited to peripherals that do not perform DMA. The
>> situation with readl()/readl_relaxed()is similar although less acute.
>>
>> This driver does not use DMA and will be more power efficient and more
>> robust (due to absense of spin locks during console I/O) if it uses the
>> relaxed variants.
>>
>> This driver is cross compilable for testing purposes and remains
>> compilable on all architectures by falling back to writel() when
>> writel_relaxed() does not exist. We also include explicit compiler
>> barriers. There are redundant on ARM and SH but important on
>> x86 because it defines "relaxed" differently.
>>
> Why are we concern about x86 for this driver?
> As per my understanding this IP is only seen on ARM and SH based CPUs so
> why cant we just use relaxed versions, why ifdefs?
> I think, this would involve fixing the kconfig and make it depend on SH
> and ARM based platforms only.

You mean just drop the COMPILE_TEST?

In generally I like as much code as possible to compile on x86. Its
worthwhile protection against the excessive/accidental ARMisms which
could easily impact less common architectures (such as SH).


> On the other hand, This patch looks more generic and applicable to most
> of the drivers. Am not sure which way is the right one.

I'm particularly keen on doing the right thing where readl_relaxed() is
concerned because this function has a compiler barrier on ARM but not on
x86.

Since having asc_in/asc_out made it easy to portably make these changes
I decided is was better to be redundantly exemplary than conceal secret
portability issues.

Don't feel that strongly though. Can easily change it if you're unconvinced.



> 
> 
> --srini
> 
>> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>> Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
>> Cc: Maxime Coquelin <maxime.coquelin@st.com>
>> Cc: Patrice Chotard <patrice.chotard@st.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Jiri Slaby <jslaby@suse.cz>
>> Cc: kernel at stlinux.com
>> Cc: linux-serial at vger.kernel.org
>> ---
>>   drivers/tty/serial/st-asc.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
>> index 4f376d8..58aa1c6 100644
>> --- a/drivers/tty/serial/st-asc.c
>> +++ b/drivers/tty/serial/st-asc.c
>> @@ -152,12 +152,21 @@ static inline struct asc_port
>> *to_asc_port(struct uart_port *port)
>>
>>   static inline u32 asc_in(struct uart_port *port, u32 offset)
>>   {
>> -    return readl(port->membase + offset);
>> +    u32 r;
>> +
>> +    r = readl_relaxed(port->membase + offset);
>> +    barrier();
>> +    return r;
>>   }
>>
>>   static inline void asc_out(struct uart_port *port, u32 offset, u32
>> value)
>>   {
>> +#ifdef writel_relaxed
>> +    writel_relaxed(value, port->membase + offset);
>> +    barrier();
>> +#else
>>       writel(value, port->membase + offset);
>> +#endif
>>   }
>>
>>   /*
>>
