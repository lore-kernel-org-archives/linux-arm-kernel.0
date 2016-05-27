From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 May 2016 18:36:53 +0100
Subject: [PATCH 01/23] all: syscall wrappers: add documentation
In-Reply-To: <20160527165806.GA20966@yury-N73SV>
References: <6293194.tGy03QJ9ME@wuerfel> <13240365.okADkKsTBJ@wuerfel>
 <20160527093052.GB7865@e104818-lin.cambridge.arm.com>
 <5422652.7gdoDlB8u0@wuerfel>
 <20160527130446.GD7865@e104818-lin.cambridge.arm.com>
 <20160527165806.GA20966@yury-N73SV>
Message-ID: <20160527173653.GA19961@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2016 at 07:58:06PM +0300, Yury Norov wrote:
> So, we have 3 options for now:
> 1. Clear top halves in entry.S which means we pass off_t as a pair.
>    The cost is performance (didn't measure it yet and doubt about it
>    makes serious impact). The advantage is simplicity and unification with
>    aarch32, as I mentioned above. And David likes it. And it mininizes
>    the amount of changes on glibc side.
> 2. Clear top halves in in separated file hosted wrappers.
> 3. Clear top halves in I-cache and tail optimization friendly in-site wrappers.
> 
> 2 and 3 are the same from ABI point of view.
> 
> 2 is the worst for me as it is the most complex in implementation and 
> I-cache and tail optimization non-friendly. But Heiko likes it.
>  
> 3 is what Catalin is talking about, and it was my initial approach.
> Though I didn't made compiler to do tail optimization, I think we can
> do it.

I don't fully understand the difference between 2 and 3. My comment was
more around annotating the wrappers in (2) with __naked to no longer
generate function prologue/epilogue. They would still be in a separate
kernel/compat_wrapper.c file.

I can't figure out how you would have in-place wrappers for all
syscalls. You can indeed handle the current COMPAT_SYSCALL_DEFINE via
__SC_DELOUSE (and penalising the AArch32/compat support slightly) but
there is no solution for native SYSCALL_DEFINE functions to do it
in-place.

> But 2 is what we have now. And I'd choose it. We'll never get ilp32 done
> if will roll back previously agreed decisions again and again.

I would rather roll back a decision than going ahead with a wrong one.
Note that this is *ABI*, not a driver that you can fix upstream later.

Since yesterday, I realised that (2) requires further annotations and
wrapping for the native and compat syscalls used by ILP32 just to cope
with pointers. Also given davem's comments, (1) starts to look a bit
more appealing (I don't like reverting such decisions either, I'd have
to review the code again and again).

-- 
Catalin
