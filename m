From: lakshmi.sai.krishna.potthuri@xilinx.com (Lakshmi Sai Krishna Potthuri)
Date: Wed, 20 Jan 2016 06:02:12 +0000
Subject: [LINUX PATCH 1/5] mmc: Workaround for the issue in auto tuning
 mode.
In-Reply-To: <20160119175757.GR19062@n2100.arm.linux.org.uk>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
 <20160119175757.GR19062@n2100.arm.linux.org.uk>
Message-ID: <4FF8F58FAA9D5D4193D4E554E4352C5902C527CE@XAP-PVEXMBX02.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Tuesday, January 19, 2016 11:28 PM
> To: Lakshmi Sai Krishna Potthuri
> Cc: Michal Simek; Soren Brinkmann; Ulf Hansson; Kevin Hao; Emil P. Lenchak;
> Tobias Klauser; Sudeep Holla; Adrian Hunter; Jisheng Zhang; Ivan T. Ivanov;
> Scott Branden; Vincent Yang; Haibo Chen; Marek Vasut;
> ludovic.desroches at atmel.com; Rob Herring; Pawel Moll; Mark Rutland; Ian
> Campbell; Kumar Gala; Suman Tripathi; Shawn Lin;
> devicetree at vger.kernel.org; Harini Katakam; linux-mmc at vger.kernel.org;
> linux-kernel at vger.kernel.org; Lakshmi Sai Krishna Potthuri; Anirudha
> Sarangi; Punnaiah Choudary Kalluri; linux-arm-kernel at lists.infradead.org
> Subject: Re: [LINUX PATCH 1/5] mmc: Workaround for the issue in auto
> tuning mode.
>
<snip>
> > +
> > +   /*
> > +    * As per controller erratum, program the SDCLK Frequency
> > +    * Select of clock control register with a value, say
> > +    * clock/2. Wait for the Internal clock stable and program
> > +    * the desired frequency.
> > +    */
> > +   host->ops->set_clock(host, clock/2);
>
> The comment above says "wait for the internal clock stable" - I see no wait in
> here.  Does the code actually conform with the comment?

Wait for internal clock stable is taken care of inside
set_clock()

<snip>
> > +   if ((host->quirks2 & SDHCI_QUIRK2_BROKEN_TUNING) &&
> > +           (tuning_loop_counter >= 0) && (ctrl &
> SDHCI_CTRL_TUNED_CLK)) {
> > +           host->ops->tune_clk(host);
> > +   }
>
> Do we need this "SDHCI_QUIRK2_BROKEN_TUNING" quirk at all?  What's
> wrong
> with:
>
>       if (host->ops->tune_clk && tuning_loop_counter >= 0 &&
>           ctrl & SDHCI_CTRL_TUNED_CLK)
>               host->ops->tune_clk(host);
>
> here?
>

tune_clock is provided as part of ops and will always be present.
Other users of arasan and this driver might not have tuning broken
And won't use this manual tuning.

Regards
Sai Krishna


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
