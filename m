From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 5 Dec 2011 14:40:50 +0530
Subject: [PATCH v5 1/4] regulator: helper routine to extract
 regulator_init_data
In-Reply-To: <20111204155433.GA16287@opensource.wolfsonmicro.com>
References: <1321615040-13257-1-git-send-email-rnayak@ti.com>
 <1321615040-13257-2-git-send-email-rnayak@ti.com>
 <CAJuYYwRO+AS=WmQfNAe8L6Gi5Dm4VsCuVqk3X5Nb8uUYAdLnJQ@mail.gmail.com>
 <20111204155433.GA16287@opensource.wolfsonmicro.com>
Message-ID: <CAJuYYwQ-9wCu-+q0S2YYeFYemq74ULdZ-EwPGLWKHA4+0VZcsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 4 December 2011 21:24, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, Dec 04, 2011 at 06:51:23PM +0530, Thomas Abraham wrote:
>
>> For regulators that are not turned on by bootloader, and which require
>> 'apply_uV' constraint, is there any alternative for turning on the
>> regulator when using dt?
>
> If the regulator isn't software managed then always_on covers this - the
> regulator core will enable any always_on regulators that haven't been
> enabled already.

Thanks for the hint. I was trying to deal with a regulator that was
not software managed but also required the voltage level to be set to
certain level. That was possible with 'apply_uV' constraint in non-dt
case. Anyway, I have modified the code to manage the regulator and
this works fine in dt case as well without the 'apply_uV' constraint.

>
>> ? ? ? /* do we need to apply the constraint voltage */
>> - ? ? if (rdev->constraints->apply_uV &&
>> - ? ? ? ? rdev->constraints->min_uV == rdev->constraints->max_uV) {
>> + ? ? if ((rdev->constraints->apply_uV &&
>> + ? ? ? ? rdev->constraints->min_uV == rdev->constraints->max_uV) ||
>> + ? ? ? ? ? ? (!rdev->constraints->boot_on && rdev->constraints->always_on)) {
>> ? ? ? ? ? ? ? ret = _regulator_do_set_voltage(rdev,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? rdev->constraints->min_uV,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? rdev->constraints->max_uV);
>
> I'm not sure I understand the intended logic there. ?Voltage constraints
> and enable/disable constraints are orthogonal here.

Ok. I guess the above change is incorrect then.

Thanks,
Thomas.
