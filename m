From: a.hajda@samsung.com (Andrzej Hajda)
Date: Fri, 18 Apr 2014 13:27:53 +0200
Subject: [PATCH RFC 3/3] drm/exynos: use pending_components for	components
 tracking
In-Reply-To: <20140417214709.GY24070@n2100.arm.linux.org.uk>
References: <1397734130-21019-1-git-send-email-a.hajda@samsung.com>
 <1397734130-21019-4-git-send-email-a.hajda@samsung.com>
 <20140417214709.GY24070@n2100.arm.linux.org.uk>
Message-ID: <53510C39.1020205@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

Thanks for comments.

On 04/17/2014 11:47 PM, Russell King - ARM Linux wrote:
> On Thu, Apr 17, 2014 at 01:28:50PM +0200, Andrzej Hajda wrote:
>> +out:
>> +	if (ret != -EPROBE_DEFER)
>> +		exynos_drm_dev_ready(&pdev->dev);
> So we end up with everyone needing a "ready" call in each sub-driver
> back into the main driver... this makes it impossible to write a
> generic subcomponent driver which is not tied in any way to the
> main driver.
>
> That is quite some restriction, and would prevent, for example, the
> TDA998x driver being used both with Armada DRM, tilcdc and any other
> driver.

As I see in armada driver drm is deferred in case tda998x is not yet
available. The same solution can be still used with pending_devices
approach - the main driver will not report its readiness until tda998x
is present.

Anyway it still seems to be better than componentize every driver which can
probably become a part of some superdevice.

If you want to get rid of deferred probe one can make global list of
'ready' devices with notifications systems for master devices.

Maybe it would be good to consider notification system for devices probe
result,
it will require that driver register all its interfaces in probe, ie its
readiness cannot
be reported later but will not require to add new framework. I hope just
extending current
notification system should be enough.

Regards
Andrzej
