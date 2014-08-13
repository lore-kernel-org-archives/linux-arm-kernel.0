From: robherring2@gmail.com (Rob Herring)
Date: Wed, 13 Aug 2014 02:33:31 -0500
Subject: [PATCH] ARM: expand fixmap region to 3MB
In-Reply-To: <CAGXu5j+Wm7LzdTZWsjLpisBqgcKxx-_t=O_LWsn8hP+_KiBxEw@mail.gmail.com>
References: <1407511404-11997-1-git-send-email-robherring2@gmail.com>
 <20140811161448.GA4002@bivouac.eciton.net>
 <CAGXu5j+Wm7LzdTZWsjLpisBqgcKxx-_t=O_LWsn8hP+_KiBxEw@mail.gmail.com>
Message-ID: <CAL_JsqKnDBtLEHNw0Hk1vdZTnH-3MRi3=YqTo=5DCEF9hPRc5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 12, 2014 at 12:55 PM, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Aug 11, 2014 at 9:14 AM, Leif Lindholm <leif.lindholm@linaro.org> wrote:
>> On Fri, Aug 08, 2014 at 10:23:24AM -0500, Rob Herring wrote:
>>> From: Rob Herring <robh@kernel.org>
>>>
>>> With commit a05e54c103b0b8 "ARM: 8031/2: change fixmap mapping region to
>>> support 32 CPUs", the fixmap region was expanded to 2MB, but it
>>> precluded any other uses of the fixmap region in order to support up to
>>> 32 CPUs. In order to support other uses the fixmap region needs to be
>>> expanded beyond 2MB. Fortunately, the adjacent 1MB range
>>> 0xffe00000-0xfff00000 is availabe to use.
>>>
>>> Remove fixmap_page_table ptr and lookup the page table via the virtual
>>> address so that the fixmap region can span more that one pmd. The 2nd
>>> pmd is already created since it is shared with the vector page.
>>>
>>> Cc: Leif Lindholm <leif.lindholm@linaro.org>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Cc: Russell King <linux@arm.linux.org.uk>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>>
>>> This patch can come before or after the generic fixmap.h. There's a
>>> single line conflict with the ending address
>>
>> Tested-by: Leif Lindholm <leif.lindholm@linaro.org>
>> For Kees' set with this addition + generic fixmap + early_ioremap +
>> UEFI.
>>
>>> This worked for earlycon, but I've not done any highmem specific
>>> testing. My full series is available here:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git fixmap
>>
>> I was hoping to be able to give you a tested-by for that series on
>> next-20140811 with the UEFI patches, but that setup fails to boot
>> right now. Looking into why.
>
> For me, the 3MB change doesn't work. It acts like the PTE isn't there:
>
> lkdtm: Performing direct entry WRITE_KERN
> lkdtm: attempting 52 byte write at 804331cc
> lkdtm: 804331cc mapped RW via ffe7f1cc
> Unable to handle kernel paging request at virtual address ffe7f1cc
> pgd = 9ea40000
> [ffe7f1cc] *pgd=9fffd821, *pte=00000000, *ppte=00000000
>
> And it weirdly leaves this hanging around in
> /sys/kernel/debug/kernel_page_tables:
>
> 0xffc7f000-0xffc80000           4K     RW NX SHD MEM/CACHED/WBWA
>
> If I use all the other changes to clean up the code, everything is
> fine. The only change I have been the trees now is just this:
>
> -#define FIXADDR_END            0xffe00000UL
> +#define FIXADDR_END            0xfff00000UL
>
> I think my build isn't catching this extra area via the vector table pmd.

I commented in patch 3 of your series where the problem is.

> So, instead of continuing to beat my head against this, I've changed
> my series around to use NR_CPUS as Rob was doing, and added

My use of NR_CPUS was not intentional, but rather it was just based on
the older versions of the patch. I don't have a strong opinion either
way.

Rob
