From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 3 Dec 2015 08:18:43 +0000
Subject: [PATCH v2 10/21] arm64: KVM: Add patchable function selector
In-Reply-To: <20151202223456.GK3233@hawk.localdomain>
References: <1448650215-15218-1-git-send-email-marc.zyngier@arm.com>
 <1448650215-15218-11-git-send-email-marc.zyngier@arm.com>
 <20151202223456.GK3233@hawk.localdomain>
Message-ID: <20151203081843.5905bebd@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Dec 2015 16:34:56 -0600
Andrew Jones <drjones@redhat.com> wrote:

> On Fri, Nov 27, 2015 at 06:50:04PM +0000, Marc Zyngier wrote:
> > KVM so far relies on code patching, and is likely to use it more
> > in the future. The main issue is that our alternative system works
> > at the instruction level, while we'd like to have alternatives at
> > the function level.
> 
> How about setting static-keys at hyp init time?

That was an option I looked at. And while static keys would work to some
extent, they also have some nasty side effects:
- They create both a fast and a slow path. We don't want that - both
  path should be equally fast, or at least have as little overhead as
  possible
- We do need code patching for some assembly code, and using static
  keys on top creates a parallel mechanism that makes it hard to
  follow/debug/maintain.

You can view this alternative function call as a slightly different
kind of static keys - one that can give you the capability to handle
function calls instead of just jumping over code sequences. Both have
their own merits.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
