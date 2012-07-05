From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 05 Jul 2012 14:54:04 +0100
Subject: [PATCH 1/1] mfd: Fix runtime warning caused by duplicate device
 registration
In-Reply-To: <20120705132021.GJ4111@opensource.wolfsonmicro.com>
References: <20120705094541.GK4111@opensource.wolfsonmicro.com>
 <4FF57EA9.7060107@linaro.org>
 <20120705120600.GT4111@opensource.wolfsonmicro.com>
 <4FF58571.2090807@linaro.org>
 <20120705122947.GY4111@opensource.wolfsonmicro.com>
 <4FF58B68.5000703@linaro.org>
 <20120705124549.GD4111@opensource.wolfsonmicro.com>
 <4FF58ED6.40106@linaro.org>
 <20120705130306.GI4111@opensource.wolfsonmicro.com>
 <4FF592A9.5050706@linaro.org>
 <20120705132021.GJ4111@opensource.wolfsonmicro.com>
Message-ID: <4FF59C7C.5020406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/12 14:20, Mark Brown wrote:
> On Thu, Jul 05, 2012 at 02:12:09PM +0100, Lee Jones wrote:
>> On 05/07/12 14:03, Mark Brown wrote:
>>> On Thu, Jul 05, 2012 at 01:55:50PM +0100, Lee Jones wrote:
>
>>>> Then were would you register it, if not here?
>
>>> Same place as for DT.
>
>> That is a possibility, but the idea is to reduce code in the
>> platform area, not add to it. We'd also need a completely separate
>
> But surely this would, if anything, remove code?  You already have the
> code to do the registration in the MFD so all you're going to be doing
> here is removing the code from

No, it will add platform code if we were to register the ab8500 from the 
platform area.

>> platform_data structure to the one we use for platform registration,
>> as much of it has now been moved into Device Tree. The regulators
>> are a good example of this, but there's also GPIO information which
>> is no longer relevant etc.
>
> Hrm, the usual pattern for this stuff is that the DT is parsed into
> platform data so the DT code is isolated to the parser.  It sounds like
> you've got a very different structure here?

Yes we do. Ref that commit ID I sent you you a few days ago:

5f3fc8adeec9bb12742fbfa777fa1947deda21a2

>> I do believe that registering the AB8500 from the DB8500 is
>> appropriate though, for the simple reason that the AB8500 is a
>> sub-device to the DB8500. I think this is the correct thing to do.
>> But anyway, as I said before, that ship has sailed. We _already_ do
>> this. All this patch does is prevent the AB8500 from being
>> registered twice when DT is not enabled.
>
> Well, it also introduces code into mainline which is likely to be used
> as a template by other people - I'd be especially worried about the next
> ST platform ending up repeating the same mistakes.

There are no mistakes. It would work for other platforms. :)

> If the code is so
> separate perhaps it's better to just remove the non-DT support?

That's the plan.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
