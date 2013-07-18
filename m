From: julien.grall@linaro.org (Julien Grall)
Date: Thu, 18 Jul 2013 17:43:37 +0100
Subject: [PATCH] arm: choose debug/uncompress.h include when uncompress
 debug is disabled
In-Reply-To: <20130717151148.GM24642@n2100.arm.linux.org.uk>
References: <1373897706-15331-1-git-send-email-julien.grall@linaro.org>
 <alpine.DEB.2.02.1307171420350.8258@kaball.uk.xensource.com>
 <20130717151148.GM24642@n2100.arm.linux.org.uk>
Message-ID: <51E81B39.2030805@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2013 04:11 PM, Russell King - ARM Linux wrote:
> On Wed, Jul 17, 2013 at 02:25:38PM +0100, Stefano Stabellini wrote:
>> On Mon, 15 Jul 2013, Julien Grall wrote:
>>> Even if uncompress debug is disabled, some board will continue to print
>>> information during uncompress step.
>>
>> Are you talking about DEBUG_UNCOMPRESS?
>> Should I read the sentence as "even if DEBUG_UNCOMPRESS is not selected,
>> some board will continue to print information during the uncompress step"?
>>
>> Isn't this a bug in the platform specific code that should be fixed anyway?
> 
> Hang on, let's be clear what's going on here.
> 
> 1. The normal output from the decompressor is *not* debugging.  By that
>    I mean the "Uncompressing kernel... done" message.  That is part of
>    user output.
> 
> 2. In non-multiplatform environments, the decompressor will normally use
>    the putc/flush functions found in arch/arm/mach-*/include/mach/uncompress.h
>    to implement its output, irrespective of the DEBUG_UNCOMPRESS setting.
>    (An interesting point is that DEBUG_UNCOMPRESS really should depend on
>    MULTIPLATFORM so that this point is explicit - the option requires
>    MULTIPLATFORM to be set.)
> 
> 3. DEBUG_UNCOMPRESS allows the functions which we've implemented for LL
>    debug to be re-used for decompressor output.

When Xen will boot, it will use one UART, given by the user, to be able
to log its information. Xen will not map the UART region and the IRQ to
dom0. Of course it will not be present in the device tree either. So if
Linux tries to access to this memory region, it will crash.

When Linux will boot as dom0, it will either use an hvc console or
another UART.

In case of multi-platform environments, there is no issue because when
CONFIG_DEBUG_UNCOMPRESS is disabled.

Now, in non-multiplatform environment, the decompressor will use a
pre-defined UART. This UART may be already used by Xen and Linux will
abort at the first access.

I think, the decompressor should be able to detect if the UART exists
(I'm not sure it's possible) or disabled at compile time uncompress log.

Do you have any better ideas?

Cheers,

-- 
Julien
