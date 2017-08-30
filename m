From: ian.eperson@dedf.co.uk (ian.eperson at dedf.co.uk)
Date: Wed, 30 Aug 2017 13:53:57 +0100
Subject: [PATCH v2 2/7] memory: atmel-ebi: Simplify SMC config code
Message-ID: <7c857a5fb2c61109d5db9e185f60741a@dedf.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch appears to result in the following code at the end of 
atmel_ebi_xslate_smc_config() ? lines 265++:

	ret = atmel_ebi_xslate_smc_timings(ebid, np, &conf->smcconf);
	if (ret)
		return -EINVAL;

	if ((ret > 0 && !required) || (!ret && required)) {
		dev_err(ebid->ebi->dev, "missing atmel,smc- properties in %s",
			np->full_name);
		return -EINVAL;
	}

	return required;

My understanding is that atmel_ebi_xslate_smc_timings() returns true 
(>0), false (0) or error (<0) so the first test here should be:

	if(ret<0)

Otherwise the logic in the second test can be reduced to:

	if(required)

and some further changes to atmel_ebi_xslate_smc_timings() are needed


Regards



Ian Eperson
DeDf Co Ltd
