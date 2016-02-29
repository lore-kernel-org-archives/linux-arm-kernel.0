From: ramesh.shanmugasundaram@bp.renesas.com (Ramesh Shanmugasundaram)
Date: Mon, 29 Feb 2016 09:56:27 +0000
Subject: [PATCH 1/2] can: rcar_can: Add r8a7795 support
In-Reply-To: <56D411A5.9070706@pengutronix.de>
References: <1456737661-20538-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1456737661-20538-2-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <56D411A5.9070706@pengutronix.de>
Message-ID: <SG2PR06MB10380FC567E038EA92D5401EC3BA0@SG2PR06MB1038.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

> On 02/29/2016 10:21 AM, Ramesh Shanmugasundaram wrote:
> > Added r8a7795 SoC support.
> >
> > For smoother bit timing calculation, the rounded clock frequency is
> used.
> 
> Why this? From my point of view this introduces a clock error.

Thanks for the comments. 

Without the rounded clock, can_calc_bittiming returns different BRP values and reports high sampling error percentage. However, the rounded clock shows no such issues and it works fine for all bitrates.

Below is an e.g. from my board for an input clock differs by 2Hz.

root at salvator-x:~# can-calc-bit-timing -c 39999998 rcar_can  
Bit timing parameters for rcar_can with 39.999998 MHz ref clock
nominal                                 real Bitrt   nom  real SampP
Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP Bitrate Error SampP SampP Error      CiBCR
1000000    125   2    3    2   1   5  999999  0.0% 75.0% 75.0%  0.0% 0x40040100
 800000    125   3    4    2   1   5  799999  0.0% 80.0% 80.0%  0.0% 0x60040100
 500000    250   2    3    2   1  10  499999  0.0% 87.5% 75.0% 14.3% 0x40090100
 250000    500   2    3    2   1  20  249999  0.0% 87.5% 75.0% 14.3% 0x40130100
 125000   1000   2    3    2   1  40  124999  0.0% 87.5% 75.0% 14.3% 0x40270100
 100000   1250   2    3    2   1  50   99999  0.0% 87.5% 75.0% 14.3% 0x40310100
  50000   2500   2    3    2   1 100   49999  0.0% 87.5% 75.0% 14.3% 0x40630100
  20000   6250   2    3    2   1 250   19999  0.0% 87.5% 75.0% 14.3% 0x40f90100
  10000  12500   2    3    2   1 500    9999  0.0% 87.5% 75.0% 14.3% 0x41f30100

root at salvator-x:~# can-calc-bit-timing -c 40000000 rcar_can
Bit timing parameters for rcar_can with 40.000000 MHz ref clock
nominal                                 real Bitrt   nom  real SampP
Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP Bitrate Error SampP SampP Error      CiBCR
1000000     50   7    7    5   1   2 1000000  0.0% 75.0% 75.0%  0.0% 0xd0010400
 800000    125   3    4    2   1   5  800000  0.0% 80.0% 80.0%  0.0% 0x60040100
 500000    125   6    7    2   1   5  500000  0.0% 87.5% 87.5%  0.0% 0xc0040100
 250000    250   6    7    2   1  10  250000  0.0% 87.5% 87.5%  0.0% 0xc0090100
 125000    500   6    7    2   1  20  125000  0.0% 87.5% 87.5%  0.0% 0xc0130100
 100000    625   6    7    2   1  25  100000  0.0% 87.5% 87.5%  0.0% 0xc0180100
  50000   1250   6    7    2   1  50   50000  0.0% 87.5% 87.5%  0.0% 0xc0310100
  20000   3125   6    7    2   1 125   20000  0.0% 87.5% 87.5%  0.0% 0xc07c0100
  10000   6250   6    7    2   1 250   10000  0.0% 87.5% 87.5%  0.0% 0xc0f90100

Thanks,
Ramesh
