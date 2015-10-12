From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Oct 2015 18:21:04 +0100
Subject: [PATCH v2 07/22] arm64: Keep track of CPU feature registers
In-Reply-To: <561BE765.1080409@arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
 <1444064531-25607-8-git-send-email-suzuki.poulose@arm.com>
 <20151007171621.GD17192@e104818-lin.cambridge.arm.com>
 <56163D7F.4000003@arm.com>
 <20151008150346.GK17192@e104818-lin.cambridge.arm.com>
 <561BE765.1080409@arm.com>
Message-ID: <20151012172104.GC3659@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for the heads-up.

On Mon, Oct 12, 2015 at 06:01:25PM +0100, Suzuki K. Poulose wrote:
> On 08/10/15 16:03, Catalin Marinas wrote:
> >On Thu, Oct 08, 2015 at 10:55:11AM +0100, Suzuki K. Poulose wrote:
> 
> ...
> >
> >So we have three types of fields in these registers:
> >
> >a) features defined but not something we care about in Linux
> >b) reserved fields
> >c) features important to Linux
> >
> >I guess for (a), Linux may not even care if they don't match (though we
> >need to be careful which fields we ignore). As for (b), even if they
> >differ, since we don't know the meaning at this point, I think we should
> >just ignore them. If, for example, they add a feature that Linux doesn't
> >care about, they practically fall under the (a) category.
> >
> >Regarding exposing reserved CPUID fields to user, I assume we would
> >always return 0.
> 
> Mark,
> 
> Do you have any comments on this ? The list I have here is what you came
> up with in SANITY checks.

My feeling was that we should play it safe with fields which are
currently reserved (warning if they differ for now).

If they turn out to be irrelevant, it's simple to backport a patch to
ignore them, whereas if they matter we get instant visibility, which is
the entire point of the sanity checks.

So I think we should warn if reserved fields differ. I'd rather have a
few spurious warnings until kernels get updated than miss an issue that
could have been dealt with and avoided.

Thanks,
Mark.
