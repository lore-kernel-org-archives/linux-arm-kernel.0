From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 8 May 2012 23:21:00 -0700
Subject: moving Tegra30 to the common clock framework
In-Reply-To: <d460deebb832d7f62b4298c78ad2b791.squirrel@www.codeaurora.org>
References: <20120503161311.GG20304@tbergstrom-lnx.Nvidia.com>
 <20120507000329.GB14559@gmail.com> <4FA7ECAA.1040104@wwwdotorg.org>
 <CAJOA=zNKDFPOQ9-0EuEy=dtq=g-CKFBq94enTuoB7wVPskbkMg@mail.gmail.com>
 <CAAXpJNsJiT7s87p6jS5bdi-83n4bwSaagdSK0w3SbrVz+k+O0g@mail.gmail.com>
 <CAJOA=zP4iEZ+CFfCjT1rgU6shOt_PUf2BRB76NEQCoUPZJ9hVg@mail.gmail.com>
 <4FA9BD41.2090701@codeaurora.org>
 <d460deebb832d7f62b4298c78ad2b791.squirrel@www.codeaurora.org>
Message-ID: <CAJOA=zPtTTLc9GyPj_xnS6+J-+79mKjKhPgubmiH6Hq9B=tg1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120508-19:20, skannan at codeaurora.org wrote:
> > While set rate is in progress, both the parents might need to stay
> > enabled for a short duration. So, in my internal set rate, I need to
> > check if my clock is prepared/enabled and call prepare/enable on the
> > "old parent", call __clk_reparent (which will reduce the ref count for
> > the old parents and increase it for the new parents), finish the
> > reparent in HW and then unprepare/disable the old parent if I have
> > prepared/enabled them earlier.
> >

The .set_rate implemenation for OMAP's PLLs has the same requirement and
this is handled by nested calls to __clk_prepare and clk_enable.  Please
refer the omap3_noncore_dpll_set_rate definition:

http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=blob;f=arch/arm/mach-omap2/dpll3xxx.c;h=63e92e2d4bb80ea702572b919c17b0ac9f93cc0e;hb=clk-next-omap#l425

> > It might be beneficial to provide something like a
> > __clk_reparent_start(new_parent, *scratch_pointer) and
> > __clk_reparent_finish(*scratch_pointer) if it will be useful for more
> > than just MSM. Based on this email, I would guess that Tegra would want
> > something similar too.
>
> Thinking more about this, I think this is how any clk op that might change
> the parent should operate. I will try to write up an RFC patch for this
> and send it out soon. I'm in a hurry, so will explain more in the RFC
> patch or in a later email.

I'm interested to see your patch, as I might not be fully understanding
your requirements.  Is there any reason why making nested calls to
__clk_prepare and clk_enable from your .set_rate callback isn't enough?

Thanks,
Mike
