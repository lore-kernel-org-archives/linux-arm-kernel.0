From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 18 Sep 2014 22:56:23 -0700
Subject: [RFC] arm: Handle starting up in secure mode
In-Reply-To: <54198BDE.8000509@codeaurora.org>
References: <1410901756-20694-1-git-send-email-cov@codeaurora.org>
 <5418AA80.4090102@codeaurora.org> <54198BDE.8000509@codeaurora.org>
Message-ID: <CAFEAcA-Z_KqCrBRKLxtEaca3jAH35Xx=CqOr36KgAGfFrE91nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 September 2014 06:25, Christopher Covington <cov@codeaurora.org> wrote:
> On 09/16/2014 05:24 PM, Christopher Covington wrote:
>> On 09/16/2014 05:09 PM, Christopher Covington wrote:
>>> ARM Linux currently has the most features available to it in hypervisor
>>> (HYP) mode, so switch to it when possible. This can also ensure proper
>>> reset of newer registers such as CNTVOFF.
>>>
>>> The permissions on the Non-Secure Access Control Register (NSACR) are
>>> used to probe what the security setting currently is when in supervisor
>>> (SVC) mode.
>>
>> Sorry, this doesn't work yet. I was misinterpreting my test results. For what
>> it's worth, my testing and development methodology is to run it after hacked
>> up versions of the semihosting bootwrapper on the simulator that corresponds
>> to rtsm_ve-aemv8a.dtb (AEM VE FVP these days?) and examine the instruction traces.
>
> Looks like the real problem was that I was hacking up the bootwrapper
> incorrectly--my start-in-secure-mode bootwrapper variant wasn't setting up the
> GIC for non-secure access. With that changed, I've tested the following
> variations using the Image file in a single core configuration.
>
> Start in non-secure SVC with non-secure access to GIC configured.
>
> Start in secure SVC with non-secure access to GIC configured.
>
> Start in secure SVC with non-secure access to GIC configured and hypervisor
> support disabled in the model (-C cluster.has_el2=0). This required setting
> the VBAR again in non-secure SVC but with that fix it seems to work. I'll
> include this change in v2.

If you're relying on the boot loader to set up the GIC to support
non-secure access anyway, why not just have it boot the kernel in Hyp
like the boot protocol document recommends? (The same thing as the GIC
is going to apply for any other hardware that needs configuration to
allow NS access; if we need the firmware to deal with this we might as
well just have it boot us in the right mode too.)

Incidentally, on a v7 CPU without the Security Extensions the VBAR
doesn't exist at all, so your code is going to UNDEF at an earlier
point than you think it is...

-- PMM
