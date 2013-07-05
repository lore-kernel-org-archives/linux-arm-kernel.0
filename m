From: james.hogan@imgtec.com (James Hogan)
Date: Fri, 5 Jul 2013 14:12:08 +0100
Subject: [RFC] clk: add flags to distinguish xtal clocks
In-Reply-To: <1372971912-10877-1-git-send-email-coelho@ti.com>
References: <1372971912-10877-1-git-send-email-coelho@ti.com>
Message-ID: <CAAG0J98UL5sLTmRx1o8XnbK8qWv_qNi9+zwuyPBbbYExPSbw8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 July 2013 22:05, Luciano Coelho <coelho@ti.com> wrote:
> Add a flag that indicate whether the clock is a crystal or not.  Since
> no clocks set this flag right now, include an additional flag that
> indicates whether the type is set or not.  If the CLK_IS_TYPE_DEFINED
> flag is not set, the value of the CLK_IS_TYPE_XTAL flag is undefined.
> This ensures backwards compatibility.
>
> Additionally, parse a new device tree binding in clk-fixed-rate to set
> this flag.
>
> Signed-off-by: Luciano Coelho <coelho@ti.com>
> ---
>
> I'm not  familiar with the common clock framework and I'm not
> entirely sure the flags can be used in such a way, but to me it looks
> reasonable, since some clock consumers may need to know what type of
> clock is being provided.
>
> Specifically, the wl12xx firmware needs to know if the clock is XTAL
> or not to handle the stabilization and boosts properly.
>
> My main idea is that I need to pass this information in the device
> tree definition of the clocks, so that the driver can pass this
> information on to the firmware.
>
> Please let me know if this looks ok or not.  If not, please let me
> know if you have any other ideas on how to solve my problem (of
> knowing whether the clock attached to the WiLink chip is XTAL or not).

The TZ1090 SoC has something that sounds possibly similar, where some
of the XTAL pads have a bypass bit, which according to the hardware
engineer I asked should be enabled when you want to use the
corresponding XTAL pads as a clock input pad rather than an
oscillator. I was considering extending clk-fixed-rate (via a wrapper
driver) to parse a custom DT property and a register address / bit
number and set the bypass bit as appropriate itself.

So I was wondering, is there a particular reason you don't have a DT
property on the node for the device that needs to know what type of
clock it is, rather than the clock node itself? That way you're not
depending directly on the generic common clock framework to be able to
tell you such electrical details.

Cheers
James
