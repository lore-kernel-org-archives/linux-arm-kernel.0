From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Apr 2017 21:00:54 +0100
Subject: [PATCH v2] arm: Fix memory attribute inconsistencies when using
 fixmap
In-Reply-To: <CAKv+Gu-1oL_yVvo4bL52Lu=WKjxxG+YhybeTceaCH9fac656+A@mail.gmail.com>
References: <20170321173030.7751-1-tixy@linaro.org>
 <1490117781.3136.9.camel@linaro.org>
 <CAKv+Gu82PsyyC=fQHxUn5mrCdmQvhwK+DK342-vv8y53mLcpng@mail.gmail.com>
 <CAKv+Gu-1oL_yVvo4bL52Lu=WKjxxG+YhybeTceaCH9fac656+A@mail.gmail.com>
Message-ID: <20170403200054.GB7909@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 06:18:47PM +0100, Ard Biesheuvel wrote:
> Apologies, but it appears I screwed this up: earlycon does not
> actually work, it seems, due to the fact that early_fixmap_init() is
> now postponed to after parse_early_params(), but earlycon
> configuration (which uses set_fixmap_io()) is triggered by the early
> parsing of the 'earlycon' command line parameter, and so
> early_fixmap_init() occurs to late now. I am not sure how I missed
> this, but I obviously did.
> 
> Since fixmaps for I/O are not affected by the issue this patch
> addresses, the correct way would be to call early_fixmap_init() as we
> did before, but disallow FIXMAP_PAGE_NORMAL and FIXMAP_PAGE_RO
> mappings until after early_mm_init has executed.
> 
> I'm happy to code that up as a followup patch (since I am partly to
> blame for this patch having ended up in -next in its current shape)
> but it will have to wait until tomorrow.

Hmm, sounds like a good thing I haven't sent it to Linus yet then... I'll
continue holding off sending that, although I would like to send what I
have queued to Linus in the next couple of days.  So, I think I'll drop
8667/1 out of fixes, and requeue as appropriate depending on how the
update arrives.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
