From: james.morse@arm.com (James Morse)
Date: Wed, 16 Dec 2015 11:15:25 +0000
Subject: [PATCH 1/2] arm64: Improve error reporting on set_pte_at() checks
In-Reply-To: <CA+=Sn1kQBoLCY_AidPXPU-2dkqGcfDfZtcnk1gzEukttZ+foOQ@mail.gmail.com>
References: <CA+=Sn1kQBoLCY_AidPXPU-2dkqGcfDfZtcnk1gzEukttZ+foOQ@mail.gmail.com>
Message-ID: <567147CD.6090404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 16/12/15 03:01, Andrew Pinski wrote:
> On Tue, Dec 9, 2015 at 17:26:56, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
>>
>> Currently the BUG_ON() checks do not give enough information about the PTEs being set. This patch changes BUG_ON to WARN_ONCE and dumps the values of the old and new PTEs.
> 
> 
> This change broke building the mantis driver:
> 
> In file included from ./arch/arm64/include/asm/io.h:30:0,
>                  from drivers/media/pci/mantis/mantis_i2c.c:21:
> ./arch/arm64/include/asm/pgtable.h: In function ?set_pte_at?:
> ./arch/arm64/include/asm/pgtable.h:281:3: error: implicit declaration
> of function ?BUILD_BUG_ON_INVALID?
> [-Werror=implicit-function-declaration]
>    VM_WARN_ONCE(!pte_young(pte),
>    ^

This is due to a missing include in include/linux/mmdebug.h, which
Julien Grall saw with CONFIG_XEN & !CONFIG_DEBUG_VM. There was some
discussion at [0], and a patch at [1].

The quick-and-dirty workaround is to toggle CONFIG_DEBUG_VM. It should
be fixed in the next rc.


Thanks,

James

[0] https://lkml.org/lkml/2015/12/14/489
[1] http://www.spinics.net/lists/linux-mm/msg98868.html
