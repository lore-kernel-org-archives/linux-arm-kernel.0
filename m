From: ken.lin@advantech.com (Ken.Lin)
Date: Tue, 11 Oct 2016 10:49:33 -0700
Subject: The possible regression in kernel 4.8 - clk: imx: correct AV
 PLL rate formula
In-Reply-To: <WM!8b5ef465717800ac4466674b98bb32450dc231d955cd4979ca96fd54828a7c3af7de5f376015ebf046c75f20677161c6!@dgg.advantech.com>
References: <03B5A3CA1724CE4EAC32B27E39292A677FC5A390AE@AUSMAIL1.AUS.ADVANTECH.CORP>
 <WM!ea1806249edeb2cf70790bb7482fb813b9b7cef636576d9ca4b01897c8831c3650f71356a13ce9ba5e358a69b86f6a82!@dg.advantech.com>
 <CAOMZO5CXTEpNvAhuc2Et60HxfM=nQngMTdMOtDbazi=1EQ95Jw@mail.gmail.com>
 <WM!8b5ef465717800ac4466674b98bb32450dc231d955cd4979ca96fd54828a7c3af7de5f376015ebf046c75f20677161c6!@dgg.advantech.com>
 <03B5A3CA1724CE4EAC32B27E39292A677FC5A39613@AUSMAIL1.AUS.ADVANTECH.CORP>
Message-ID: <WM!8ae38b052eee9a42a4712d13aee34e2d793055d4125e98cc2c03451811f33168b3556d3bf52ee5ba8dda879cea808cdc!@dg.advantech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Thursday, October 6, 2016 4:38 PM
> To: Ken.Lin
> Cc: shawnguo at kernel.org; kernel at pengutronix.de; sboyd at codeaurora.org;
> mturquette at baylibre.com; linux-arm-kernel at lists.infradead.org; linux-
> clk at vger.kernel.org; linux-kernel at vger.kernel.org; Peter.Stretz; Peter.Chiang;
> Akshay Bhat; Jason Moss; emil at limesaudio.com
> Subject: Re: The possible regression in kernel 4.8 - clk: imx: correct AV PLL rate
> formula
> 
> Hi Ken,
> 
> On Thu, Oct 6, 2016 at 8:26 PM, Ken.Lin <ken.lin@advantech.com> wrote:
> > Hi,
> >
> > We found a possible regression issue (not seen in kernel 4.7-stable), which has
> to do with the new NXP commit ba7f4f557eb67ee21c979c8539dc1886f5d5341c
> when we did a DP test (1920x1080 at 60) with clock source PLL5.
> > The DP desired pixel clock (148.5MHz that is calculated from the input of PLL
> output frequency) would be correct again when we reverted this commit.
> > Could you please help check if the commit has the side effect since it would
> have impacts on our on-going project when it requires moving from kernel 4.7
> to kernel 4.8 or newer version?
> >
> > Please check the following URL for the details
> > https://www.dropbox.com/s/7wc5jdp8unlsiob/possible_regression_for_clk_
> > imx_correct_VL_PLL_rate_formula.pdf?dl=0
> 
> Do these patches from Emil fix the issue?
> 
> http://www.spinics.net/lists/arm-kernel/msg535204.html
> 
> and
> 
> http://www.spinics.net/lists/arm-kernel/msg535203.html
> 
> Thanks


With the patches applied, the pixel clock (148500000 required for 1920x1080 at 60) is correct as we checked in kernel 4.7 and the actual measurement result looked good as we expected.
I think the patches should fix the issue.

Ref: /sys/kernel/debug/clk/clk_summary 

    pll5                                  1            1  1039500000          0 0
       pll5_bypass                        1            1  1039500000          0 0
          pll5_video                      1            1  1039500000          0 0
             pll5_post_div                1            1   519750000          0 0
                pll5_video_div            2            2   519750000          0 0
                   ipu2_di1_pre_sel           0            0   519750000          0 0
                      ipu2_di1_pre           0            0   173250000          0 0
                         ipu2_di1_sel           0            0   173250000          0 0
                            ipu2_di1           0            0   173250000          0 0
                   ipu2_di0_pre_sel           0            0   519750000          0 0
                      ipu2_di0_pre           0            0   173250000          0 0
                   ldb_di1_sel            1            1   519750000          0 0
                      ldb_di1_div_3_5           1            1   148500000          0 0
                         ldb_di1_podf           1            1   148500000          0 0
                            ldb_di1           2            2   148500000          0 0
                               ipu2_di0_sel           1            1   148500000          0 0
                                  ipu2_di0           1            1   148500000          0 0
                   ldb_di0_sel            1            1   519750000          0 0
                      ldb_di0_div_3_5           1            1   148500000          0 0
                         ldb_di0_podf           1            1   148500000          0 0
                            ldb_di0           1            1   148500000          0 0


Ref: kernel debug messages

[  113.848959] imx-ipuv3-crtc imx-ipuv3-crtc.6: ipu_crtc_mode_set_nofb: mode->hdisplay: 1920
[  113.857201] imx-ipuv3-crtc imx-ipuv3-crtc.6: ipu_crtc_mode_set_nofb: mode->vdisplay: 1080
[  113.865421] imx-ipuv3-crtc imx-ipuv3-crtc.6: ipu_crtc_mode_set_nofb: attached to encoder types 0x8
[  113.874483] imx-ipuv3 2800000.ipu: disp 0: panel size = 1920 x 1080
[  113.880803] imx-ipuv3 2800000.ipu: Clocks: IPU 264000000Hz DI 75833334Hz Needed 148500000Hz
[  113.889252] imx-ipuv3 2800000.ipu: Want 148500000Hz IPU 264000000Hz DI 75833334Hz using DI, 75833334Hz
[  113.898768] imx-ldb 2000000.aips-bus:ldb at 020e0008: imx_ldb_set_clock: now: 227500000 want: 519750000
[  113.908018] imx-ldb 2000000.aips-bus:ldb at 020e0008: imx_ldb_set_clock after: 519750000
[  113.915886] imx-ldb 2000000.aips-bus:ldb at 020e0008: imx_ldb_set_clock: now: 148500000 want: 148500000
[  113.925050] imx-ldb 2000000.aips-bus:ldb at 020e0008: imx_ldb_set_clock after: 148500000
[  113.932928] imx-ldb 2000000.aips-bus:ldb at 020e0008: imx_ldb_set_clock: now: 519750000 want: 519750000
[  113.942096] imx-ldb 2000000.aips-bus:ldb at 020e0008: imx_ldb_set_clock after: 519750000
[  113.949938] imx-ldb 2000000.aips-bus:ldb at 020e0008: imx_ldb_set_clock: now: 148500000 want: 148500000
[  113.959104] imx-ldb 2000000.aips-bus:ldb at 020e0008: imx_ldb_set_clock after: 148500000

> 
> --
> This message has been scanned for viruses and dangerous content by
> MailScanner, and is believed to be clean.

Thank you


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
