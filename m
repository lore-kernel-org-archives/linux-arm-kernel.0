From: viresh.linux@gmail.com (viresh kumar)
Date: Wed, 25 Apr 2012 08:32:14 +0530
Subject: [PATCH V3 07/12] ata/sata_mv: Remove conditional compilation of
 clk code
In-Reply-To: <20120424201802.GE3628@n2100.arm.linux.org.uk>
References: <cover.1335266056.git.viresh.kumar@st.com>
 <abbcf661dc58948794839eb0fba1d5a0950ec848.1335266056.git.viresh.kumar@st.com>
 <20120424120019.GE24089@lunn.ch>
 <CAOh2x==YaPxYxigyE=n2weoKHhu4ktGRHHGdzgs2+d1_Lo-D4Q@mail.gmail.com>
 <20120424201802.GE3628@n2100.arm.linux.org.uk>
Message-ID: <CAOh2x==Se4ipK_jexOE_=82=S4p41W9Ek0Om6DrUwctSz-Wcyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 1:48 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Look, it's very very simple.

Thanks for explaining.

> Finally, if a platform has clk API support enabled, and a driver requests
> a clock, and clk_get() returns an error, it means the clock was not found.
> That's a fatal error for the driver, because it means that something is
> wrong in the lookup tables - moreover, it means that _potentially_ someone
> screwed up the clk matching and this device has a clock which needs some
> control, but wasn't found. ?I don't think ignoring that kind of error,
> even by printing a warning, is a particularly good approach - it seems
> to me it makes things fragile. ?What if this missing clock causes the
> bus to your device to ultimately hang?

This is what i was thinking too and thats why floated this version of patch.
But as Andrew said, clk API support is enabled for them, but still they
don't have a clk for sata. To get this working, there are two solutions:
- Create dummy clk for sata for that platform, so clk_get doesn't fail.
- Check for error before every call to clk APIs after clk_get().

Andrew favored the second one. Which means, even on platforms
with clk API defined and clk enable required, if there are some issues
with lookup table, and clk_get() fails, system may hang when registers
are accessed. For this i favored first one.

--
viresh
