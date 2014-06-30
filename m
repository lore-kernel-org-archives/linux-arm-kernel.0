From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon, 30 Jun 2014 17:06:16 +0200
Subject: [PATCH v2 1/2] ARM: topology: Use a clock if possible to get the
 CPU frequency
In-Reply-To: <20140630145847.GE28647@lukather>
References: <1404123143-13041-1-git-send-email-maxime.ripard@free-electrons.com>
 <1404123143-13041-2-git-send-email-maxime.ripard@free-electrons.com>
 <20140630102934.GV32514@n2100.arm.linux.org.uk>
 <CAKfTPtC+XcH122AytyZ=x1JVx9THmxCasJLA3Z1e17X_OmH1xA@mail.gmail.com>
 <20140630124919.GC28647@lukather>
 <CAKfTPtCgpc1J888hbqxoaF5UfcUoRwcpokme32WHPpsPAAawUQ@mail.gmail.com>
 <20140630140146.GD28647@lukather>
 <CAKfTPtAu+mSVO8dvg_Z6w_nYWndap+FY5VGKeg-0pae_4JqR=A@mail.gmail.com>
 <20140630145847.GE28647@lukather>
Message-ID: <CAKfTPtDvQJ5i=t8FN0gLQex0yAC4NNgewTnGKdiCeGk7nQwZYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 June 2014 16:58, Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> On Mon, Jun 30, 2014 at 04:48:35PM +0200, Vincent Guittot wrote:
>> On 30 June 2014 16:01, Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
>> > On Mon, Jun 30, 2014 at 03:27:21PM +0200, Vincent Guittot wrote:
>> >> >> >> -             rate = of_get_property(cn, "clock-frequency", &len);
>> >> >> >> -             if (!rate || len != 4) {
>> >> >> >> -                     pr_err("%s missing clock-frequency property\n",
>> >> >> >> -                             cn->full_name);
>> >> >> >> +             clk = of_clk_get(cn, 0);
>> >> >> >> +             if (!IS_ERR(clk))
>> >> >> >> +                     rate = clk_get_rate(clk);
>> >> >>
>> >> >> We need the max frequency as it will be used to weight the different
>> >> >> CPUs capacity. How do you ensure that the current clock rate is the
>> >> >> max one ?
>> >> >
>> >> > Hmm, the clock-frequency attribute in the ePAPR is defined at the
>> >> > current CPU frequency, not the max one.
>> >>
>> >> What means current frequency in device tree when DVFS is involved ?
>> >
>> > The ePAPR states that clock-frequency is supposed to be "the current
>> > clock speed of the CPU in Hertz". It's exactly what my patch add.
>> >
>> > Now, you're right, DVFS would be an issue here with clock-frequency,
>> > but this patch actually makes it easier to deal with, since you only
>> > get a reference to a clock, and you can get its rate at any given
>> > time.
>>
>> and what about using clk_round_rate(clk, ULONG_MAX) ?
>
> Well, the clock itself might generate a frequency higher that what the
> CPU can run at, so I'm not sure it's a valid assumption.

yes, you're right

>
>> We will not be dependent of when we parse DT
>
> You lost me there. clk_round_rate and clk_get_rate are available at
> the same time in the boot process, aren't they?

yes, but  clk_round_rate(clk, ULONG_MAX) will return the max frequency
and not the current one. But as you mentioned, it doesn't ensure that
it's a possible frequency for the core

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
