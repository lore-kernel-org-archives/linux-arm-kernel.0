From: deepak.sikri@st.com (deepaksi)
Date: Fri, 3 Sep 2010 11:54:06 +0530
Subject: [PATCH 48/74] GIC: Added dummy handlers for Power Management
	Suspend Resume
In-Reply-To: <20100902102323.GP26319@n2100.arm.linux.org.uk>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<47425e7be671c44d949b1804436b5c301d20d793.1283161023.git.viresh.kumar@st.com>
	<20100902102323.GP26319@n2100.arm.linux.org.uk>
Message-ID: <4C809486.2070308@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/2/2010 3:53 PM, Russell King - ARM Linux wrote:
> On Mon, Aug 30, 2010 at 04:09:12PM +0530, Viresh KUMAR wrote:
>   
>> From: Deepak Sikri <deepak.sikri@st.com>
>>
>>     
> The reason being?
>
>   

For configuring the wake up sources ( normally in the PM framework for
suspend resume operations), you need to use the following set of api
enable_irq_wake(). This handler has a appropriate callback for the vic,
similar to the plugin that we have added in for gic which does enable
the wake interrupt sources only. But since gic handler did not had this
call back associated was always returning -ENXIO, which was breaking the
existing drivers. In case no checks are provided for the return value of 
enable_irq_wake(), the things were fine.



>> Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
>> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>> ---
>>  arch/arm/common/gic.c |   13 +++++++++++++
>>  1 files changed, 13 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
>> index 7dfa9a8..e816ef1 100644
>> --- a/arch/arm/common/gic.c
>> +++ b/arch/arm/common/gic.c
>> @@ -201,6 +201,18 @@ static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
>>  	chip->unmask(irq);
>>  }
>>  
>> +#ifdef CONFIG_PM
>> +
>> +static int gic_set_wake(unsigned int irq, unsigned int on)
>> +{
>> +	return 0;
>> +}
>> +
>> +#else
>> +
>> +#define gic_set_wake NULL
>> +#endif
>> +
>>  static struct irq_chip gic_chip = {
>>  	.name		= "GIC",
>>  	.ack		= gic_ack_irq,
>> @@ -210,6 +222,7 @@ static struct irq_chip gic_chip = {
>>  #ifdef CONFIG_SMP
>>  	.set_affinity	= gic_set_cpu,
>>  #endif
>> +	.set_wake	= gic_set_wake,
>>  };
>>  
>>  void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
>> -- 
>> 1.7.2.2
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>     
> .
>
>   
