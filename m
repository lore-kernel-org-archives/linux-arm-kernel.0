From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 5 Sep 2010 18:43:31 +0800
Subject: [PATCH] ARM: pxa: Fix pxa3xx-u2d crash when ULPI not used
In-Reply-To: <4C835655.1080103@compulab.co.il>
References: <1283546146-20000-1-git-send-email-marek.vasut@gmail.com>
	<201009051001.22816.marek.vasut@gmail.com>
	<4C8351F0.2040801@compulab.co.il>
	<201009051025.49256.marek.vasut@gmail.com>
	<4C835655.1080103@compulab.co.il>
Message-ID: <AANLkTikRREGjQfiMc+ttypHmeBE00cXM1Fcmf0GvZXPV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 5, 2010 at 4:35 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> ?On 09/05/10 11:25, Marek Vasut wrote:
>> Dne Ne 5. z??? 2010 10:16:48 Igor Grinberg napsal(a):
>>> ?On 09/05/10 11:01, Marek Vasut wrote:
>>>> Dne Ne 5. z??? 2010 09:54:31 Igor Grinberg napsal(a):
>>>>> ?On 09/03/10 23:35, Marek Vasut wrote:
>>>>>> In case the pxa3xx-u2d driver isn't used, probing of ohci-pxa27x will
>>>>>> cause an ugly kernel crash (NULL pointer dereference in
>>>>>> pxa3xx_u2d_start_hc(), because struct u2d is NULL and clk_enable() call
>>>>>> will crash the kernel, trying to access it).
>>>>> ohci code checks for pxa3xx cpu and only then runs start/stop hc.
>>>> Exactly ... and in case "struct pxa3xx_u2d_ulpi *u2d" is NULL, clk_enable
>>>> will crash the kernel.
>>>>
>>>>> pxa3xx_ulpi.c is compiled if CONFIG_PXA3xx is selected.
>>>>> The device <-> driver binding should not be a problem, so the
>>>>> pxa3xx_u2d_probe() will run.
>>>>> The only case, I see, when struct u2d does not exist is failure of the
>>>>> probe function. If this is the case, we are having an abnormal execution
>>>>> and if your patch is dealing with this issue, shouldn't you comment it
>>>>> as such?
>>>> Not at all ... if the pxa3xx-u2d driver isn't loaded at all, the function
>>>> (start/stop hc) is still called, but struct pxa3xx_u2d_ulpi *u2d is NULL.
>>>> In this case, if you call clk_enable(u2d->clk), you crash the kernel
>>>> (because u2d is NULL).
>>> How, can it happen, that "pxa3xx-u2d driver isn't loaded at all"?
>>> This can happen only if you rip out the device registration or hack a
>>> Makefile. I don't see any other way... is there?
>> If you don't call pxa3xx_set_u2d_info() ?
>
> Oh... right.
> I've added it this way, so boards can control u2d existence and forgot it is there...
> Buggy me... :(
>

Igor,

So do you this as a proper fix, or there is better way out?
