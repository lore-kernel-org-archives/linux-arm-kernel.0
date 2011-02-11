From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Feb 2011 12:55:59 +0000
Subject: [RFC PATCH 3/3] ARM: vfp: Use cpu pm notifiers to save vfp state
In-Reply-To: <20110211122410.GF23404@n2100.arm.linux.org.uk>
References: <1297373487-23902-1-git-send-email-ccross@android.com>
	<1297373487-23902-4-git-send-email-ccross@android.com>
	<1297426345.17584.99.camel@e102109-lin.cambridge.arm.com>
	<20110211122410.GF23404@n2100.arm.linux.org.uk>
Message-ID: <AANLkTiksKEZzYwkh1DzoGYRmhq=XLm9Yh+DMGys7aE0S@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 February 2011 12:24, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Feb 11, 2011 at 12:12:25PM +0000, Catalin Marinas wrote:
>> On SMP systems, we save the VFP at every context switch to deal with the
>> thread migration (though I have a plan to make this lazily on SMP as
>> well).
>
> I'm not sure it's worth the complexity. ?You'd have to do an IPI to the
> old CPU to provoke it to save the context from its VFP unit. ?You'd have
> to do that in some kind of atomic way as the old CPU may be in the middle
> of already saving it. ?You're also going to have to add locking to the
> last_VFP_context[] array as other CPUs will be accessing non-local
> entries, and that means doing locking in assembly. ?Yuck.

I wasn't thinking about that, too complex indeed. But it may be easier
to detect thread migration, possibly with some hooks into generic
scheduler and only save the VFP state at that point. I haven't looked
in detail but I heard the x86 people have patches for something
similar.

-- 
Catalin
