From: brad.mouring@ni.com (Brad Mouring)
Date: Mon, 18 Apr 2016 16:36:49 -0500
Subject: [PATCH v2 0/2] Control PL310 pwr_ctrl register through DT
In-Reply-To: <1456265019-23900-1-git-send-email-brad.mouring@ni.com>
References: <1456265019-23900-1-git-send-email-brad.mouring@ni.com>
Message-ID: <1461015411-14000-1-git-send-email-brad.mouring@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This submission addresses the concerns brought up here:
http://www.spinics.net/lists/arm-kernel/msg495003.html

The of_property_read_u32 returns -EINVAL when the property is
not found in the dtb, and we ignore that error. An error message
is only printed when the property is present with an invalid value.

The other issue raised was concerning the default behavior if
the properties are not in the dtb. The existing behavior prior
to this changeset is maintained.

During some performance-oriented benchmarking on a Cortex A9
platform, a slight performance degradation was noted on datasets
that spanned into the L2 cache (<10%). This performance hit was
minor, but it prompted investigation into the cause.

One difference in the actual PL310 configuration that was concerning
was the enabling of two PM-related changes: Dynamic Clock Gating
and Standby Mode Enabling. As the kernel being tested was patched
and configured to use the PREEMPT_RT patchset, it was desired to
disable these settings for our use-case since anything PM can
(and usually does) impact determinism.

Making these changes resulted in a modest performance improvement
and those wonderful warm-n-fuzzies regarding determinism and enabling
system control without needing to change the kernel.

In the following set, there's the actual change to control these
features given DT presence of a couple of new bindings and the
documenation to accompany those changes.

Thanks for the feedback!
