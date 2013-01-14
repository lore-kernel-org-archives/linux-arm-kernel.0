From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Jan 2013 16:55:51 +0000
Subject: [PATCH RFT 3/3] ARM: tegra: dts: seaboard: enable keyboard
In-Reply-To: <50F43640.7060308@wwwdotorg.org>
References: <1357911185-11048-1-git-send-email-ldewangan@nvidia.com>
 <1357911185-11048-3-git-send-email-ldewangan@nvidia.com>
 <50F09BC7.90607@wwwdotorg.org>
 <20130111232438.GN23505@n2100.arm.linux.org.uk>
 <50F09FCB.70809@wwwdotorg.org>
 <20130111233615.GO23505@n2100.arm.linux.org.uk>
 <50F0A2A8.3080401@wwwdotorg.org> <50F13C34.3020808@nvidia.com>
 <50F43640.7060308@wwwdotorg.org>
Message-ID: <20130114165551.GJ23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 09:45:52AM -0700, Stephen Warren wrote:
> On 01/12/2013 03:34 AM, Laxman Dewangan wrote:
> ...
> > Which is the tree on which Prashant changes are applied. I can debug
> > from that tree.
> 
> git://nv-tegra.nvidia.com/user/swarren/linux-2.6 test-ccf-rework-v4
> 
> But as I said in some other email in response to Prashant, I'll go and
> find out why the clk driver is returning NULL.

Exactly - the rule is, the rest of the clk API should accept as valid
anything which clk_get() produces _for that implementation_ which
IS_ERR() is not equal to 1.

What that means is:
- if a platform's clk_get() never returns NULL, then the rest of the clk
  API need not test for that value.

  (If a NULL pointer is passed to one of the clk API functions, crashing
  _is_ _okay_.  Consider what memset(NULL, 0, 4096) would do from the
  kernel - it doesn't test for a NULL pointer just because it can - it
  crashes so you can debug why it was passed a NULL pointer.)

- if a platform's clk_get() does return NULL, then the rest of the clk
  API is expected to deal with a NULL pointer in a way that does _not_
  result in the system crashing.

Or, to put it another way:

	clk = clk_get(...);
	if (IS_ERR(clk))
		return PTR_ERR(clk);

	clk_foo(clk);

for all possible return values of clk_get() that an implementation
_actually_ _intentionally_ returns[*] should never cause an oops.

[*] - bugs excluded.  No bugs were squashed in the creation of this email.
