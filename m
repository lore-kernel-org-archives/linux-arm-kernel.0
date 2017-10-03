From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Oct 2017 12:07:52 +0100
Subject: [kbuild-all] [arm:for-next 9/11] awk: line 2: function strtonum
 never defined
In-Reply-To: <20171003102830.fmle4i2koenevops@wfg-t540p.sh.intel.com>
References: <201710030905.zGRrw4dZ%fengguang.wu@intel.com>
 <20171003090642.GJ20805@n2100.armlinux.org.uk>
 <20171003100540.tfcehrcvf356332x@wfg-t540p.sh.intel.com>
 <20171003102830.fmle4i2koenevops@wfg-t540p.sh.intel.com>
Message-ID: <20171003110752.GM20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 03, 2017 at 06:28:30PM +0800, Fengguang Wu wrote:
> On Tue, Oct 03, 2017 at 06:05:40PM +0800, Fengguang Wu wrote:
> >Hi Russell King,
> >
> >On Tue, Oct 03, 2017 at 10:06:42AM +0100, Russell King - ARM Linux wrote:
> >>Shall I repeat my question from the last time this was reported?
> >
> >Sorry I cannot find your reply in email archive. Looking at this
> >error, the root cause should be strtonum requires gawk while what we
> >installed is
> >
> >       mawk 1.3.3 Nov 1996, Copyright (C) Michael D. Brennan
> >
> >We can trivially install gawk and make it the default, however is gawk
> >a requirement for kernel compilation? Or can we make it work with mawk,
> >too?
> 
> Well gawk/mawk both defined int(), however it behaves different:
> 
> wfg ~% mawk 'BEGIN{print int("0xff")}'
> 255
> wfg ~% gawk 'BEGIN{print int("0xff")}'
> 0
> wfg ~% gawk 'BEGIN{print strtonum("0xff")}'
> 255

So I don't think awk can be used reliably for this - there seems to be
no reliable way to convert hex to an integer in awk.

Maybe the easiest solution would be to switch to using perl instead -
at least perl is listed as a required tool, and perl's hex() function
will always be able to parse hex!

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
