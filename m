From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Jan 2013 10:47:30 +0000
Subject: [PATCH RFT 3/3] ARM: tegra: dts: seaboard: enable keyboard
In-Reply-To: <50F13C34.3020808@nvidia.com>
References: <1357911185-11048-1-git-send-email-ldewangan@nvidia.com>
 <1357911185-11048-3-git-send-email-ldewangan@nvidia.com>
 <50F09BC7.90607@wwwdotorg.org>
 <20130111232438.GN23505@n2100.arm.linux.org.uk>
 <50F09FCB.70809@wwwdotorg.org>
 <20130111233615.GO23505@n2100.arm.linux.org.uk>
 <50F0A2A8.3080401@wwwdotorg.org> <50F13C34.3020808@nvidia.com>
Message-ID: <20130112104730.GQ23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 12, 2013 at 04:04:28PM +0530, Laxman Dewangan wrote:
> Going through clock driver, the clk_get() should return error pointer or  
> valid pointer, atleast not NULL.

No.  clk_get() will return whatever value the 'clk' pointer found in
the clk_lookup structure contains.  Or it will return an error pointer.

This topic has had enough discussion in the past that I'll say: go and
look up in the archives emails from me on this subject.  I've been very
clear over the years about this.

> Probably our clock driver is returning to NULL and hence issue is  
> becasue whole world, it  check for IS_ERR or !IS_ERR() and null clk  
> pointer treated as !IS_ERR().

Probably not.  As far as _drivers_ go, either the clk cookie is an error
(IS_ERR() is true) _OR_ it is valid to be passed back into the clock API.
You will find statements from me in the past to that: whatever clk_get()
returns which is _not_ an error must be accepted by the rest of the clk
API.

Drivers never dereference the returned clk, so why should they care about
anything other than "is it an error" given by IS_ERR().  (notice the lack
of question mark, that's not a question to be answered.)
