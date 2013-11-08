From: joelf@ti.com (Joel Fernandes)
Date: Thu, 7 Nov 2013 22:58:24 -0600
Subject: [PATCH v5] ARM: omap: edma: add suspend suspend/resume hooks
In-Reply-To: <87siv7pxpp.fsf@linaro.org>
References: <1383863549-7438-1-git-send-email-zonque@gmail.com>
 <87siv7pxpp.fsf@linaro.org>
Message-ID: <527C6F70.1010103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On 11/07/2013 06:02 PM, Kevin Hilman wrote:
> Daniel Mack <zonque@gmail.com> writes:
[..]
>> +	.resume_noirq	= edma_pm_resume,
>> +};
> 
> Also, I believe it was already suggested by Nishanth, but the late/early
> callbacks are probably more appropriate here than the noirq callbacks.
> Unless there's a *really* good reason to use the noirq callbacks, they
> should be avoided.
> 
> That being said, I wonder if the whole approach here is the right one.
> I know you're basing your stuff on some TI tree, but that doesn't make
> it the right way (usually, it's the opposite, but I digress...)  ;)
> 
> IMO, EDMA should be done like we currently do I2C and not implement
> suspend/resume at all.  Instead, the driver should do runtime PM done on

But a potential problem with this is powering edma on or off between xfers may
slow things down quite a bit because xfers happen so much often and there is
some overhead in the pm_runtime calls which adds up overtime when dealing with
something as frequent as EDMA. Also we would lose the global EDMA context right
so we'd have to restore the context every time during runtime PM (?).

I had a patch that also made AES driver not pm_runtime_get/put specially when
the next crypto request was imminent. But instead adopted a softer approach
where the pm_runtime_put call would happen at a time when we are sure we're at
the end of all requests. This resulted in quite a speed up.

thanks,

-Joel
