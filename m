From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Oct 2017 11:57:17 +0100
Subject: [kbuild-all] [arm:for-next 9/11] awk: line 2: function strtonum
 never defined
In-Reply-To: <20171003100540.tfcehrcvf356332x@wfg-t540p.sh.intel.com>
References: <201710030905.zGRrw4dZ%fengguang.wu@intel.com>
 <20171003090642.GJ20805@n2100.armlinux.org.uk>
 <20171003100540.tfcehrcvf356332x@wfg-t540p.sh.intel.com>
Message-ID: <20171003105717.GL20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 03, 2017 at 06:05:40PM +0800, Fengguang Wu wrote:
> Hi Russell King,
> 
> On Tue, Oct 03, 2017 at 10:06:42AM +0100, Russell King - ARM Linux wrote:
> >Shall I repeat my question from the last time this was reported?
> 
> Sorry I cannot find your reply in email archive.

Odd, because I sent a reply to your report on 29th September, and it
made it to the linux-arm-kernel mailing list, and its archives:

  http://archive.armlinux.org.uk/lurker/message/20170929.190625.9f5a9438.en.html

> Looking at this
> error, the root cause should be strtonum requires gawk while what we
> installed is
> 
>        mawk 1.3.3 Nov 1996, Copyright (C) Michael D. Brennan
> 
> We can trivially install gawk and make it the default, however is gawk
> a requirement for kernel compilation? Or can we make it work with mawk,
> too?

Well, awk isn't mentioned in Documentation/Changes as a build requirement,
but then neither is grep.  However, kbuild itself makes use of both:

Makefile:AWK                = awk
Makefile:   $(Q)$(AWK) '!x[$$0]++' $(vmlinux-dirs:%=$(objtree)/%/modules.order) > $(objtree)/modules.order
Makefile:   $(Q)$(AWK) '!x[$$0]++' $^ > $(objtree)/modules.builtin
scripts/Makefile.build:     if $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then                \

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
