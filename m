From: stefan@agner.ch (Stefan Agner)
Date: Thu, 04 Jun 2015 22:24:57 +0200
Subject: [RFC] pinctrl: pinctrl-imx: implement suspend/resume
In-Reply-To: <CAHrpEqS8qYUrcSoNSDMB9tA+D_KcfoSWz75VDSk-S=ZNpwU7mg@mail.gmail.com>
References: <1433171567-24571-1-git-send-email-stefan@agner.ch>
 <CAHrpEqS8qYUrcSoNSDMB9tA+D_KcfoSWz75VDSk-S=ZNpwU7mg@mail.gmail.com>
Message-ID: <9333041871b27a3099b185e26b564e2a@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-06-04 17:00, Zhi Li wrote:
> On Mon, Jun 1, 2015 at 10:12 AM, Stefan Agner <stefan@agner.ch> wrote:
<snip>
>> If no other SoC is making use of it, its probably better to implement
>> it in the SoC specific code (e.g. pinctrl-vf610.c?) Although, currently
>> the mapped access to the registers is only locally available in
>> pinctrl-imx.c.
> 
> i.MX7 support LPSR mode, which IOMUX will lost state also.
> 

Thanks for the information, good to know.

>>
>> I'm also not sure if the suspend/resume functions are currently
>> early enough, at least the noirq family of suspend/resume functions
>> would be earlier. Hence if a device needs to have access to pins then,
>> we would restore them too late. Maybe syscore_ops would be more
>> appropriate?
> 
> Driver can call pinctrl_pm_select_sleep_state in suspend and
> pinctrl_pm_select_default_state
> to recover IOMUX state.
> 
> but I think this way is more simple than driver call
> pinctrl_pm_select_default_state.
> 

I actually tried to experiment with pinctrl_pm_select_default_state and
pinctrl_pm_select_sleep_state. I think, one solution would be to create
sleep states for all drivers. However, it's not necessary to change to a
sleep state, since the controller looses the state anyway. What would be
required is having a function which allows to force the default state
for all pinctrl settings... As far as I can tell, there is no such
functionality currently...? Linus?

--
Stefan
