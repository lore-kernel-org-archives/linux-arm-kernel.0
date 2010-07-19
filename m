From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 19 Jul 2010 09:40:24 +0900
Subject: [PATCH 5/5] ARM: S5PV210: Initial CPUFREQ Support
In-Reply-To: <20100716093710.GH9082@rakim.wolfsonmicro.main>
References: <1279184768-28971-3-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-4-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-5-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-6-git-send-email-myungjoo.ham@samsung.com>
	<20100715115942.GA15919@sirena.org.uk>
	<AANLkTinrrXlh1GQ178_NzwWt5luO_1mdfIGy6G2ZNbPH@mail.gmail.com>
	<20100716081707.GA9082@rakim.wolfsonmicro.main>
	<AANLkTikYX6N7q3lT5ZzXh3RQnGss39eGhSrfC9blqoF_@mail.gmail.com>
	<20100716084231.GF9082@rakim.wolfsonmicro.main>
	<AANLkTikNCOjOSVlcBv99DuJEdPtQHmKpC8Cs60rQz1r3@mail.gmail.com>
	<20100716093710.GH9082@rakim.wolfsonmicro.main>
Message-ID: <AANLkTine-RPFqd1zp-vu4xRaidhngU0t3hC3SP_bXfWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 6:37 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Jul 16, 2010 at 06:01:51PM +0900, MyungJoo Ham wrote:
>> On Fri, Jul 16, 2010 at 5:42 PM, Mark Brown
>> > On Fri, Jul 16, 2010 at 05:30:03PM +0900, MyungJoo Ham wrote:
>
>> >> It's about 30us in this driver (100MHz -> 1GHz), where we lost about
>> >> 60000 instructions (2 instructions / cycle @ 100MHz, with default RAMP
>> >> UP of 10mV/us). However, let's assume that it's ok for now.
>
>> > Is the ramp actually required for systems? ?The obvious thought here is
>> > that if the ramp time can be reduced or eliminated by configuring the
>> > regulator it'd be better to do that.
>
>> It appears that the ramp is actually required. Without ramp, the
>> driver has no idea about the voltage change delay, which can be
>> hazardous when the supplied voltage is required to increase. For
>
> Sorry, I think you misunderstand - what I mean is that you say this is
> the "default" ramp time which suggests that the ramp time can be
> configured. ?Hopefully one of the options available is to reduce it
> which seems like a win overall since it avoids having to handle the ramp
> in software and reduces the overall state change time.

Uh oh.. I didn't mean that the default ramp time is the "required" or
"suggested" by the PMIC, but I meant that it is required by the CPU to
execute instructions without possible CPU lockups due to lower voltage
with a higher rate (that requires higher voltage). As long as the time
needed to increase the voltage to the required level is not zero, CPU
needs to wait for a while before increasing the rate and with ramp
time, we can make it deterministic. Without ramp time, we need to
assume that the delay with an estimation. In our hardware, we can also
turn off RAMP and let PMIC increase the voltage as soon as possible.
However, I'm sure that the delay is still larger than zero with a
chance of executing hundreds of instructions before the voltage
reaches the required value.

I don't mind how short a regulator can change the voltage. As long as
it is long enough to execute several instructions, it has some chance
to lock up a CPU if we do NOT wait for the change before increasing
the rate. And, the RAMP value guarantees the given wait time is enough
for the drivers.

>
>> Yes, with RAMP off, the voltage goes up to 1.25V very fast (appears to
>> be less than 1mV/us in our hardware), but not fast enough to prevent
>> executing some (about a hundred or thousand?) instructions. Thus,
>> codes after setting the clock to 1GHz are executed while the supplied
>> voltage it not enough. Then, CPU may fail although the probability
>> wouldn't be high enough to be seen frequently.
>
>> RAMP feature makes this delay deterministic lets us predict the
>> behavior and prevent running at higher frequency when the voltage is
>> not stabilized.
>
> Right, you will get a ramp time due to the need to charge the capacitors
> on the output of the DCDC - this applies to pretty much all regulators -
> but it will be very much reduced which does substantially mitigate the
> effects which makes a simpler approach in software much less of a
> problem.
>
> With high performance regualtors the limit is pretty much entirely the
> capacitor on the output, it should actually be predictable and suitable
> for handling within the driver.
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
