From: prakity@marvell.com (Philip Rakity)
Date: Tue, 7 Jun 2011 16:51:07 -0700
Subject: [PATCH v2 1/3] mmc: support sdhci-mmp2
In-Reply-To: <BANLkTi=S=Q+AdKECCHg2u6X=VWEOtEox_w@mail.gmail.com>
References: <1306315367-15602-1-git-send-email-zhangfei.gao@marvell.com>
	<201105271746.04775.arnd@arndb.de>
	<BANLkTi=S=Q+AdKECCHg2u6X=VWEOtEox_w@mail.gmail.com>
Message-ID: <86F2B225-A55D-41D9-B805-41C639C1882C@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On May 29, 2011, at 10:42 PM, zhangfei gao wrote:

>> 
>> There is a little room for simplification, I think:
>> 
>>> +static unsigned int mmp2_get_ro(struct sdhci_host *host)
>>> +{
>>> +     /* Micro SD does not support write-protect feature */
>>> +     return 0;
>>> +}
>> 
>> You shouldn't need to provide an empty get_ro function, the
>> default is that there is no write-protect.
> 
> Thanks Arnd for review.
> The reason to put get_ro here is some board use micro sd, while some
> board design is general sd card.
> The micro sd do not use write-protect, while SDHCI_WRITE_PROTECT will
> return 1 in our controller, so it shows read only.
> So add one call back for the board with micro sd card via flag.



The code sets get_ro is for all the controllers.   Some board designs may connect the WP signal.

The host->ops field should be filled in using information in the board
file using a flag such as the example with  PXA_FLAG_CARD_PERMANENT.

eg

	if (pdata && pdata->flags & PXA_FLAG_NO_WP) {
		***** etc ****
	}
