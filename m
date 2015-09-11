From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 11 Sep 2015 18:36:05 +0100
Subject: [PATCH v2] arm/xen: Enable user access to the kernel before
 issuing a privcmd call
In-Reply-To: <55F3102B.3090309@citrix.com>
References: <1441988759-4572-1-git-send-email-julien.grall@citrix.com>
 <20150911170027.GX21084@n2100.arm.linux.org.uk> <55F3102B.3090309@citrix.com>
Message-ID: <55F31105.6070305@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/15 18:32, Julien Grall wrote:
> On 11/09/15 18:00, Russell King - ARM Linux wrote:
>> On Fri, Sep 11, 2015 at 05:25:59PM +0100, Julien Grall wrote:
>>> +	/*
>>> +	 * Privcmd calls are issued by the userspace. We need to allow the
>>> +	 * kernel to access the userspace memory before issuing the hypercall.
>>> +	 */
>>> +	uaccess_enable r4
>>> +
>>> +	/* r4 is loaded now as we use it as scratch register before */
>>>  	ldr r4, [sp, #4]
>>
>> As I mentioned in one of my previous mails, "ip" should be safe to use
>> here - it's a caller-corrupted register, just like r0-r3 and lr.  So,
>> you could do:
>>
>> 	ldr r4, [sp, #4]
>> +	uaccess_enable ip
> 
> The register ip (aka r12) is used to store the hypercall number. So we
> can't reuse it as scratch register.
> 
> The easiest one is r4.
> 
>>
>> which fractionally tightens the window.
>>
>> However, there's nothing actually wrong with your version - there's no
>> way we could've got this far with sp pointing at userspace.
>>
>> I'm happy with either version, so:
>>
>> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>
>> How do you want to handle the patch?  I already have some other uaccess
>> fixes queued up to send to Linus before the merge window closes.

Forgot to answer to this bits. I was thinking to ask Stefano carrying
the patch in xentip. Although it won't go until rc1.

I don't mind if it's going earlier in Linux/master.

Regards,

-- 
Julien Grall
