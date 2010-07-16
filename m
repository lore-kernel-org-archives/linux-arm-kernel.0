From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Fri, 16 Jul 2010 17:30:03 +0900
Subject: [PATCH 5/5] ARM: S5PV210: Initial CPUFREQ Support
In-Reply-To: <20100716081707.GA9082@rakim.wolfsonmicro.main>
References: <1279184768-28971-1-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-2-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-3-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-4-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-5-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-6-git-send-email-myungjoo.ham@samsung.com>
	<20100715115942.GA15919@sirena.org.uk>
	<AANLkTinrrXlh1GQ178_NzwWt5luO_1mdfIGy6G2ZNbPH@mail.gmail.com>
	<20100716081707.GA9082@rakim.wolfsonmicro.main>
Message-ID: <AANLkTikYX6N7q3lT5ZzXh3RQnGss39eGhSrfC9blqoF_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 5:17 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Jul 16, 2010 at 02:37:04PM +0900, MyungJoo Ham wrote:
>> On Thu, Jul 15, 2010 at 8:59 PM, Mark Brown
>
>> > Doing this through the regulator API avoids hard coding details of an
>> > individual regulator in your driver and ensures that all users of this
>> > regulator can handle the ramp rate.
>
>> Making regulator API wait for the ramp up seems to be something like
>> "synchronous I/O", which in turn, forces CPU to do nothing while CPU
>> may execute some instructions while waiting for the ramp up. However,
>
> Yeah, I know, but even if the actual delay is implemented in the
> consumer driver the ramp time should still be being queried via the
> regulator API so that the details of the specific device aren't hard
> coded into the consumer. ?In any case as you say...
>
>> we just do udelay() anyway; thus, it doesn't matter for us as well.
>> I'll try to put those udelay into MAX8998 PMIC drivers, which is for
>> S5PV210. I'll remove these udelay and PMIC_RAMP)UP from cpufreq driver
>> with the next version.
>
> ...the ramp times are usually vanishingly small so the overwhelming
> majority of consumers probably don't care anyway. ?If it's a problem we
> can add an interface which doesn't do the delay automatically but for
> most users it's going to be simpler to just deal with it transparently.

It's about 30us in this driver (100MHz -> 1GHz), where we lost about
60000 instructions (2 instructions / cycle @ 100MHz, with default RAMP
UP of 10mV/us). However, let's assume that it's ok for now.

>
>> >> + ? ? ? ? ? ? ? ? ? ? ? regulator_set_voltage(arm_regulator,
>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? arm_volt, arm_volt);
>
>> > You shouldn't be specifying an exact voltage here - there's no guarantee
>> > that the exact voltage you request will be delivered by the regulator,
>> > and some boards may wish to use constraints to eliminate some voltages
>> > (eg, to restrict the maximum operating point for the CPU).
>
>> > What you'd normally have here is that the minimum voltage would be the
>> > desired operating point for the CPU and the maximum voltage would be
>> > fixed at the maximum rated supply for the part. ?This will allow the
>> > regulator API to select the lowest voltage it is able to deliver.
>
>> Currently, there is a bug in MAX8998 PMIC driver that sets VDDARM to
>> minimum possible voltage that is LARGER THAN or EQUAL TO max_vol, not
>> min_vol. I'll correct set_voltage usage of CPUFREQ assuming that
>> bugfix for MAX8998 PMIC driver is sent. (Joonyoung Shim, who's just
>> started submitting MAX8998 PMIC driver, know about this issue and will
>> probably send a patch soon.)
>
> Oh, fail. ?Like you say that's a bug in the regulator driver which will
> hopefully be fixed before this gets merged.
>
>> Besides, the whole section enclosed by this CONFIG_REGULATOR will be removed.
>
>> A while ago, WM8994 had been using CLK_OUT as the clock source with
>> APLL dependent setting; thus "target" function accessed CLK_OUT when
>> APLL changed. However, it no longer uses APLL dependent clock source
>> and we no longer access CLK_OUT at the "target" function; thus, this
>> code in "init" function can be removed.
>
> Ah, OK. ?If other people use that sort of clocking scheme we will need
> to come up with a reasonable way of coping with it, but let's save that
> for when the problem arises.

Such people may use cpufreq_notify_transition(freq,
CPUFREQ_PRECHANGE/POSTCHANGE). Some display drivers have been using
this feature to adjust clock settings when APLL clock speed changes.
Sound drivers with CLK_OUT should've used that, too.

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
