From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Nov 2012 17:44:52 +0100
Subject: [PATCH V4 1/5] arm: mvebu: Added support for coherency fabric
 in mach-mvebu
In-Reply-To: <20121120163243.GA27765@mudshark.cambridge.arm.com>
References: <1353357360-7242-1-git-send-email-gregory.clement@free-electrons.com>
 <1353357360-7242-2-git-send-email-gregory.clement@free-electrons.com>
 <20121120163243.GA27765@mudshark.cambridge.arm.com>
Message-ID: <50ABB384.4020106@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2012 05:32 PM, Will Deacon wrote:
> Hi Gregory,
> 
> Thanks for turning this around so quickly! I still have a few comments on
> your assembly, but you've got the right idea:

I was a little too quick I think: I have just passed
a few hours to fix a bug which appeared when I have added the HWIOCC
patches. But I see that you have already found it!

> 
> On Mon, Nov 19, 2012 at 08:35:55PM +0000, Gregory CLEMENT wrote:
>> From: Yehuda Yitschak <yehuday@marvell.com>
>>
>> Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> [...]
> 
>> +/* Function defined in coherncy_ll.S */
>> +extern void ll_set_cpu_coherent(void __iomem *base_addr,
>> +				unsigned int hw_cpu_id);
>> +
>> +int set_cpu_coherent(unsigned int hw_cpu_id, int smp_group_id)
>> +{
>> +	if (!coherency_base) {
>> +		pr_warn("Can't make CPU %d cache coherent.\n", hw_cpu_id);
>> +		pr_warn("Coherency fabric is not initialized\n");
>> +		return 1;
>> +	}
>> +	ll_set_cpu_coherent(coherency_base, hw_cpu_id);
>> +	return 0;
>> +}
> 
> Yup, something like this is neater I reckon. You could even make
> ll_set_cpu_coherent return 0 if you wanted, but it's up to you.
> 
>> +#include <linux/linkage.h>
>> +#define ARMADA_XP_CFB_CTL_REG_OFFSET 0x0
>> +#define ARMADA_XP_CFB_CFG_REG_OFFSET 0x4
>> +
>> +	.text
>> +/*
>> + * r0: CFB base adresse register
> 
> address
> 
>> + * r1: HW CPU id
>> + */
>> +ENTRY(ll_set_cpu_coherent)
>> +	/* Create bit by cpu index */
>> +	add     r1,r1,#24
>> +	mov     r3, #1
> 
> Can you instead mov r3, #(1 << 24) and get rid of these two instructions?

I guess

> 
>> +	lsl     r1, r3, r1
>> +
>> +
>> +	/* Add CPU to SMP group - Atomic */
>> +	 orr	r0, r0, #ARMADA_XP_CFB_CTL_REG_OFFSET
> 
> An add might be clearer here, despite the address alignment.

Yes I have change it already, and I don't change r0 any more
as it is the base register: I was lucky that ARMADA_XP_CFB_CFG_REG_OFFSET
was equal to 0!

> 
>> +	ldr     r4, [r0]
>> +	orr     r4 , r4, r1
>> +	str	r4,[r0]
> 
> You haven't saved r4, so you can't use it here. It looks like you have r2
> spare -- why not use that instead?

True! And it was a bug in fact.
When I read the datasheet on PCS I stuck on the expression register 4,
which is r3 and not r4! :(
Now it's fixed and of course now I use r2
> 
>> +	/* Enable coherency on CPU - Atomic*/
>> +	orr	r0, r0, #ARMADA_XP_CFB_CFG_REG_OFFSET
> 
> add

yes I have already fixed it too.

> 
>> +	ldr     r4, [r0]
>> +	orr     r4 , r4, r1
>> +	str     r4,[r0]
> 
> mov	r0, #0 here if you want to return 0.

Well, why not.

> 
>> +	mov	pc, lr
>> +ENDPROC(ll_set_cpu_coherent)
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
