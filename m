From: tony@atomide.com (Tony Lindgren)
Date: Wed, 26 Nov 2014 17:12:04 -0800
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <201411270038.01312@pali>
References: <20141027200008.GR2560@atomide.com> <201411270001.44871@pali>
 <20141126231435.GQ2817@atomide.com> <201411270038.01312@pali>
Message-ID: <20141127011203.GR2817@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [141126 15:40]:
> 
> With enabled CONFIG_ARM_APPENDED_DTB=y file /proc/atags is 
> missing.

OK I guess it should not be needed for DT based booting.
 
> > The build_tag_list() should parse ATAG_REVISION and then
> > parse_tag_revision() should copy it to system_rev. Maybe try
> > adding some printks to see if those functions get called?
> 
> Now I see... Problem is that build_tag_list() is called from 
> convert_to_tag_list() which is called from setup_machine_tags() 
> which is called from setup_arch() only if setup_machine_fdt() 
> call fails. And it fails for *non* DT boot. You can check this 
> chain too.

Thinking about this probably the best long term solution is
to pass optional board_revision in the kernel cmdline that
can be parsed early and copied to system_rev variable.

Or if you can think of some other way to get it, we can set
system_rev in pdata-quirks.c.

Or maybe add some code to copy the ATAGs somewhere where
they are out of the way and don't conflict with the device
tree data? Then we can query ATAG_REVISION from pdata-quirks.c
and set system_rev.

Regards,

Tony
