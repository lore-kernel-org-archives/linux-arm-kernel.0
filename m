From: kapilh@broadcom.com (Kapil Hali)
Date: Thu, 12 Nov 2015 18:07:13 +0530
Subject: [PATCH v3 1/4] dt-bindings: add SMP enable-method for Broadcom NSP
In-Reply-To: <20151110162553.GH8644@n2100.arm.linux.org.uk>
References: <1446844273-6460-1-git-send-email-kapilh@broadcom.com>
 <1446844273-6460-2-git-send-email-kapilh@broadcom.com>
 <563E6FC7.6070700@gmail.com> <20151108173116.GV8644@n2100.arm.linux.org.uk>
 <56421540.1020303@broadcom.com>
 <20151110162553.GH8644@n2100.arm.linux.org.uk>
Message-ID: <564487F9.5000308@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 11/10/2015 9:55 PM, Russell King - ARM Linux wrote:
> On Tue, Nov 10, 2015 at 09:33:12PM +0530, Kapil Hali wrote:
>> Hi Russel,
> 
> Wrong.  Look at my name as sent in the From: and as quoted in the very
> next line.  As far as I'm concerned (and I don't care what other people
> say) it's disrespectful to spell people's names incorrectly.
> 
I am sincerely apologetic about it. It was a deviation that will not 
repeat again. 
>> It was clear the very first time itself as pointed out by you and the 
>> lead developers and hence the change was readily sent in the very next
>> patch set. I didn't change a comment in this patch, which is misleading 
>> about the SMP enable-method used in the patch set, it is my mistake and   
>> I apologies for the same. I will change it and send the next patch set.
> 
> Thanks.
> 
>> Also, before sending out the patch set, I had asked for a clarification 
>> about the method: https://lkml.org/lkml/2015/11/6/234
> 
> Sorry, I don't read every single email irrespective of how it's marked.
> There's way too much email, and way too much mail with improperly
> classified recipient lists to be able to usefully sort this mail.
> (If you do the math, the email rate during a 12 hour working day from
> just linux-arm-kernel is one email every 2.5 minutes, assuming 300 emails
> a day.  It takes way longer than that to compose a proper reply to an
> email - I've spent around 15 minutes on this one alone.  Hence, if I'm
> busy, I more or less totally ignore email now, and rarely bother to
> "catch up" with missed emails.)
> 
>> For my understanding, I am repeating my query- In case of simple method of 
>> waking up secondary core, smp_boot_secondary() will always return success 
>> indicating secondary core successfully started. I understand that in 
>> __cpu_up(), primary core waits for completion till secondary core comes 
>> online or time outs. However, is it appropriate to return successful start 
>> of secondary core without knowing if it really did?
> 
> Yes, because all that your smp_boot_secondary() should be doing is
> trying to start the core.  If you encounter an error trying to do so,
> that's what the error return is for.
> 
> If you just set a bit somewhere to tell the hardware to release the
> secondary core's reset, then if you set the bit and return success,
> that's prefectly acceptable.  The core ARM SMP code will then wait
> up to one second for the secondary core to become known to the kernel
> before declaring that the CPU failed to come online.
> 
> If it fails to appear, we assume that it will never appear - and
> actually at that point the system is in an unknown state: if the
> secondary CPU crashed during its boot, it could start scribbling
> into memory or touching devices in an unpredictable way: the only
> sane answer is to reboot the whole system to ensure that it's back
> to a known good state.  Hence why we don't provide any cleanup at
> the point of a failed secondary CPU (I've been debating about
> tainting the kernel at that point, so we know when things have
> gone bad.)
> 
> Hope this helps.
> 
Surely it has helped and many thanks for your detailed explanation.

Thanks,
Kapil Hali
