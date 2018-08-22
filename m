From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Wed, 22 Aug 2018 06:53:14 +0000
Subject: [RFC] clk: imx6: Mark imx_clk_mux as glitchy by default
In-Reply-To: <CAOMZO5Dr9NUXuu+LECp2QHZLRhfbymHK23yCCFW-9jB=VXNn+A@mail.gmail.com>
References: <e56c6f0acfe7afb885d2cb67e1e069f7edd0d2d7.1534879459.git.leonard.crestez@nxp.com>
 <CAOMZO5Dr9NUXuu+LECp2QHZLRhfbymHK23yCCFW-9jB=VXNn+A@mail.gmail.com>
Message-ID: <c0966648ef0a15672ddd617de87692f71a19bad4.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-08-21 at 19:42 -0300, Fabio Estevam wrote:
> Hi Leonard,
> 
> On Tue, Aug 21, 2018 at 4:34 PM, Leonard Crestez
> <leonard.crestez@nxp.com> wrote:
> 
> > More concretely on 6qp-sdb blanking the display happens like this:
> >  * imx_ldb_encoder_disable switches ipu1_di0_sel to ipu1_di0_pre from ldb_di1_podf
> >  * reparenting to ipu1_di0_pre enables it and its parents up to pll5
> >  * possibly glitchy muxing
> >  * ipu_di_disable disables ipu1_di0 (and parents, up to pll5)

> We have already taken care of it in these commits:
>     clk: imx6: Fix procedure to switch the parent of LDB_DI_CLK
>     clk: imx6: Make the LDB_DI0 and LDB_DI1 clocks read-only

That's for ldb_di{0,1}_sel, this is for ipu{1,2}_di{0,1}_sel.

On imx6q the ldb_di{0,1}_sel mux has an improperly placed gate and a
special switch procedure needs to be performed at boot time. This
design was fixed on 6qp by moving the ldb_di{0,1} gate immediately
after the mux. My tests are on 6qp.

For ipu{1,2}_di{0,1}_sel the ipu{1,2}_di{0,1} gate can be used on all
chips, it's just that the drm driver doesn't do this. Adding the
CLK_SET_RATE_PARENT flag exposes the issue by returning errors.

> I think we should also take care of the other glitchy muxes as
> you propose here.
>
> Have you seen such glitch issue in practice with the LDB clocks?

If I run "while true; do rtcwake -m mem -s 5; done" it will hang in ~30
minutes because the "suspend devices" takes too long and RTC alarm
expires. I tracked this down to the clk_set_parent call inside
imx_ldb_encoder_disable: sometimes this takes many seconds.

As far as I can tell this live reparenting is unsafe (RM claims
glitches are possible) and not useful (we're deactivating the display
anyway). However I'm not sure this can be blamed on a "glitch".

What seems to be happening is that this triggers the enabling of pll5
(yes, on disable) and the usleep from clk_pllv3_wait_lock takes far too
much time to return. This might be an unrelated timekeeping issue, I'll
look into this further.

According to the RM this reparenting is unsafe anyway so we should
avoid it, probably by disabling ipu_di sooner.

--
Regards,
Leonard
