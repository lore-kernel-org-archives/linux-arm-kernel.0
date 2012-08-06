From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 6 Aug 2012 17:00:39 +0100
Subject: [PATCH 6/6] Input: ab8500-ponkey: Make the distinction between
 DT and non-DT boots
In-Reply-To: <1344250002-6011-7-git-send-email-lee.jones@linaro.org>
References: <1344250002-6011-1-git-send-email-lee.jones@linaro.org>
 <1344250002-6011-7-git-send-email-lee.jones@linaro.org>
Message-ID: <20120806160039.GE29272@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 11:46:42AM +0100, Lee Jones wrote:
> If we're booting with Device Tree enabled, we want the IRQ numbers to
> be taken and translated from the Device Tree binary. If not, they
> should be taken from the resource allocation defined in the AB8500 MFD
> core driver.

>  	ponkey->ab8500 = ab8500;
> -	ponkey->irq_dbf = ab8500_irq_get_virq(ab8500, irq_dbf);
> -	ponkey->irq_dbr = ab8500_irq_get_virq(ab8500, irq_dbr);
> +
> +	ponkey->irq_dbf = (np) ? ab8500_irq_get_virq(ab8500, irq_dbf) : irq_dbf;
> +	ponkey->irq_dbr = (np) ? ab8500_irq_get_virq(ab8500, irq_dbr) : irq_dbr;

Shouldn't the irq domain be coping with this?  It seems like a massive
failure to have to do this in every single user, the irq domain should
be able to encapsulate all this stuff.
