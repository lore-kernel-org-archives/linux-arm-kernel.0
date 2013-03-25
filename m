From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 25 Mar 2013 14:58:46 +0100
Subject: [PATCH 5/6] ARM: ux500: move PRCMU functions into the CPUidle
 driver
In-Reply-To: <CACRpkdZa1NMRjatD5W7zcYZC=QWu6f7L4oqn48PWR0j5AqSmPw@mail.gmail.com>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <1363866553-15054-6-git-send-email-linus.walleij@stericsson.com>
 <514AF99F.7040100@stericsson.com> <514AFD67.20205@linaro.org>
 <CACRpkdZa1NMRjatD5W7zcYZC=QWu6f7L4oqn48PWR0j5AqSmPw@mail.gmail.com>
Message-ID: <51505816.1020302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 02:44 PM, Linus Walleij wrote:
> On Thu, Mar 21, 2013 at 1:30 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 03/21/2013 01:14 PM, Rickard Andersson wrote:
>>> On 03/21/2013 12:49 PM, Linus WALLEIJ wrote:
>>>> From: Linus Walleij<linus.walleij@linaro.org>
>>>>
>>>> We are trying to decompose and decentralize the code in
>>>> the DB8500 PRCMU out into subdrivers. The CPUidle code is
>>>> calling down into the PRCMU driver basically just to access
>>>> these registers, so let's remap them locally in the CPUidle
>>>> driver and move the code there, simply. Besides, the PRCMU
>>>> code was poking around in the GIC which is the responsibility
>>>> of the machine.
>>>>
>>>> Cc: Daniel Lezcano<daniel.lezcano@linaro.org>
>>>> Cc: Rickard Andersson<rickard.andersson@stericsson.com>
>>>> Cc: Samuel Ortiz<sameo@linux.intel.com>
>>>> Signed-off-by: Linus Walleij<linus.walleij@linaro.org>
>>>> ---
>>>> Sam, I'm requesting an ACK for taking this through the
>>>> ARM SoC tree.
>>>> ---
>>> This functionality will be used by the platform suspend operation also
>>> which I am currently working on. So I would prefer if you can move it to
>>> a separate file instead so it can be used by suspend as well. I
>>> recommend to have it the same way we have it in our internal track i.e.
>>> a file called pm.c in the machine.
>>
>> That would be nice to move this driver to drivers/cpuidle.
>>
>> If you are ok with that, I can take care of moving the driver to this
>> directory and then create the pm.c file in the mach-ux500 to move the
>> prcmu specific code inside. Meanwhile this patch can be merged to group
>> the prcmu code needed for the driver and can be easily identified.
> 
> If you write a patch like that it needs to go with this patch series
> because I need this split out of the PRCMU driver to be able to
> move forward with multiplatform.
> 
> I tried figuring out if I could just make this split as part of my
> patch series which is simpler (then we just merge that into
> ARM SoC and you can base CPUidle movement on that).
> 
> But then I get into the dilemma of where to put the header
> file for these PM functions.
> 
> The goal of this series does away with <mach/*> so it can not be
> any new <mach/pm.h> header.

Actually, I considered to move the driver to the right place as an
answer to Rickard who suggested to create the pm file.

As he is ok with that, I am ok with your patch splitting the prcmu code
and moving the code inside the cpuidle driver.

I proposed to take care of moving the prcmu code which falls in
cpuidle.c to a pm.c and then move the cpuidle.c file in driver/cpuidle
after your patch is applied.

> 
> The code will need to be called by idle code in drivers/cpuidle
> and suspend code in mach-ux500. (Unless suspend/resume shall
> also be moved to drivers/cpuidle? I guess not?)

No, it shouldn't :)

> Shall I put it in <linux/platform_data/arm-ux500-pm.h> or so,
> with the implementation in arch/arm/mach-ux500/pm.c
> or so?

Wouldn't <asm/pm.h> be better ? So we can have the same header name for
all the drivers, no ?

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
