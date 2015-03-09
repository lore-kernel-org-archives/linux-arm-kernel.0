From: neilb@suse.de (NeilBrown)
Date: Mon, 9 Mar 2015 11:06:53 +1100
Subject: twl4030_charger: need changes to get probed?
In-Reply-To: <20150307210102.GL5233@earth>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043352.4243.11227.stgit@notabene.brown>
 <20150302210926.GP13270@amd>
 <20150305173350.50502b95@notabene.brown>
 <20150306212417.GA24169@amd> <20150307210102.GL5233@earth>
Message-ID: <20150309110653.7532613c@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 7 Mar 2015 22:01:02 +0100 Sebastian Reichel <sre@debian.org> wrote:

> Hi,
> 
> On Fri, Mar 06, 2015 at 10:24:17PM +0100, Pavel Machek wrote:
> > According to n900 dts, twl4030-bci (aka charger) should be
> > included.
> 
> its part of twl, but not used on N900 afaik.
> 
> > (But it does not seem to do anything useful on n900. I was hoping for
> > measurement of input voltage, but .. no.)
> 
> check for rx51-battery.
> 
> > Any ideas why the patch below is needed?
> 
> platform_driver_probe() does not support deferred probing.
> 
> Neil, can you take this patch into your series for the next round?

I could, but I do wonder if it is the right thing to do.

Shouldn't we fix platform_driver_probe() to support deferred probing.

As I understand it, it refused to retry a probe if there is an error, and the
comments suggest that such retrying is avoided because it would be a waste
of time:

	/*
	 * Prevent driver from requesting probe deferral to avoid further
	 * futile probe attempts.
	 */

In this case, it isn't futile.

Earlier there is a comment saying:

 * Use this instead of platform_driver_register() when you know the device
 * is not hotpluggable and has already been registered, and you want to
 * remove its run-once probe() infrastructure from memory after the driver
 * has bound to the device.

I presume all this applies.  I assume that the only problem is a probe-order
thing.  So maybe we should fix platform_driver_probe() to do the right thing
with -EPROBEDEFER??

Trouble is, I really don't understand the  point or mechanism for
platform_driver_probe(), so I cannot suggest anything.
But I have been annoyed before that platform_driver_probe doesn't cope with
EPROBEDEFER, so I would like it fixed.

NeilBrown
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150309/74073678/attachment.sig>
