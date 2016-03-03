From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 3 Mar 2016 18:16:52 +0100
Subject: [PATCH v2 0/3] fix memremap on ARM
In-Reply-To: <20160303171347.GY19428@n2100.arm.linux.org.uk>
References: <1456508053-15015-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu_8Fggh+hnVnj6pM6PbOysWFTNt=ot6nudLur9nzs2FVg@mail.gmail.com>
 <20160303171347.GY19428@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu_5vmxsigsCfsvcjFa-hhOP6vxnMavsQ45oKgMeYzgUSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 March 2016 at 18:13, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Mar 03, 2016 at 05:24:41PM +0100, Ard Biesheuvel wrote:
>> If there are no remaining objections, may I suggest that Dan takes
>> patch #1 and #2, and that I put the third patch into Russell's patch
>> system? The only strict ordering requirement is that #1 is merged
>> before #2 and #3 both hit mainline, and that is solved by taking #1
>> and #2 in order.
>
> How does the dependency between 1 and 3 get satisfied?  Your comment
> makes no sense to me.
>

Patch #3 introduces a function arch_memremap_wb() on the ARM side
which will never get called unless patch #2 is also merged. Once both
#2 and #3 are in, the memremap() call that #1 reverts will use
MT_MEMORY_RW attributes rather than MT_DEVICE_CACHED, so #1 needs to
go first, but #2 and #3 can go in in either order.

In other words, there are no build dependencies between the patches,
but to prevent pxa2xx-flash from using MT_MEMORY_RW attributes, it
needs to go in before #2
