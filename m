From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 4 Oct 2017 12:18:59 +0100
Subject: [PATCH v3 11/22] firmware: arm_scmi: add support for polling
 based SCMI transfers
In-Reply-To: <CAK8P3a2wRFif2zYKKmdcNm5wgbGdhqwLdA-YV7AX_0LmM+OiQQ@mail.gmail.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-12-git-send-email-sudeep.holla@arm.com>
 <CAK8P3a2wRFif2zYKKmdcNm5wgbGdhqwLdA-YV7AX_0LmM+OiQQ@mail.gmail.com>
Message-ID: <6b2f2e70-6d0f-e7e4-d130-cd384289eb1a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/10/17 12:13, Arnd Bergmann wrote:
> On Thu, Sep 28, 2017 at 3:11 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> It would be useful to have options to perform some SCMI transfers
>> atomically by polling for the completion flag instead of interrupt
>> driven. The SCMI specification has option to disable the interrupt and
>> poll for the completion flag in the shared memory.
>>
>> This patch adds support for polling based SCMI transfers using that
>> option. This might be used for uninterrupted/atomic DVFS operations
>> from the scheduler context.
> 
> multi-millisecond timeouts from inside the scheduler sound like a
> really bad idea. Could this maybe get changed to an asynchronous
> operation?
> 

We already support asynchronous version. This is mainly to support fast
DVFS switching done at context switch. I can reduce the timeouts to
few uS as the whole idea of fast dvfs is we can't return or schedule out
of this function. Typically the remote should see the request in < 10 uS
and acknowledge it.

>> +       if (xfer->hdr.poll_completion) {
>> +               timeout = info->desc->max_rx_timeout_ms * 100;
>> +               while (!scmi_xfer_poll_done(info, xfer) && timeout--)
>> +                       udelay(10);
> 
> The timeout calculation is bad as well, since both the
> scmi_xfer_poll_done() call and udelay() can take much longer
> than the 10 microsecond delay that you use for the calculation.
> 

Ah, agreed. I will change it to few uS as that's what is expected.

> If you want to do a timeout check like this, it should generally
> be done using ktime_get()/ktime_add()/ktime_before().
> 

Good idea, will try to use that.

-- 
Regards,
Sudeep
