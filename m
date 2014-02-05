From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 5 Feb 2014 14:55:19 +0000
Subject: [PATCH] arm64: fix early_io_map for 64K pages
In-Reply-To: <20140205145250.GC28140@mudshark.cambridge.arm.com>
References: <1391611829-7824-1-git-send-email-robherring2@gmail.com>
 <20140205145250.GC28140@mudshark.cambridge.arm.com>
Message-ID: <20140205145519.GJ7550@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 02:52:51PM +0000, Will Deacon wrote:
> On Wed, Feb 05, 2014 at 02:50:29PM +0000, Rob Herring wrote:
> > From: Rob Herring <robh@kernel.org>
> > 
> > earlyprintk is broken with 64KB pages. The problem is pgprot_default
> > is not yet initialized when early_io_map is called, so the pte does not
> > get marked as valid. Set the necessary page and access permission bits.
> > 
> > Cc: Mark Salter <msalter@redhat.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> 
> I thought we fixed this in 4ce00dfcf19c by reverting the use of
> pgprot_default?

Indeed. We still need to fix the ioremap_cache() case where the
shareability isn't set but I haven't yet decided what we do for
SMP-on-UP in arm64 (if we always assume SMP, I would just get rid of
pgprot_default entirely).

-- 
Catalin
