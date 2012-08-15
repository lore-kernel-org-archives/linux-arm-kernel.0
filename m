From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Aug 2012 23:31:09 +0800
Subject: [PATCH] pinctrl: imx5: start numbering pad from 0
In-Reply-To: <20120815135947.GC2258@S2101-09.ap.freescale.net>
References: <1344869278-27334-1-git-send-email-shawn.guo@linaro.org>
 <CAKGA1b=DqyZvSre3C4YQ3GM6RuFtFsGWDkF784iKggrNzwiKpg@mail.gmail.com>
 <CAP1dx+zQvBurT9oCmfJ0dGHHV3rbgdy+0Yh_hoPL9jQB8QNxKw@mail.gmail.com>
 <CAKGA1bmHqyDGyvZjEcQ+RO1jHiZNZKNu3BGkyUXzYfwVaySYEQ@mail.gmail.com>
 <CAP1dx+x0_j_f3Pj+9+YHcwoTqjGLXouf7t+SoCCMVGKJNOHCPw@mail.gmail.com>
 <20120815054436.GK2232@pengutronix.de>
 <20120815065526.GG19681@shlinux2.ap.freescale.net>
 <20120815075117.GL2232@pengutronix.de>
 <20120815092539.GH19681@shlinux2.ap.freescale.net>
 <20120815135947.GC2258@S2101-09.ap.freescale.net>
Message-ID: <20120815153107.GG2258@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 09:59:50PM +0800, Shawn Guo wrote:
> On Wed, Aug 15, 2012 at 05:25:40PM +0800, Dong Aisheng wrote:
> > On Wed, Aug 15, 2012 at 03:51:17PM +0800, Uwe Kleine-K?nig wrote:
> > > That is just
> > > 
> > > 	#define MX35_PAD_COMPARE__SDMA_EXTDMA_2 11
> > > 
> > > vs.
> > > 
> > > 	#define MX35_PAD_COMPARE__SDMA_EXTDMA_2 0x32c, 0x008, 7, 0x0, 0
> > > 
> > > isn't it? (Actually I'd not go for cpp as preprocessor, but that's a
> > > different story.)
> > > 
> > Hmm, not sure if dt macro may support this kind of syntax but yes if it supports.
> > Grant,
> > Do you know if dt macro can support it?
> > 
> I have the same doubt there.  Copied Stephen who might have a better
> insight on this.
> 
Rather than betting how DTC will implement macro, we'd better make the
the safest assumption - it will not support that syntax.  But we can
still work our issue, I guess.  Actually, the goal is all about
encoding the data that is currently defined in driver as a big array of
struct imx_pin_reg in device tree.

struct imx_pin_reg {
        u16 pid;
        u16 mux_reg;
        u16 conf_reg;
        u8 mux_mode;
        u16 input_reg;
        u8 input_val;
};

As we will figure out the pid from the mux_reg and conf_reg as below,
it becomes how we encode other fields.  An u64 can just cover them.
That said, the line below in binding doc

  MX35_PAD_COMPARE__SDMA_EXTDMA_2 11

becomes 

  MX35_PAD_COMPARE__SDMA_EXTDMA_2 0x032c000807000000

We should probably have it be mux_reg + mux_mode + conf_reg +
input_reg + input_val or something to have the offset and value coupled.
Anyway, we will still have fsl,pins formatted as <PIN_FUNC_ID CONFIG>,
and only difference is PIN_FUNC_ID becomes an u64 integer.  But it can
save us that big array from the driver.

> > Now I'm a bit intend to admit that we probably could do like that if it supports.
> > The benefit i see is that it could save much code lines in driver while having
> > no using experience downgrade.
> > 
> > The left question is that how do we get the pin id from this kind of format data
> > (0x32c, 0x008, 7, 0x0, 0), probably one way may be:
> > For normal pads and NO_CONFIG pads, we could get it via:
> > mux_reg_offset / 4
> > for NO_MUX pads but have CONFIG pads, we may get it via:
> > mux_reg_offset / 4 + PIN_NO_MUX_ID_BASE + config_reg_offset /4
> 
> In case of NO_MUX, mux_reg_offset is 0, so the formula becomes:
> 
> 	PIN_NO_MUX_ID_BASE + config_reg_offset / 4
> 
> The question comes to how PIN_NO_MUX_ID_BASE gets determined?
> 
So PIN_NO_MUX_ID_BASE will be: the largest mux_reg_offset / 4 + 1, right?

-- 
Regards,
Shawn
