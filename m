From: robherring2@gmail.com (Rob Herring)
Date: Mon, 11 Aug 2014 21:25:45 -0500
Subject: [PATCH] ARM: expand fixmap region to 3MB
In-Reply-To: <20140811161448.GA4002@bivouac.eciton.net>
References: <1407511404-11997-1-git-send-email-robherring2@gmail.com>
 <20140811161448.GA4002@bivouac.eciton.net>
Message-ID: <CAL_JsqLSZis=G-TzDcoPwUkv_=vyzNpGRc9oGOg_SJ_9gPjAtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 11:14 AM, Leif Lindholm
<leif.lindholm@linaro.org> wrote:
> On Fri, Aug 08, 2014 at 10:23:24AM -0500, Rob Herring wrote:
>> From: Rob Herring <robh@kernel.org>
>>
>> With commit a05e54c103b0b8 "ARM: 8031/2: change fixmap mapping region to
>> support 32 CPUs", the fixmap region was expanded to 2MB, but it
>> precluded any other uses of the fixmap region in order to support up to
>> 32 CPUs. In order to support other uses the fixmap region needs to be
>> expanded beyond 2MB. Fortunately, the adjacent 1MB range
>> 0xffe00000-0xfff00000 is availabe to use.
>>
>> Remove fixmap_page_table ptr and lookup the page table via the virtual
>> address so that the fixmap region can span more that one pmd. The 2nd
>> pmd is already created since it is shared with the vector page.
>>
>> Cc: Leif Lindholm <leif.lindholm@linaro.org>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>
>> This patch can come before or after the generic fixmap.h. There's a
>> single line conflict with the ending address
>
> Tested-by: Leif Lindholm <leif.lindholm@linaro.org>
> For Kees' set with this addition + generic fixmap + early_ioremap +
> UEFI.
>
>> This worked for earlycon, but I've not done any highmem specific
>> testing. My full series is available here:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git fixmap
>
> I was hoping to be able to give you a tested-by for that series on
> next-20140811 with the UEFI patches, but that setup fails to boot
> right now. Looking into why.

Doing early ioremap as well I guess? It may be that 2 page tables are
not getting setup early as earlycon would use one end of the region
and early_ioremap uses the other end.

Rob
