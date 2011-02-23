From: sakari.ailus@maxwell.research.nokia.com (Sakari Ailus)
Date: Wed, 23 Feb 2011 22:09:05 +0200
Subject: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during fault
	handling
In-Reply-To: <AANLkTi=s-p3OQfzor27sf-qqqNxipSrOAEQtPQEGaO=L@mail.gmail.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>	<1297884951-3019-3-git-send-email-dacohen@gmail.com>	<AANLkTikZu+pqwpPXExFirPouN+1i3Yp0QHfomHN4decx@mail.gmail.com>	<AANLkTi=C01Yf9rQN1uxMptFyOrwqxJWt+quJ8ipiM+k6@mail.gmail.com>
	<AANLkTi=s-p3OQfzor27sf-qqqNxipSrOAEQtPQEGaO=L@mail.gmail.com>
Message-ID: <4D656961.7080105@maxwell.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guzman Lugo, Fernando wrote:
> Hi,

Hi Fernando,

> In OMAP4 the cortex M3 is a double core processor and as each core is
> running they own version of the RTOS we threat them independently. So
> our driver which controls the remote processor sees two processor but
> both use the same iommu hw. When a iommu fault happens, at this
> moment, it is consider as a faltal error and it is no managed to
> recover and continue, instead a restart of the processor is needed, if
> the fault happens in core0 we need to reset core1 too and vice versa.
> if the iommu would support several user callbacks, we can register the
> callback which resets core0 and also the callback which resets core1
> and treat them as totally independent processors. Also we have an
> error event notifier driver, which is only in charge of notifying
> error events to userspace, so we would have multiple callbacks we
> could do this

The original purpose of the patch, as far as I understand, is to allow
getting useful information for debugging purposes should an iommu fault
happen.

Also, I'm not sure it's necessarily a good idea to just go and reset
the M3 cores in case an iommu fault happens --- this is very probably a
grave bug in the software running on those M3s. It should be fixed
instead of just hiding it. There will be consequences to host side as
well, won't there?

> iommu <---- register fault callback for error notify driver
> 
> instead of
> 
> iommu <--- register fault callback for remote processor driver
> <----register fault event for error notify driver.
> 
> with that, we remove one dependency of the errornotify driver.

I suppose this is not in mainline?

Regards,

-- 
Sakari Ailus
sakari.ailus at maxwell.research.nokia.com
