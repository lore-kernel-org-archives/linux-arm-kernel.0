From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Fri, 15 Apr 2011 15:08:34 -0700
Subject: [RFC PATCH] genirq: implement read_irq_line for interrupt lines
In-Reply-To: <alpine.LFD.2.00.1104152058050.2744@localhost6.localdomain6>
References: <1302892952-7090-1-git-send-email-adharmap@codeaurora.org>
	<alpine.LFD.2.00.1104152058050.2744@localhost6.localdomain6>
Message-ID: <4DA8C1E2.3020205@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Gleixner wrote:
> On Fri, 15 Apr 2011, Abhijeet Dharmapurikar wrote:
> 
>> Some drivers need to know what the status of the interrupt line is.
>> This is especially true for drivers that register a handler with
>> IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING and in the handler they
>> need to know which edge transition it was invoked for.
> 
> What's the purpose of this? How is that going to be used?

The main purpose is to know in the handler if it was invoked becuase of 
a rising edge or the falling edge.

Now one could say that the driver should maintain some state and toggle 
it upon each invocation of this handler. That scheme quickly goes out of 
sync because we might ignore interrupts while suspended.

> 
>>  
>>  #ifndef CONFIG_GENERIC_HARDIRQS_NO_COMPAT
> 
> That hunk does not apply.

Will rebase and resend it again, my bad.

>> +int irq_read_line(unsigned int irq)
>> +{
>> +	struct irq_desc *desc = irq_to_desc(irq);
>> +	unsigned long flags;
>> +	int val;
> 
> Please use irq_get_desc_buslock()

yes will fix this in the next revision of this patch.


>> +EXPORT_SYMBOL(irq_read_line);
> 
> EXPORT_SYMBOL_GPL() please.

yes will do


--
Sent by an employee of the Qualcomm Innovation Center, Inc. The Qualcomm 
Innovation Center, Inc. is a member of the Code Aurora Forum.
