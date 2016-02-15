From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Feb 2016 14:35:09 +0000
Subject: [PATCH v5sub1 7/8] arm64: move kernel image to base of vmalloc
 area
In-Reply-To: <56C1E072.2090909@virtuozzo.com>
References: <1454324093-15998-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454324093-15998-8-git-send-email-ard.biesheuvel@linaro.org>
 <20160212145844.GI31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-x6QPorWsPDP8bqAkmbasqzhqmP39HS=qprfGB4r8JLw@mail.gmail.com>
 <20160212151006.GJ31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu84mVP=YjbLhWoGj9AEUD8m8+Lq8kTCniCHwxJwMWaZtA@mail.gmail.com>
 <20160212152641.GK31665@e104818-lin.cambridge.arm.com>
 <56BDFC86.5010705@arm.com>
 <20160212160652.GL31665@e104818-lin.cambridge.arm.com>
 <56C1E072.2090909@virtuozzo.com>
Message-ID: <20160215143509.GE9732@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 05:28:02PM +0300, Andrey Ryabinin wrote:
> 
> 
> On 02/12/2016 07:06 PM, Catalin Marinas wrote:
> > So far, we have:
> > 
> > KASAN+for-next/kernmap goes wrong
> > KASAN+UBSAN goes wrong
> > 
> > Enabled individually, KASAN, UBSAN and for-next/kernmap seem fine. I may
> > have to trim for-next/core down until we figure out where the problem
> > is.
> > 
> > BUG: KASAN: stack-out-of-bounds in find_busiest_group+0x164/0x16a0 at addr ffffffc93665bc8c
> 
> Can it be related to TLB conflicts, which supposed to be fixed in "arm64: kasan: avoid TLB conflicts" patch
> from "arm64: mm: rework page table creation" series ?

Currently I don't believe this is a TLB issue. We've been seeing issues
even with those patches in for-next/core with that patch included. It's
also incredibly reliable to trigger.

It seems that issues are more likely the larger the kernel image, so my
suspicion is that at some boundary condition we create the page tables
for the shadow region incorrectly. I'm only able to trigger this on a
particular machine, so the physical memory layout may also matter.

I'm currently looking into that.

Mark.
