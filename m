From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 27 Sep 2017 19:00:06 -0300
Subject: [PATCH 1/1] clk: imx6: refine hdmi_isfr's parent to make HDMI
 work on i.MX6 SoCs w/o VPU
In-Reply-To: <1501584007-12433-1-git-send-email-sebastien.szymanski@armadeus.com>
References: <1501584007-12433-1-git-send-email-sebastien.szymanski@armadeus.com>
Message-ID: <CAOMZO5B0U2O_aXmLBavmiU1G-ttxMg=p8+HMjUyQecH2_pZVqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 1, 2017 at 7:40 AM, S?bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:
> On i.MX6 SoCs without VPU (in my case MCIMX6D4AVT10AC), the hdmi driver
> fails to probe:
>
> [    2.540030] dwhdmi-imx 120000.hdmi: Unsupported HDMI controller
> (0000:00:00)
> [    2.548199] imx-drm display-subsystem: failed to bind 120000.hdmi
> (ops dw_hdmi_imx_ops): -19
> [    2.557403] imx-drm display-subsystem: master bind failed: -19
>
> That's because hdmi_isfr's parent, video_27m, is not correctly ungated.
> As explained in commit 5ccc248cc537 ("ARM: imx6q: clk: Add support for
> mipi_core_cfg clock as a shared clock gate"), video_27m is gated by
> CCM_CCGR3[CG8].
>
> On i.MX6 SoCs with VPU, the hdmi is working thanks to the
> CCM_CMEOR[mod_en_ov_vpu] bit which makes the video_27m ungated whatever
> is in CCM_CCGR3[CG8]. The issue can be reproduced by setting
> CCMEOR[mod_en_ov_vpu] to 0.
>
> Make the HDMI work in every case by setting hdmi_isfr's parent to
> mipi_core_cfg.
>
> Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
