From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 17 Feb 2016 08:52:36 +0100
Subject: [PATCH v5 RESEND 4/5] ARM: amba: Move reading of periphid to
 amba_match()
In-Reply-To: <20160215175250.GJ10826@n2100.arm.linux.org.uk>
References: <1455101250-11327-1-git-send-email-m.szyprowski@samsung.com>
 <1455101250-11327-5-git-send-email-m.szyprowski@samsung.com>
 <20160215175250.GJ10826@n2100.arm.linux.org.uk>
Message-ID: <56C426C4.7040907@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2016-02-15 18:52, Russell King - ARM Linux wrote:
> On Wed, Feb 10, 2016 at 11:47:29AM +0100, Marek Szyprowski wrote:
>> From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>
>> Reading the periphid when the Primecell device is registered means that
>> the apb pclk must be available by then or the device won't be registered
>> at all.
>>
>> By reading the periphid in amba_match() we can return -EPROBE_DEFER if
>> the apb pclk isn't there yet and the device will be retried later.
> I've just realised, we can't do this.  We need to read the peripheral
> ID at registration time, because that's published to userspace via
> (a) a sysfs attribute, and (b) as part of the uevent, which will be
> used by udev to locate the driver module.
>
> So, this will have the side effect of breaking systems which have
> AMBA primecell devices configured as modules.
>
> Sorry, I can't apply this.  We can't regress existing platforms for
> the sake of introducing new platforms to this code.

Then the only solution right now I see is to get back to v1:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/388199.html
which at least handles correctly device registration when power domain 
driver
is available. You pointed that the patch cannot be applied, because failure
of dev_pm_domain_attach() will be fatal for device registration. Right now
lack of such call is fatal for the whole system, so there is really not a
big difference. Please also note that amba_get_enable_pclk() calls 
clk_get(),
which also might return -EPROBE_DEFER, which already breaks device
registration the same way.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
