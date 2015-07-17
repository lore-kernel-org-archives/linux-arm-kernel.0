From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Jul 2015 13:45:43 +0100
Subject: [PATCH 3/5] arm64: kernel: Add min/max values in
 feature-detection register values.
In-Reply-To: <55A8E163.5010607@arm.com>
References: <1437062519-18883-1-git-send-email-james.morse@arm.com>
 <1437062519-18883-4-git-send-email-james.morse@arm.com>
 <20150717105110.GL18994@arm.com> <55A8E163.5010607@arm.com>
Message-ID: <20150717124543.GO18994@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 12:05:07PM +0100, James Morse wrote:
> On 17/07/15 11:51, Will Deacon wrote:
> > On Thu, Jul 16, 2015 at 05:01:57PM +0100, James Morse wrote:
> >> When a new cpu feature is available, the cpu feature bits will be 0001,
> >> when features are updated, this value will be incremented. This patch
> >> changes 'register_value' to be '{min,max}_register_value', and checks
> >> the value falls in this range.
> > 
> > I'm not sure this is completely true. For example, the new atomics are
> > advertised with feature bits of 0002, whilst 0001 is RESERVED and 0000
> > means they're not present.
> > 
> > Also, the problem with specifying an upper bound is that we have to keep
> > updating it. Elsewhere in the kernel, we've treated these as 4-bit signed
> > fields and if X > Y, we assume that the feature set of X is a superset of
> > Y. Unfortunately, the ARM ARM doesn't provide this insight but it is
> > something that we teased out of the architects.
> > 
> > Does PAN break our assumptions here?
> 
> No, it just needs to match 1 and 2.
> 
> Would you prefer a 'min_register_value' and some careful 4-bit
> sign-extension logic to use the 'if X > Y' logic?

Yeah, I think Catalin's suggestion of "Always use >= but with signed 4-bit
field" is the best bet.

Will
