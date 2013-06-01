From: csd@broadcom.com (Christian Daudt)
Date: Fri, 31 May 2013 17:17:36 -0700
Subject: [PATCH V4 2/3] ARM: mmc: bcm281xx SDHCI driver
In-Reply-To: <87d2s7ceh0.fsf@octavius.laptop.org>
References: <1369860607-25572-1-git-send-email-csd@broadcom.com>
 <1369860607-25572-2-git-send-email-csd@broadcom.com>
 <87d2s7ceh0.fsf@octavius.laptop.org>
Message-ID: <51A93DA0.3070909@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,
On 13-05-31 09:15 AM, Chris Ball wrote:
>
> Could you investigate replacing this section of code with a call to
> mmc_of_parse(), please?  It should be able to replace your parsing
> and handling of bus-width, cd-gpios, wp-gpios, and non-removable
> (other than the initialization quirks specific to your hardware).
>
> I'd like to avoid every driver having its own DT parsing.
> Thanks,
>
> - Chris.
I looked into it and it can replace just about everything that our own 
dt parsing code is doing. The only problem is with cd_gpio. If I call 
mmc_of_parse, then it will install its own irq handler for cd gpio, and 
our driver needs a different handler. the mmc irq handler can call a 
card_event callback, but that is already pointing to sdhci_card_event. 
So the only way I can use mmc_of_parse that I can see is by adding a 
flag to it to skip cd_gpio parsing which only this driver will then set 
to true. Any other ideas ?

  Thanks,
    csd
