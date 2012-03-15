From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 15 Mar 2012 10:29:45 +0000
Subject: [PATCH v4 03/10] pwm: Add device tree support
In-Reply-To: <201203150840.42659.arnd@arndb.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-4-git-send-email-thierry.reding@avionic-design.de>
 <201203150840.42659.arnd@arndb.de>
Message-ID: <20120315102944.GB3138@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 08:40:42AM +0000, Arnd Bergmann wrote:
> On Wednesday 14 March 2012, Thierry Reding wrote:

> > +static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
> > +{

> > +	return ERR_PTR(-EPROBE_DEFER);
> > +}

> EPROBE_DEFER doesn't exist yet in my kernel, and I wonder if it's actually
> safe to be used this way, because it can result in arbitrary drivers using
> this to be put on the defered probe list. It certainly sounds like the
> right thing to do in the long run though.

Similar code is going in for regulators in 3.4 along with the core
-EPROBE_DEFER change (though not OF specific) and I sent a similar patch
for GPIOs too, hopefully Grant will ack it in time for it to make it in.

My theory is that since you need to explicitly know that the thing
you're requesting is there in order to request it (eg, have a PWM number
or DT link) the overwhemlingly common case for a failure to request will
be that the provider didn't register yet which is exactly the case where
deferral is desired.  It therefore seems sensible to have the framework
default the drivers to retrying rather than have almost every individual
driver look at the failure, figure out if it was a missing provider, and
then retry.  Drivers that have a good reason to fail can always check
for -EPROBE_DEFER and override it.

The result should be that we can take advantage of probe deferral over
large areas of the kernel without having to go and explicitly modify so
many drivers - if the frameworks like GPIO, clk and regulator can do
this that ought to cover 90% of the cases where probe deferral will be
needed without having to do anything more than have good error handling
paths on probe which is a good idea anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120315/09137da3/attachment.sig>
