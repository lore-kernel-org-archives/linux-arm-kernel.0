From: broonie@kernel.org (Mark Brown)
Date: Fri, 24 Oct 2014 17:18:04 +0100
Subject: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
In-Reply-To: <7hd29h8n0o.fsf@deeprootsystems.com>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
 <7hd29h8n0o.fsf@deeprootsystems.com>
Message-ID: <20141024161804.GH3729@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 09:12:39AM -0700, Kevin Hilman wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:

> > There may be more than one device in a PM domain which then will be
> > probed at different points in time.

> > Depending on timing and runtime PM support, in for the device related
> > driver/subsystem, a PM domain may be advised to power off after a
> > successful probe sequence.

> > A general requirement for a device within a PM domain, is that the
> > PM domain must stay powered during the probe sequence. To cope with
> > such requirement, let's add two new APIs, dev_pm_domain_get|put().

> I'm confused. Why arent' pm_runtime_get*() and pm_runtime_put*() working?

> What's not explained here (or what I'm not understanding) is why a PM
> domain is powering off if it has active devices.

The issue AIUI is what happens during system boot - if one device in a
domain probes and marks itself runtime idle then that will trigger
domain powerdown even if there is another device in the domain that
hasn't yet been probed.  This can cause undesirable glitches (or worse)
during boot depending on what's getting powered down.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141024/5545a19c/attachment.sig>
