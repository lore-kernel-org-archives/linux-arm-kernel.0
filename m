From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 4 Jun 2014 12:05:18 +0100
Subject: [PATCH 1/8] mmc: sdhci-st: Intial support for ST SDHCI controller
In-Reply-To: <537E1AB8.9000909@st.com>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
 <1400771902-26553-2-git-send-email-peter.griffin@linaro.org>
 <537E1AB8.9000909@st.com>
Message-ID: <20140604110518.GA1722@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Thanks fo reviewing, see my comments below: -

> >+struct st_mmc_platform_data {
> >+	struct  reset_control	*rstc;
> >+};
> Since it uses the generic reset framework, could we imagine moving
> the reset to the sdhci_pltfm_host struct?
> Doing this, we could get rid of st_mmc_platform_data.

Yes I agree, I will send some RFC patches which moves the reset controller
stuff into the generic code.

For v2 of this series I've removed the reset code, as stih416 doesn't have
seperate reset line each controller, so it will mainly be 
useful for stih407 SoC, which needs additional patches on top of this 
set.

> >+	switch (width) {
> >+	case MMC_BUS_WIDTH_8:
> >+		ctrl |= SDHCI_CTRL_8BITBUS;
> >+		ctrl &= ~SDHCI_CTRL_4BITBUS;
> >+		break;
> >+	case MMC_BUS_WIDTH_4:
> >+		ctrl |= SDHCI_CTRL_4BITBUS;
> >+		ctrl &= ~SDHCI_CTRL_8BITBUS;
> >+		break;
> >+	default:
> >+		ctrl &= ~(SDHCI_CTRL_8BITBUS | SDHCI_CTRL_4BITBUS);
> >+		break;
> You can remove the break here.

Ok, removed in v2

> >+	switch (reg) {
> >+	case SDHCI_CAPABILITIES:
> >+		ret = readl(host->ioaddr + reg);
> >+		/* Support 3.3V and 1.8V */
> >+		ret &= ~SDHCI_CAN_VDD_300;
> >+		break;
> >+	default:
> >+		ret = readl(host->ioaddr + reg);
> 
> Could we use readl_relaxed?

Yes, I've updated to use readl_relaxed in v2

> >+	dev_dbg(&pdev->dev, "SDHCI ST platform driver\n");
> You can remove this I think.

Removed in v2

> >+		host_version, ((host_version & SDHCI_VENDOR_VER_MASK) >>
> >+			       SDHCI_VENDOR_VER_SHIFT));
> Maybe you could change to dev_info here. It might be interresting to
> always have IP version.

Changed to dev_info in v2

Regards,

Peter.
