From: khilman@ti.com (Kevin Hilman)
Date: Fri, 11 Mar 2011 08:47:53 -0800
Subject: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
In-Reply-To: <4D7A22F6.5050806@ti.com> (Rajendra Nayak's message of "Fri, 11
	Mar 2011 18:56:14 +0530")
References: <1299245123-23444-1-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com>
	<4D775418.6050105@ti.com>
	<alpine.DEB.2.00.1103100514210.15132@utopia.booyaka.com>
	<alpine.DEB.2.00.1103100734490.15132@utopia.booyaka.com>
	<4D7A22F6.5050806@ti.com>
Message-ID: <871v2dbo3q.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rajendra Nayak <rnayak@ti.com> writes:

[...]

>>
>> It's also breaking boot on OMAP35xx BeagleBoard rev C2.  The kernel
>> boot messages are below - omap2plus_defconfig + DEBUG_LL.  Reverting
>> the patch fixes it.  Could you please take a look?
>
> I got hold of a Beagle, a sticker on which says rev C1D.
> Not sure if there is a better way to identify the rev, but
> this one seems to boot fine for me even with this patch.
> I just applied this one patch on top of the the tag
> 'integration-2.6.39-20110310-008' of git://git.pwsan.com/linux-
> integration.

In the process of testing Santosh's OMAP4 PM series (which includes
$SUBJECT patch) on OMAP3, I also noticed some problems on beagle (mine
is a C3.)

Specifially, with $SUBJECT patch applied, none of the powerdomains ever
reach inactive or RET during idle (suspend seems to work fine.)

Just reverting $SUBJECT patch makes things go back to working normally.

I pushed the test branch I used which is a merge of Santosh's v3 branch
with my pm branch (branch: tmp/santosh-omap4-pm)

I tested by first doing a suspend test and confirming all the
powerdomains hit retention.  That worked fine.  Then I did an idle test:

  echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout               
  echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout               
  echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout               
  echo 1 > /debug/pm_debug/sleep_while_idle

and waited for the UARTs to timeout.

Well after the UART timeouts expired, I do not see any powerdomains
transitioning from ON.

What's even more strange is that the same thing is working fine on all
the other OMAP3 platforms I tested: 3430/n900, 3630/zoom3 and even a
different 3530-based platform, the OMAP3EVM.

Kevin
