From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Feb 2017 11:03:56 +0000
Subject: [PATCH] arm64: traps: Mark __le16, __le32, __user variables
 properly
In-Reply-To: <20170220213344.dqp4pzxr2dj6vbd3@macpro.local>
References: <20170217165112.17512-1-stephen.boyd@linaro.org>
 <20170219015808.2vc2kvpde7nlrey4@macbook.local>
 <148758047729.2988.16966413648865610904@sboyd-linaro>
 <20170220104947.GE9003@leverpostej>
 <20170220213344.dqp4pzxr2dj6vbd3@macpro.local>
Message-ID: <20170221110355.GD300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 10:33:45PM +0100, Luc Van Oostenryck wrote:
> I just checked this and I'm not very sure what's best.
> Sparse is very well aware of the '...' to specify a range
> in an array initializer or in switch-case. The warning
> is there only because those entries are later overridden
> with some value.
> When checking what GCC is doing in this situation is saw
> that by default even in cases like:
> 	static in ref[] = {
> 		[1] = 1,
> 		[2] = 2,
> 	};
> GCC doesn't issue a warning. You need to use the flag
> -Woverride-init for that. But then you also have a warning
> for our current case:
> 	static in foo[] = {
> 		[0 ... 3] = 1,
> 		[0] = 2,
> 	};
> 
> It's easy enough to patch sparse to not issue a warning when the
> override concerns a range (which would be perfect for the situation here),
> Controlled or not by a new warning flag. But I'm far from convinced
> that all uses of such "ranged-initialization" is used for default values
> that may be later overridden.

How about not warning only when the overridden range covers the entire
length of the array? The only broken case I can think of that slips
through the cracks then is if somebody typoed the range so that it
accidentally covered the whole array and therefore suppressed the override
warning.

Will
