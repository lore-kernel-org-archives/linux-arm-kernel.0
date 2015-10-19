From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 19 Oct 2015 12:10:00 +0200
Subject: [PATCH] pinctrl: mvebu: armada-38x: add suspend/resume support
In-Reply-To: <CAPv3WKfxmwKaPA7BUffwsn8rweSShCSVaCyH4nrQcUkNk7uB2Q@mail.gmail.com>
References: <1445117328-31678-1-git-send-email-mw@semihalf.com>
 <20151017222927.GR32532@n2100.arm.linux.org.uk>
 <CAPv3WKed+Q3K0ky9b9AAYSymB-tE0O=57UdrgM+7Cx-X9PeVcA@mail.gmail.com>
 <20151018160123.6694b4be@free-electrons.com>
 <CAPv3WKdKea-85_0xUv218OVfhnfMvisYXh8qRNRjvmNkweSUJg@mail.gmail.com>
 <20151019092320.33d48dba@free-electrons.com>
 <CAPv3WKfxmwKaPA7BUffwsn8rweSShCSVaCyH4nrQcUkNk7uB2Q@mail.gmail.com>
Message-ID: <CAPv3WKdqb6D860Zr+Ed+0K34cym-EtP1E087TVaKbF+OmSYHkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Found it - I think there is an easy way to get rid of all global
variables in each pinctrl-<soc>. It's enough to:
- extend struct mvebu_pinctrl with generic pointer
- pass SoC specific structure to mvebu_pinctrl_probe via dev->driver_data
- in mvebu_pinconf_group_set/get pass an additional argument to
mpp_set/get: struct mvebu_pinctrl *pctl.
- update mpp_set/get callbacks in each driver accordingly
This way in SoC-specific pinctrl driver we determine what data we want
to use and how. I can prepare a patchset with all described changes.
I'm looking forward to your feedback.

Best regards,
Marcin

2015-10-19 11:25 GMT+02:00 Marcin Wojtas <mw@semihalf.com>:
> Thomas,
>
> 2015-10-19 9:23 GMT+02:00 Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com>:
>> Hello,
>>
>> On Mon, 19 Oct 2015 08:04:49 +0200, Marcin Wojtas wrote:
>>
>>> > I don't like this. The mvebu_pinctrl_soc_info structure is meant to be
>>> > a read-only structure that only describes static information giving
>>> > SoC-specific details for pin-muxing. The idea is that in the event
>>> > where you had multiple pinctrl in the same system, you would still have
>>> > only one instance of mvebu_pinctrl_soc_info.
>>>
>>> Ok, understood. What with current static globals, like mpp_base? This
>>> is a problem when we consider hypothetical multi-pintrl system...
>>
>> The current driver is indeed not designed for multiple instances of the
>> same pinctrl controller. But that's exactly what Russell is asking for.
>>
>
> In each mvebu pinctl there are <soc>_mpp_ctrl_get/set force usage of
> global mpp_base. In order not to use it this way the functions have to
> be redesigned. IMO having an acces to pdev would be sufficient (please
> see my proposal below), but yet I don't have a clear idea, how to do
> it,
>
>>> In genereal, I think storing additional global data is not
>>> starightforward, as dev->platform_data and dev->driver_data are
>>> currently occupied by mvebu_pinctrl and mvebu_pinctrl_soc_info. I
>>> propose the following:
>>>
>>>
>>> 1. Create a new structure:
>>> struct mvebu_pinctrl_pm_info {
>>
>> This definitely shouldn't be called "pm_info", because 'base' is not PM
>> related. It should be mvebu_pinctrl_state or something like that.
>>
>>>     void __iomem *base;
>>>     static u32 *mpp_saved_regs;
>>>     int nregs;
>>> }
>>>
>>> 2. Add new field to struct mvebu_pinctrl:
>>> struct mvebu_pinctrl_pm_info *pm_info;
>>
>> Does not work because "mvebu_pinctrl_pm_info" cannot be a generic
>> structure, it has to be a per-SoC driver structure, since the set of
>> registers to save for PM reasons is different from one SoC to the
>> other. Also, some SoC have only one "base" pointer, some others (like
>> Dove) have multiple.
>>
>> So it should be the other way around: the SoC-specific driver create a
>> structure, and this structure points back to the mvebu_pinctrl
>> structure.
>>
>
> How about a following compromise:
> Instead of forcing pm_info, we can add a generic pointer to struct
> mvebu_pinctrl, e.g. void *priv; and enable passing it in a way I
> proposed before.
>
> This way each SoC-specific driver can attach whatever is needed for
> its operation. For example in A38X/AXP it would be *base,
> *mpp_saved_regs and nregs gathered in one structure, but it wouldn't
> force anything specific for other machines. As a result in A38X/AXP in
> suspend/resume routines, there would be no globals in use at all.
>
> Best regards,
> Marcin
