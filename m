From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 14 Mar 2017 20:39:54 +0100
Subject: [PATCH 2/4] crypto: stm32 - Support for STM32 CRC32 crypto module
In-Reply-To: <1489509446-32283-3-git-send-email-fabien.dessenne@st.com>
References: <1489509446-32283-1-git-send-email-fabien.dessenne@st.com>
 <1489509446-32283-3-git-send-email-fabien.dessenne@st.com>
Message-ID: <20170314193954.GA12137@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 05:37:24PM +0100, Fabien Dessenne wrote:
> +static int stm32_crc_remove(struct platform_device *pdev)
> +{
> +	struct stm32_crc *crc = platform_get_drvdata(pdev);
> +
> +	spin_lock(&crc_list.lock);
> +	list_del(&crc->list);
> +	spin_unlock(&crc_list.lock);
> +
> +	crypto_unregister_shash(algs);
> +
> +	if (crc && crc->clk)
> +		clk_disable_unprepare(crc->clk);

Hello

No need to test for crc, if it was NULL, you dereference it just before in list_del.
Furthermore, It seems that clk_disable_unprepare() handle perfectly NULL, so no test is needed.

Regards
Corentin Labbe
