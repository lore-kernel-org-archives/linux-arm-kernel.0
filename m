From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Fri, 16 Jul 2010 18:01:51 +0900
Subject: [PATCH 5/5] ARM: S5PV210: Initial CPUFREQ Support
In-Reply-To: <20100716084231.GF9082@rakim.wolfsonmicro.main>
References: <1279184768-28971-1-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-2-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-3-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-4-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-5-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-6-git-send-email-myungjoo.ham@samsung.com>
	<20100715115942.GA15919@sirena.org.uk>
	<AANLkTinrrXlh1GQ178_NzwWt5luO_1mdfIGy6G2ZNbPH@mail.gmail.com>
	<20100716081707.GA9082@rakim.wolfsonmicro.main>
	<AANLkTikYX6N7q3lT5ZzXh3RQnGss39eGhSrfC9blqoF_@mail.gmail.com>
	<20100716084231.GF9082@rakim.wolfsonmicro.main>
Message-ID: <AANLkTikNCOjOSVlcBv99DuJEdPtQHmKpC8Cs60rQz1r3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 5:42 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Jul 16, 2010 at 05:30:03PM +0900, MyungJoo Ham wrote:
>> On Fri, Jul 16, 2010 at 5:17 PM, Mark Brown
>
>> > ...the ramp times are usually vanishingly small so the overwhelming
>> > majority of consumers probably don't care anyway. ?If it's a problem we
>> > can add an interface which doesn't do the delay automatically but for
>> > most users it's going to be simpler to just deal with it transparently.
>
>> It's about 30us in this driver (100MHz -> 1GHz), where we lost about
>> 60000 instructions (2 instructions / cycle @ 100MHz, with default RAMP
>> UP of 10mV/us). However, let's assume that it's ok for now.
>
> Is the ramp actually required for systems? ?The obvious thought here is
> that if the ramp time can be reduced or eliminated by configuring the
> regulator it'd be better to do that.
>

It appears that the ramp is actually required. Without ramp, the
driver has no idea about the voltage change delay, which can be
hazardous when the supplied voltage is required to increase. For
example, when the CPU goes from 100MHz to 1GHz, the supplied voltage
goes from 0.95V to 1.25V. After setting the voltage to 1.25V from
0.95V, CPUFREQ sets the frequency to 1GHz. However, at 1GHz, CPU may
fail (and locks up) if the supplied voltage is lower than 1.25V
(regulator voltage is still climbing).

Yes, with RAMP off, the voltage goes up to 1.25V very fast (appears to
be less than 1mV/us in our hardware), but not fast enough to prevent
executing some (about a hundred or thousand?) instructions. Thus,
codes after setting the clock to 1GHz are executed while the supplied
voltage it not enough. Then, CPU may fail although the probability
wouldn't be high enough to be seen frequently.

RAMP feature makes this delay deterministic lets us predict the
behavior and prevent running at higher frequency when the voltage is
not stabilized.


>> > Ah, OK. ?If other people use that sort of clocking scheme we will need
>> > to come up with a reasonable way of coping with it, but let's save that
>> > for when the problem arises.
>
>> Such people may use cpufreq_notify_transition(freq,
>> CPUFREQ_PRECHANGE/POSTCHANGE). Some display drivers have been using
>> this feature to adjust clock settings when APLL clock speed changes.
>> Sound drivers with CLK_OUT should've used that, too.
>
> Depending on how the clocking is integrated it might need to be bound a
> bit tighter to the CPU management code, though. ?If it's supplying a
> clock for the CPU then it may need the CPU to be quiesced before you can
> alter the output.
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
