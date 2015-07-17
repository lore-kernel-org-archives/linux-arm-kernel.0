From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 17 Jul 2015 12:05:06 +0100
Subject: [PATCH 3/5] arm64: kernel: Add min/max values in
 feature-detection register values.
In-Reply-To: <20150717105110.GL18994@arm.com>
References: <1437062519-18883-1-git-send-email-james.morse@arm.com>
 <1437062519-18883-4-git-send-email-james.morse@arm.com>
 <20150717105110.GL18994@arm.com>
Message-ID: <20150717110505.GB13712@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 11:51:11AM +0100, Will Deacon wrote:
> On Thu, Jul 16, 2015 at 05:01:57PM +0100, James Morse wrote:
> > When a new cpu feature is available, the cpu feature bits will be 0001,
> > when features are updated, this value will be incremented. This patch
> > changes 'register_value' to be '{min,max}_register_value', and checks
> > the value falls in this range.
> 
> I'm not sure this is completely true. For example, the new atomics are
> advertised with feature bits of 0002, whilst 0001 is RESERVED and 0000
> means they're not present.
> 
> Also, the problem with specifying an upper bound is that we have to keep
> updating it. Elsewhere in the kernel, we've treated these as 4-bit signed
> fields and if X > Y, we assume that the feature set of X is a superset of
> Y. Unfortunately, the ARM ARM doesn't provide this insight but it is
> something that we teased out of the architects.

I got another verbal confirmation yesterday from the architects that
this is the principle the ID bits are based on (so higher number
preserves the existing functionality).

We currently have a mix of exact match in cpufeature.c or greater-than
in some .S files. So we have two ways to address this:

1. Always use >= but with signed 4-bit field
2. Use min/max in cpufeature.c with max being 7

I think we should just go for 1 unless anyone sees a problem with the
current CPU implementations (and we need to keep an eye on the
architects for future additions to these registers).

-- 
Catalin
