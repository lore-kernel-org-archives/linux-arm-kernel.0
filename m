From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 04 Sep 2013 21:32:24 +0200
Subject: [PATCH RFC v2 01/16] ARM: call clk_of_init from time_init
In-Reply-To: <201308291545.37520.arnd@arndb.de>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <3837b119-baad-4e68-8805-2bc52c0135f9@DB9EHSMHS031.ehs.local>
 <521D2F1F.1070103@gmail.com> <201308291545.37520.arnd@arndb.de>
Message-ID: <52278AC8.5080103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29/2013 03:45 PM, Arnd Bergmann wrote:
> Please be careful with the patch ordering here. The patch series should
> be bisectable, i.e. no patch should ever knowingly break any of the
> platforms, with the fix getting added in a later patch.
>
> You should be able to do that by cleaning up all platforms to not
> rely on ordering first, then add this patch, and finally remove
> the other calls.

[Added Linus Walleij to Cc]

Just for the record, I have pushed a new version to
   https://github.com/shesselba/linux-dove.git clk-of-init-rfc-v3

It is rebased to next-20130904 and most notably calls of_clk_init(NULL)
only if there is no .init_time callback set. Also, I have split up
the set into preparatory and cleanup patches.

I have dropped conversion for mach-mvebu and mach-zynq; taken care of
new mach-nomadik, mach-prima2, and mach-sunxi.

For mach-zynq I prepared a patch set that brings it close to .init_time
removal. I have pushed it to
   https://github.com/shesselba/linux-dove.git zynq-clk-init-v1
and will maybe post a patch set after this one is done.

Also new is mach-u300, that looks like it needs clocks before irqs.
It calls irqchip_init but next-20130904 does not yet contain the
corresponding irqchip driver. I added Linus Walleij to make him aware
of the effort to remove most of the mach specific DT .init_time
callbacks. I even started to try to clean it up, but then I realized
the missing irqchip driver. Anyway, with the modifications above, it is
now safe to have custom .init_time and call of_clk_init on your own.
The initial u300 cleanup efforts can be found at
   https://github.com/shesselba/linux-dove.git u300-clk-init-v1

I will *not* send RFCv3 but rather wait for v3.11-rc1 to drop, rebase,
and send real v1 of what is left then.

Sebastian
