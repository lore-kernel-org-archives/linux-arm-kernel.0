From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 4 Apr 2015 09:04:05 -0700
Subject: [PATCH 2/2] sunxi: a20-LIME2 define board specific operating
 points
In-Reply-To: <20150404140647.GO14618@lukather>
References: <55143D0D.6030104@gmail.com> <20150330231704.GB23664@lukather>
 <551F9E99.9060307@gmail.com> <20150404140647.GO14618@lukather>
Message-ID: <CAGb2v67B9Pw98+i28=-w0j9-1RF79dX1cyf89ruyBTHM1T1CbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 4, 2015 at 7:06 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Apr 04, 2015 at 09:19:37AM +0100, Iain Paton wrote:
>> On 31/03/15 00:17, Maxime Ripard wrote:
>> > On Thu, Mar 26, 2015 at 05:08:29PM +0000, Iain Paton wrote:
>> >> these settings override the inappropriate ones in the dtsi with the
>> >> manufacturers provided settings from their 3.4.x fex file for this board
>> >
>> > Inappropriate how?
>>
>> inappropriate in that the dtsi sets values that cause the board to lockup
>> or to be unstable
>
> And it's the whole point of it. If the DTSI sets inappropriate values
> that locks up your system, then it's because the board uses this
> regulator. If the board uses it, appropriate values must be defined in
> the board DTS.
>
>> > I'd rather have a better common operating points set and change that
>> > to accomodate all boards, rather than duplicating that information
>> > everywhere.
>>
>> then anything that you have common needs to cope with the worst cases
>> for *all* boards, to the detriment of anything that's capable of doing
>> better. i.e. the smallest most conservative subset.
>>
>> Whether we like it or not, stuff like this is simply going to end up
>> being board specific. You can't easily deal with cases like a particular
>> PCB design requiring an extra 0.05v due to a too-thin trace somewhere
>> without having board-specific knowledge.
>>
>> So rather than us, as software people, trying to second guess the board
>> designers, I believe we should simply use the settings they provide if
>> we have them in the fex files. Likely the manufacturer has tested those
>> settings on a much larger number of boards than we'll ever be able to do.
>
> Except that everything happening with cpufreq is internal to the
> SoC. So unless you can back up the fact that different revisions of
> the SoC *need* different OPPs, then no, we're going to have the same
> for each and every board.
>
>> The default settings for a board need to be reliable for everyone.
>
> Exactly. And the FEX files have been shown wrong already on that.
>
>> >> +  #cooling-cells = <2>;
>> >
>> > This is also defined in the DTSI.
>>
>> Yes, exactly. The point being to completely isolate the board from changes
>> to this section of the dtsi.
>>
>> To further illustrate, let's take a look at the sun7i opp table in your
>> sunxi/for-next tree
>>
>> /* kHz    uV */
>> 960000  1400000
>> 912000  1400000
>> 864000  1300000
>> 720000  1200000
>> 528000  1100000
>> 312000  1000000
>> 144000  900000
>>
>> Comparing to the 38 A20 fex files in https://github.com/linux-sunxi/sunxi-boards
>> as of today
>>
>> boot_freq: 912=37, 1008=1
>> max_freq: 1200=1, 1008=10, 912=27
>> min_freq: 720MHz=7, 408MHz=3, 60MHz=28
>
> Again, the FEX files have been proven wrong several times on this
> already, so using them as argument is not really meaningful in any
> way.
>
>> The dvfs section doesn't define 960MHz in any of the 38 files, so that entry
>> is pure conjecture and likely not properly tested by any of the manufacturers.
>
> That's true. Feel free to edit the DTSI.

Some clarification:

960 MHz / 1.4V was added by me, as that was the value set up by
U-boot mainline. If someone complains it is not stable, then
either we drop it, or someone overrides the OPPs for that specific
board.

Now the fex file dvfs section defines brackets, not points. For
example it says up to 912MHz it can use 1.4V, up to 864MHz it
can use 1.3V, and so on.

With v2 OPP bindings, we should be able to specify brackets
and "boost" frequencies.

>> On the voltage front:
>> 912MHz: 1425=7, 1400=27, 1350=4
>> 864MHz: 1350=7, 1300=27, 1250=4
>> 720MHz: 1300=1, 1250=7,  1200=30
>> 528MHz: 1150=8, 1100=30
>> 312MHz: 1100=8, 1050=27, 1000=3
>>
>> 144MHz is only defined for 12 out of 38 boards
>> 144MHz: 1050=9, 1000=3
>>
>> There are additional settings at 792MHz and 624MHz in the fex files, both
>> defined by 26 out of 38 boards.
>>
>> 1008MHz @ 1450 is defined by all 38.
>
> And has been proven not reliable on some. Do you want to come back on
> that "properly tested by any of the manufacturers" argument?

This one was removed specifically because without regulator support
to boost the voltage, it would not be stable. Boards with regulators
added to the board dts can also add this OPP.

ChenYu

>> To come to a generic subset, we need to exclude things as follows
>> 1. anything greater than the lowest max_freq
>> 2. anything less than the highest min_freq
>> 3. anything less than the highest required voltage at a given frequency
>>
>> That leaves us with this:
>>
>> /* kHz    uV */
>> 912000  1425000
>> 864000  1350000
>> 720000  1300000
>>
>> Even then, we can't guarantee those three will be safe or reliable for
>> everything. The A20 datasheet gives 1.4v as the absolute maximum which
>> means we need to remove the 912MHz completely as some devices require
>> overvolting to reach it and that may be unsafe for the rest.
>>
>> So a generic dtsi subset is limited to
>>
>> /* kHz    uV */
>> 864000  1350000
>> 720000  1300000
>>
>> as that's the subset that covers all devices we have data on and doesn't
>> involve overclocking, overvolting, undervolting, operating outside AllWinner
>> SoC ratings, outside device manufacturer specified settings, and doesn't
>> require any board specific knowledge.
>>
>> So in the case of a generic, not board-specific, dtsi file most of what's
>> currently in the dtsi is inappropriate for a large proportion of devices.
>> The commonality is tiny, without board specific knowledge we can't do any
>> better.
>>
>> While we can be relatively confident the remaining two settings will work on
>> almost all boards, confidence in the other settings is at best uncertain.
>> I certainly have little interest in 7.9% at 312MHz, or 0% at 144MHz
>> possibility of success.
>> While the faster speeds aren't quite so bad, you're still suggesting that
>> 18-21% of boards having problems is ok.
>> Sorry, thats simply not acceptable.
>
> Indeed, and that's not what I'm suggesting at all. What I do suggest
> is to figure out a set of OPPs that are known to be working for
> everyone.
>
> Do you really feel like sunxi is so special and soooo different from
> any other ARM SoC, running on virtually any ARM board on earth but
> sunxi, properly tested (by properly, I do mean properly.), shipped
> into products, and actually using a common set of OPPs?
>
>> I hope this explains my point of view and why I believe this data to be
>> board specific stuff that belongs in the boards dts file and not in the dtsi.
>
> I guess we do have a very different point of view. Yours is "just
> trust whatever the fex file tells us", mine is "fex file is going to
> be wrong/incomplete, let's figure out our own".
>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
