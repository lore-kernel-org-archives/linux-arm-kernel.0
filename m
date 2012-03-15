From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 15 Mar 2012 07:41:24 +0100
Subject: [PATCH v4 00/10] Add PWM framework and device tree support.
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020695DB5858@AUSP01VMBX24.collaborationhost.net>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <ADE657CA350FB648AAC2C43247A983F0020695DB5858@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20120315064124.GA20502@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* H Hartley Sweeten wrote:
> Are you planning on adding a sysfs interface for generic userspace access
> to the PWM devices?

I wasn't planning to, but really only because I have no need for it. You
could of course add one yourself.

> Anyway, I would be happy to convert the current driver to the new framework
> and get it out of drivers/misc and into a proper location. But, before I can do
> that, I need to be able to control the PWM from userspace somehow.

You should probably coordinate with Sascha Hauer who I think already has most
(if not all) of the PWM drivers converted to his first version of the
framework and said he was going to rebase them on top of this series.

> Maybe an interface similar to the one gpiolib provides with CONFIG_GPIO_SYSFS?

I think the most challenging part will be figuring out how to export PWM
devices via sysfs on a per-chip basis. Since the goal of the series is to
eventually get rid of the global namespace, using an export file like gpiolib
won't work in the long run. Perhaps something like the following would:

	/sys/class/pwm/
		pwmchipX/
			export
			unexport
			pwmY/
				label
				duty
				period

That way you get a reference to the device associated with a PWM chip and you
can use the new pwm_request_from_device() function to request and export the
PWM device.

Again, I have no direct use for this and you probably know the requirements
better than me so it's probably better if you add the interface. I'm happy to
review patches, though.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120315/289252b2/attachment.sig>
