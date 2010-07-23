From: kanru@0xlab.org (Kan-Ru Chen)
Date: Fri, 23 Jul 2010 12:38:28 +0800
Subject: [PATCH 2/2] USB: musb: omap2430: add mode change from A to B
In-Reply-To: <4C48748C.8040307@felipebalbi.com>
References: <1268648622-28529-1-git-send-email-Hui.Wang@windriver.com>
	<1268648622-28529-2-git-send-email-Hui.Wang@windriver.com>
	<877hknwnrb.fsf@anar.kanru.info> <4C48748C.8040307@felipebalbi.com>
Message-ID: <87y6d2u81n.fsf@anar.kanru.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Jul 2010 19:40:44 +0300, Felipe Balbi <me@felipebalbi.com> wrote:
> On 07/22/2010 06:16 PM, Kan-Ru Chen wrote:
> > Just curious about how to do this in a more automatic way.
> > 
> > I think setup a daemon to monitor the musb_hdrc mode and try to alter
> > it's state via sysfs interface will work, but it may be error prone and
> > not always desirable solution.
> > 
> > Can we query the id pin state periodically in the kernel and change to
> > corresponding role?
> 
> the transceiver has an interrupt for id pin changes. You can use that
> instead of polling.

Thanks, I see.

The twl4030_usb transceiver did get the id pin chanegs

    <7>twl4030_usb twl4030_usb: HW_CONDITIONS 0x50/80; link 1
    <7>twl4030_usb twl4030_usb: HW_CONDITIONS 0x54/84; link 3

So the problem is when OTG enter a_host mode then disconnected, it
becomes idle. Plug the peripheral device back would not trigger new
session unless I do "echo otg > /sys/devices/platform/musb_hdrc/mode"
