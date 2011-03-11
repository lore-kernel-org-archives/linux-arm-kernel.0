From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Fri, 11 Mar 2011 11:02:17 -0800
Subject: [Qualcomm PM8921 MFD v2 2/6] mfd: pm8xxx: Add irq support
In-Reply-To: <alpine.LFD.2.00.1103111853480.2787@localhost6.localdomain6>
References: <1299564590-30116-1-git-send-email-adharmap@codeaurora.org>
	<1299564590-30116-3-git-send-email-adharmap@codeaurora.org>
	<alpine.LFD.2.00.1103081201520.2787@localhost6.localdomain6>
	<4D770E47.6050402@codeaurora.org>
	<alpine.LFD.2.00.1103101126100.2787@localhost6.localdomain6>
	<4D79A85D.8000301@codeaurora.org>
	<alpine.LFD.2.00.1103111853480.2787@localhost6.localdomain6>
Message-ID: <4D7A71B9.9000306@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> Yes however while updating the code I noticed that I would need to keep
>> account of all the interrupts enabled and all the interrupts marked wakeup.
>> This aids in switching to the wakeup set in the suspend callback and the
>> enabled set in the resume callback. I will update the resume callback to
>> enable the interrupts in irqs_allowed(the local state storage) in the next
>> patch (my current patch does not do that).
>>
>> IOW I need to keep the local state storage.
> 
> Wrong. The interrupts are disabled and reenabled by the core code and
> not by some extra suspend/resume callbacks in your driver. The core
> checks those marked as IRQ_WAKE, the wake callback to the irq chip is
> only there if you need to set up some hardware register in order to
> make the wake functionality work. So again, you don't need local state
> as the core tracks the state for you.

Help me understand this, the core code calls disable on all the 
interrupts while going to suspend. Notice that I have no disable 
callback, which means those interrupts remain unmasked.

I could have a situation, when the system(a mobile phone) goes to 
suspend we dont want to wake it up because of unnecessary interrupts. A 
good example is, we want to wakeup the phone if the battery goes low, 
but dont want to wake it up if an acceleromter interrupt triggers. The 
drivers respectively mark the battery low interrupt as wakeup and the 
accelerometer interrupt as a non-wake up interrupt. Assume both of them 
are edge triggered interrupts.

The genirq code does not mask the interrupt while going to suspend, it 
only calls disable(), which I understand should not mask the interrupt 
for check_wakeup_irqs() to work.

If I don't mask that accelerometer interrupts in the interrupt 
controller's suspend() the phone will wakeup every time the user moves 
around, draining the battery unnecessarily.

One might say that the accelerometer should be deactivated in the 
suspend callback of the accelerometer driver. Yes this can be done and 
we will not see an interrupt while suspended. However not all hardware 
can be deactivated like that. There are some devices which simply 
interrupt and the only way to keep from waking up is masking their 
interrupts.

How do you suggest I mask the accelerometer interrupt?

Abhijeet
--
Sent by an employee of the Qualcomm Innovation Center, Inc. The Qualcomm 
Innovation Center, Inc. is a member of the Code Aurora Forum.
