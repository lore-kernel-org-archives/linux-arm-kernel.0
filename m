From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 May 2014 12:36:39 -0300
Subject: mx6qsabresd hangs on linux-next
In-Reply-To: <20140506141310.GA2794@dragon>
References: <CAOMZO5DMEqs=zzNGqgKjK7wTJdiNPgEqxsX=TtqKrnpLMzpbDw@mail.gmail.com>
 <20140506141310.GA2794@dragon>
Message-ID: <CAOMZO5DH5d_L-deVu=XmBo9ekq+-g704p7cyayLvp=43bnEccQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 6, 2014 at 11:13 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Mon, May 05, 2014 at 07:50:24PM -0300, Fabio Estevam wrote:
>> Hi,
>>
>> I am running linux-next 20140505 on a mx6qsabresd and I am getting the
>> following hang after ldb is bound:
>>
>> imx-ipuv3 2400000.ipu: IPUv3H probed
>> imx-ipuv3 2800000.ipu: IPUv3H probed
>> [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
>> [drm] No driver support for vblank timestamp query.
>> imx-drm display-subsystem.11: bound imx-ipuv3-crtc.0 (ops ipu_crtc_ops)
>> imx-drm display-subsystem.11: bound imx-ipuv3-crtc.1 (ops ipu_crtc_ops)
>> mmc1: new SDHC card at address e7ac
>> mmcblk0: mmc1:e7ac SD04G 3.69 GiB
>> imx-drm display-subsystem.11: bound imx-ipuv3-crtc.2 (ops ipu_crtc_ops)
>>  mmcblk0: unknown partition table
>> imx-drm display-subsystem.11: bound imx-ipuv3-crtc.3 (ops ipu_crtc_ops)
>> imx-hdmi 120000.hdmi: Detected HDMI controller 0x13:0xa:0xa0:0xc1
>> imx-drm display-subsystem.11: bound 120000.hdmi (ops hdmi_ops)
>> imx-drm display-subsystem.11: bound ldb.10 (ops imx_ldb_ops)
>>
>> (... system hangs)
>
> I'm seeing the same issue here.  It seems to be caused by some clk
> divider code change.  I'm looking into it further.

Indeed, if I revert:

commit e7489693b3a853ab6dfad52f7e6af553ae8d3f28
Author: Maxime COQUELIN <maxime.coquelin@st.com>
Date:   Wed Jan 29 17:24:08 2014 +0100

    clk: divider: Optimize clk_divider_bestdiv loop

    Currently, the for-loop used to try all the different dividers to find the
    one that best fit tries all the values from 1 to max_div,
incrementing by one.
    In case of power-of-two, or table based divider, the loop isn't optimal.

    Instead of incrementing by one, this patch provides directly the
next divider.

    Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
    Signed-off-by: Mike Turquette <mturquette@linaro.org>

Then the board does not hang.

Maxime, Mike

Any suggestion?
