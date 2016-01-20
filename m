From: lakshmi.sai.krishna.potthuri@xilinx.com (Lakshmi Sai Krishna Potthuri)
Date: Wed, 20 Jan 2016 05:21:24 +0000
Subject: [LINUX PATCH 1/5] mmc: Workaround for the issue in auto tuning
 mode.
In-Reply-To: <CAGb2v655SF-CUbZKKTif0toHqJ61Z4P4_QzQacfQL9EN0Y0zZQ@mail.gmail.com>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
 <CAGb2v655SF-CUbZKKTif0toHqJ61Z4P4_QzQacfQL9EN0Y0zZQ@mail.gmail.com>
Message-ID: <4FF8F58FAA9D5D4193D4E554E4352C5902C52798@XAP-PVEXMBX02.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: Chen-Yu Tsai [mailto:wens at csie.org]
> Sent: Tuesday, January 19, 2016 8:32 PM
> To: Lakshmi Sai Krishna Potthuri
> Cc: Michal Simek; Soren Brinkmann; Ulf Hansson; Kevin Hao; Emil P. Lenchak;
> Tobias Klauser; Sudeep Holla; Adrian Hunter; Jisheng Zhang; Ivan T. Ivanov;
> Scott Branden; Vincent Yang; Haibo Chen; Marek Vasut;
> ludovic.desroches at atmel.com; Rob Herring; Pawel Moll; Mark Rutland; Ian
> Campbell; Kumar Gala; Suman Tripathi; Shawn Lin; devicetree; Harini
> Katakam; linux-mmc at vger.kernel.org; linux-kernel; Lakshmi Sai Krishna
> Potthuri; Anirudha Sarangi; Punnaiah Choudary Kalluri; linux-arm-kernel
> Subject: Re: [LINUX PATCH 1/5] mmc: Workaround for the issue in auto
> tuning mode.
>
> Hi,
>
> On Tue, Jan 19, 2016 at 10:17 PM, P L Sai Krishna
> <lakshmi.sai.krishna.potthuri@xilinx.com> wrote:
> > During the auto tuning mode of SDR104, a couple of transactions on
> > rx_tap_value which are not incremental or decremental by 1.
> > Since the DLL supports only increment/decrement by 1 during dynamic
> > change, observed unexpected delays during both these transactions.
> > The first transaction occurs when the tap value reached 0x1F, it will
> > reset to 0x0 and go till 0x7. This transaction can be avoided by
> > changing the corecfg_dis1p5xtuningcnt to 1'b1 which is currently tied
> > to 1'b0 in the RTL.
> > The second transaction occurs after the tuning is completed.
> > Once the tuning is done, the tuning fsm in the host controller
> > calculates the average pattern match and will write the value on the
> > rx tap value. Therefore observed a transaction from 0x7 to the final
> > value which need not be a increment/decrement value.
> > Because of this issue DLL tuning will not be accurate and SDR50,
> > SDR104 & HS200 modes may not work.
> >
> > This patch adds workaround to change the SD clock after tuning done to
> > provide accurate DLL tuning for SDR50,
> > SD104 & HS200 modes.
> >
> > After receiving the tuning done, program "SDCLK Frequency Select"
> > of clock control register with a value different from the desired
> > value. Wait for the "Internal Clock Stable" bit of the clock control
> > register and program the desired frequency.
>
> Does this series apply to any non-Arasan or non-sdhci mmc hosts?
> The subject does not indicate a specific platform.

This series is applicable only for Zynq Ultrascal+ MPSoC which
uses Arasan SDHCI.
Sorry, I will change the description to indicate the same.
The DT property used is made generic but the tuning used is
Specific to this SoC.

Regards
Sai Krishna


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
