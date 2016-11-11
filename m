From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 11 Nov 2016 15:32:05 +0000
Subject: [PATCH v14 4/9] acpi/arm64: Add GTDT table parse driver
In-Reply-To: <5825CBB5.8090104@linaro.org>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-5-git-send-email-fu.wei@linaro.org>
 <20161020163719.GC27598@leverpostej> <5825CBB5.8090104@linaro.org>
Message-ID: <20161111153205.GI11945@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 09:46:29PM +0800, Hanjun Guo wrote:
> On 10/21/2016 12:37 AM, Mark Rutland wrote:
> >On Thu, Sep 29, 2016 at 02:17:12AM +0800, fu.wei at linaro.org wrote:
> >>+static int __init map_gt_gsi(u32 interrupt, u32 flags)
> >>+{
> >>+	int trigger, polarity;
> >>+
> >>+	if (!interrupt)
> >>+		return 0;
> >
> >Urgh.
> >
> >Only the secure interrupt (which we do not need) is optional in this
> >manner, and (hilariously), zero appears to also be a valid GSIV, per
> >figure 5-24 in the ACPI 6.1 spec.
> >
> >So, I think that:
> >
> >(a) we should not bother parsing the secure interrupt
> >(b) we should drop the check above
> >(c) we should report the spec issue to the ASWG
> 
> Sorry, I willing to do that, but I need to figure out the issue here.
> What kind of issue in detail? do you mean that zero should not be valid
> for arch timer interrupts?

As above, zero is a valid GSIV, and is valid for the non-secure timer
interrupts. The check is wrong for non-secure interrupts.

We can ignore the secure timer interrupt since it's irrelevant to us,
and remove the check.

Regardless, the spec is inconsistent w.r.t. the secure interrupt being
zero if not present, since zero is a valid GSIV. That should be reported
to the ASWG.

Thanks,
Mark.
