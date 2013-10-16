From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Oct 2013 23:27:12 +0100
Subject: [PATCH v2 1/3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <525EFF15.2010007@boundarydevices.com>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
 <20131003202751.GZ6192@mwanda>
 <20131015131038.GB25034@n2100.arm.linux.org.uk>
 <CAOMZO5BDEFAKue9b94+wCQSk+1V04P9Oz_yrqG5XLZ532L+VUg@mail.gmail.com>
 <20131016170341.GH25034@n2100.arm.linux.org.uk>
 <525EEB06.6080009@boundarydevices.com>
 <20131016202750.GK25034@n2100.arm.linux.org.uk>
 <525EFF15.2010007@boundarydevices.com>
Message-ID: <20131016222712.GM25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 02:03:17PM -0700, Troy Kisky wrote:
> Freescale's kernel(imx_3.0.35_4.1.0) has this code
>
> video/mxc_hdmi.c-/* Workaround to clear the overflow condition */
> video/mxc_hdmi.c-static void mxc_hdmi_clear_overflow(void)
> video/mxc_hdmi.c-{
> video/mxc_hdmi.c-       int count;
> video/mxc_hdmi.c-       u8 val;
> video/mxc_hdmi.c-
> video/mxc_hdmi.c-       /* TMDS software reset */
> video/mxc_hdmi.c: hdmi_writeb((u8)~HDMI_MC_SWRSTZ_TMDSSWRST_REQ,  
> HDMI_MC_SWRSTZ);
> video/mxc_hdmi.c-
> video/mxc_hdmi.c-       val = hdmi_readb(HDMI_FC_INVIDCONF);
> video/mxc_hdmi.c-
> video/mxc_hdmi.c-       if (cpu_is_mx6dl()) {
> video/mxc_hdmi.c-                hdmi_writeb(val, HDMI_FC_INVIDCONF);
> video/mxc_hdmi.c-                return;
> video/mxc_hdmi.c-       }
> video/mxc_hdmi.c-
> video/mxc_hdmi.c-       for (count = 0 ; count < 5 ; count++)
> video/mxc_hdmi.c-               hdmi_writeb(val, HDMI_FC_INVIDCONF);
> video/mxc_hdmi.c-}
>
> So, perhaps you need to move the software reset first.

Just tried that - and yes, it does work (I'm on i.MX 6Solo for which
cpu_is_mx6dl() would return true.)  Well done!

Indeed yes, the workaround in the code Fabio has differs from the
procedure given in the errata.

Note that this gives a new problem: we shouldn't use cpu_is_mx6dl()
in drivers - differences like this should be specified via DT properties.
I think we need this to recognise both fsl,imx6q-hdmi and fsl,imx6dl-hdmi
so that this workaround can detect when its running on a Solo/DL SoC.

Well, I now have quite a pile of patches for the hdmi code. :(
