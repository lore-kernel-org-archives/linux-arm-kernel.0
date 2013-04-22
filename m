From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 22 Apr 2013 13:24:56 +0300
Subject: Multiple issues with omap4 panda es in linux next
In-Reply-To: <5174FE16.6080307@ti.com>
References: <20130419171318.GK10155@atomide.com> <5174FE16.6080307@ti.com>
Message-ID: <51750FF8.6000401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-04-22 12:08, Tomi Valkeinen wrote:
> On 2013-04-19 20:13, Tony Lindgren wrote:
> 
>> 3. DSS fails with DT booting
>>
>> Works with legacy booting but fails with DT. I'm almost certain
>> the DT booting was working last week or so?
>>
>> This is what I now get with DT booting:
>>
>> omapdss DSI error: can't get VDDS_DSI regulator
>> omapdss HDMI error: can't get VDDA_HDMI_DAC regulator
>> omapdss HDMI error: device hdmi init failed: -517
>> omapdss CORE error: driver probe failed: -22
>> ...
> 
> I think this is the issue Christoph Fritz reported earlier, DSS is being
> initialized before TWL, and thus DSS doesn't find the regulators.
> 
> The proper fix is of course to make DSS support EPROBE_DEFER, but that's
> easier said than done. I'll have a look if I can get it working enough
> to fix this issue.

Yes, it seems delayed regulator initialization brought up this issue.

I hacked DSI driver of omapdss and Taal panel driver to somewhat work
with EPROBE_DEFER. But then the issue was with omapfb.

omapfb is currently set to start at late_initcall, so that omapdss and
panels are loaded before omapfb. But even that's not late enough to get
the regulators for omapdss. It seems the regulators get also initialized
at the late_initcall level. Changing omapfb to late_initcall_sync was
late enough to get things working.

Again, making omapdss, panel drivers and omapfb support EPROBE_DEFER and
dynamic panel driver insertion is the proper fix, but it's a big job,
and there are "interesting" issues with it (like how to know if a panel
device will ever get a driver loaded).

But is there something wrong with the TWL and regulators? late_initcall
sounds rather late for such a core resource. Even if all drivers
supported EPROBE_DEFER, won't it cause extra delays in the boot as
drivers are getting probed multiple times?

As for fixing the DSS problem for 3.10, I don't have any ideas except
pure hacks. I'll continue studying this.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130422/f61fc675/attachment-0001.sig>
