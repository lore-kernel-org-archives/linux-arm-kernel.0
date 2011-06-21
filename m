From: tghk48@motorola.com (TAO HU)
Date: Tue, 21 Jun 2011 17:37:31 +0800
Subject: Bug in _und_usr on dual-core ARM?
In-Reply-To: <20110621091529.GA22868@n2100.arm.linux.org.uk>
References: <BANLkTinY+_+tHatRWuRFUJewUibpmvkUqA@mail.gmail.com>
	<20110621091529.GA22868@n2100.arm.linux.org.uk>
Message-ID: <BANLkTinUYZm+Q3WBGLTQRXz1V2ca1AwE=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Russell

Wouldn't it lead to oops with your patch?
We're trying avoid oops actually.

On Tue, Jun 21, 2011 at 5:15 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jun 21, 2011 at 04:31:19PM +0800, TAO HU wrote:
>> Hi, All
>>
>> We got an issue on our OMAP4 SMP system.
>> Looks like __und_user(), which was triggered by a user space
>> exception, got a page fault hence lead to might_sleep() failure.
>
> Could you see whether this patch prevents the warning please.
>
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index bc0e1d8..d52b940 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -289,7 +289,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> ? ? ? ? * If we're in an interrupt or have no user
> ? ? ? ? * context, we must not take the fault..
> ? ? ? ? */
> - ? ? ? if (in_atomic() || !mm)
> + ? ? ? if (in_atomic() || irqs_disabled() || !mm)
> ? ? ? ? ? ? ? ?goto no_context;
>
> ? ? ? ?/*
>
>



-- 
Best Regards
Hu Tao
