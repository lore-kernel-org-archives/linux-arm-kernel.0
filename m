From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Jun 2014 16:01:46 +0200
Subject: [PATCH v2 1/2] ARM: topology: Use a clock if possible to get the
 CPU frequency
In-Reply-To: <CAKfTPtCgpc1J888hbqxoaF5UfcUoRwcpokme32WHPpsPAAawUQ@mail.gmail.com>
References: <1404123143-13041-1-git-send-email-maxime.ripard@free-electrons.com>
 <1404123143-13041-2-git-send-email-maxime.ripard@free-electrons.com>
 <20140630102934.GV32514@n2100.arm.linux.org.uk>
 <CAKfTPtC+XcH122AytyZ=x1JVx9THmxCasJLA3Z1e17X_OmH1xA@mail.gmail.com>
 <20140630124919.GC28647@lukather>
 <CAKfTPtCgpc1J888hbqxoaF5UfcUoRwcpokme32WHPpsPAAawUQ@mail.gmail.com>
Message-ID: <20140630140146.GD28647@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 03:27:21PM +0200, Vincent Guittot wrote:
> >> >> -             rate = of_get_property(cn, "clock-frequency", &len);
> >> >> -             if (!rate || len != 4) {
> >> >> -                     pr_err("%s missing clock-frequency property\n",
> >> >> -                             cn->full_name);
> >> >> +             clk = of_clk_get(cn, 0);
> >> >> +             if (!IS_ERR(clk))
> >> >> +                     rate = clk_get_rate(clk);
> >>
> >> We need the max frequency as it will be used to weight the different
> >> CPUs capacity. How do you ensure that the current clock rate is the
> >> max one ?
> >
> > Hmm, the clock-frequency attribute in the ePAPR is defined at the
> > current CPU frequency, not the max one.
> 
> What means current frequency in device tree when DVFS is involved ?

The ePAPR states that clock-frequency is supposed to be "the current
clock speed of the CPU in Hertz". It's exactly what my patch add.

Now, you're right, DVFS would be an issue here with clock-frequency,
but this patch actually makes it easier to deal with, since you only
get a reference to a clock, and you can get its rate at any given
time.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140630/3955e656/attachment.sig>
