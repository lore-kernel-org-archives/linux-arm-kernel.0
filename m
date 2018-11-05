From: jeyu@kernel.org (Jessica Yu)
Date: Mon, 5 Nov 2018 20:49:09 +0100
Subject: [PATCH v2] arm64/module: use plt section indices for relocations
In-Reply-To: <20181105192637.GB25023@brain-police>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141652.5478C68BE1@newverein.lst.de>
 <20181105175722.removbbpilqxu7tr@redbean>
 <20181105185323.hgoflyvkyujdyjxj@redbean>
 <20181105192637.GB25023@brain-police>
Message-ID: <20181105194909.djdmrpqkgu26nbp5@redbean>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+++ Will Deacon [05/11/18 19:26 +0000]:
>On Mon, Nov 05, 2018 at 07:53:23PM +0100, Jessica Yu wrote:
>> Instead of saving a pointer to the .plt and .init.plt sections to apply
>> plt-based relocations, save and use their section indices instead.
>>
>> The mod->arch.{core,init}.plt pointers were problematic for livepatch
>> because they pointed within temporary section headers (provided by the
>> module loader via info->sechdrs) that would be freed after module load.
>> Since livepatch modules may need to apply relocations post-module-load
>> (for example, to patch a module that is loaded later), using section
>> indices to offset into the section headers (instead of accessing them
>> through a saved pointer) allows livepatch modules on arm64 to pass in
>> their own copy of the section headers to apply_relocate_add() to apply
>> delayed relocations.
>>
>> Signed-off-by: Jessica Yu <jeyu@kernel.org>
>> ---
>>
>> v2:
>>
>> - Do sechdrs[pltsec->plt_shndx].sh_addr instead of pointer math
>>
>> Note: Addressed Will's comment about the pltsec -> plt_info rename and
>> removed that change to reduce unnecessary code churn. I didn't include the
>> Ack's for this reason so let me know if this version is OK as well.
>
>Thanks, Jessica!
>
>Acked-by: Will Deacon <will.deacon@arm.com>
>
>> arch/arm64/include/asm/module.h |  8 +++++---
>> arch/arm64/kernel/module-plts.c | 36 ++++++++++++++++++++----------------
>> arch/arm64/kernel/module.c      |  9 +++++----
>> 3 files changed, 30 insertions(+), 23 deletions(-)
>
>Actually, I guess I should just queue this for 4.21 given that it's
>completely self-contained.

Yes, that's fine :-) Then Torsten won't have to include this patch to his
patchset.

Thank you!

Jessica
