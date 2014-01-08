From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 8 Jan 2014 18:34:16 +0530
Subject: [PATCH] ARM: tegra: Remove 3.3V supply and modem regulators
In-Reply-To: <52CC2EBF.60106@wwwdotorg.org>
References: <1389021933-6675-1-git-send-email-treding@nvidia.com>
 <52CB192F.2020700@wwwdotorg.org> <52CBEF89.6090901@nvidia.com>
 <52CC2EBF.60106@wwwdotorg.org>
Message-ID: <52CD4CD0.1010302@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 January 2014 10:13 PM, Stephen Warren wrote:
> On 01/07/2014 05:14 AM, Laxman Dewangan wrote:
>> On Tuesday 07 January 2014 02:29 AM, Stephen Warren wrote:
>>> On 01/06/2014 08:25 AM, Thierry Reding wrote:
>>>> GPIO 1 and 2 of the PMIC are not used for the described purpose, so
>>>> remove them.
>>> As far as I can tell, this patch is correct, since those GPIOs are in
>>> fact used to discharge the rails after disabling them, rather than to
>>> enable/disable the rails.
>>>
>>> Equally, these GPIOs affect multiple rails at once, so listing the GPIO
>>> as a property of a single regulator seems wrong either way.
>>>
>>> However, PMU_REGEN1 does seem to feed the "EN" pin of U13C1, a DC/DC
>>> switcher for power rail 3.3v_modem, so perhaps there's more going on
>>> here than I see?
>>>
>>> In summary, I need Laxman to comment on this and ack the change, and
>>> explain why these GPIOs were listed as regulator enables when it doesn't
>>> seem that they are.
>>>
>> PMU_REGEN1 is going to U13C1 (DCDC switcher). So if EN is 0, the output
>> will be 0 and when it is 1, the output will be 3.3V.
>> Because this is coming from GPIO, it is added as the fixed regulator.
> What about PMU_REGEN3, for which that isn't the case, and what about the
> fact that PMU_REGEN1 does a lot more than just enable that DC/DC switcher?
>
Based on my understanding with schematics:

PMU_REGEN1;
if high then PMU_REGEN1_L is 0 and so Q20B6, Q20B7, Q20B8 are open and 
all rails are not connected to ground through their register.
If Low then PMUC_REGEN1_L is 1 and so Q20B6, Q20B7, Q20B8 are connected 
to D to S and all rails are discharged through the register.
This means we need to keep PMU_REGN1 to high for using the rails in 
normal case.

Similar for the PMU_REGEN3.

PMU_REGEN1 is also enabling the U13C1 when it is High then output will 
have voltage otherowise Vout = 0.
PMU_REGEN1 is feeding to U20A6, which works as sequencer.
The PMU_REGEN1 is expected to be always High (even in LP0) so that it 
can keep the some rail ON on LP0 also. (Based on comment)

The PMU_REGEN3 is high in normal case and should be in low for LP0 so 
that it can off the rails in LP0.

So regulator, involved with this should have the always ON property 
enabled. If the gpio need to be disable during LP0 then it need to 
written explicitly in suspend/resume.

BTW, how this is effecting the edp functionality? Does EDP expect the 
level of this GPIOs to be 0?
Anything I can debug here to narrow-down the issue? Probably we need to 
scope the gpio status?
Also if you can pass the register dump in wokring and non-working case 
then it will be very easy to analyse the issue.


Thanks,
Laxman
