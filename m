From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 31 Jan 2011 11:31:11 +0100
Subject: [PATCH] mmci: calculate remaining bytes at error correctly
In-Reply-To: <20110131102726.GA8948@n2100.arm.linux.org.uk>
References: <1296137666-30906-1-git-send-email-linus.walleij@stericsson.com>
	<20110130212856.GA32737@n2100.arm.linux.org.uk>
	<AANLkTi=HzzOkVmD9z=9uRdzHsaixFAfOv9BmxoY=u7uf@mail.gmail.com>
	<20110131102726.GA8948@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinBbXN-fxppo1Pa33DxiS6QYSdwqFsadFDxmPPy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/31 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> > - ? ? ? if (status & MCI_DATAEND) {
>> > + ? ? ? if (status & MCI_DATAEND || data->error) {
>> > ? ? ? ? ? ? ? ?mmci_stop_data(host);
>>
>> The hardware always sets the MCI_DATAEND bit if there is
>> some error, so these flags always appear simultaneously, but
>> it doesn't hurt to take some extra precaution, so
>
> The hardware may do, but you won't see that here. ?When we setup a
> transfer, we do this:
>
> ? ? ? ?writel(readl(base + MMCIMASK0) & ~MCI_DATAENDMASK, base + MMCIMASK0);

Ah! I get it.

We've actually played around with that, having MCI_DATAEND on all the
time, it's not necessary any more since we're not using the blockend IRQ
and they cannot race, so we can take a little bit of quirking out of it.
But I'll get back on that issue.

Thanks,
Linus Walleij
