From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 01 Apr 2015 10:47:49 +0100
Subject: [PATCH] mm/migrate: Mark unmap_and_move() "noinline" to avoid
 ICE in gcc 4.7.3
In-Reply-To: <alpine.DEB.2.10.1504011130030.14762@ayla.of.borg>
References: <20150324004537.GA24816@verge.net.au>
 <CAKv+Gu-0jPk=KQ4gY32ELc+BVbe=1QdcrwQ+Pb=RkdwO9K3Vkw@mail.gmail.com>
 <20150324161358.GA694@kahuna> <20150326003939.GA25368@verge.net.au>
 <20150326133631.GB2805@arm.com>
 <CANMBJr68dsbYvvHUzy6U4m4fEM6nq8dVHBH4kLQ=0c4QNOhLPQ@mail.gmail.com>
 <20150327002554.GA5527@verge.net.au> <20150327100612.GB1562@arm.com>
 <7hbnj99epe.fsf@deeprootsystems.com>
 <CAKv+Gu_ZHZFm-1eXn+r7fkEHOxqSmj+Q+Mmy7k6LK531vSfAjQ@mail.gmail.com>
 <7h8uec95t2.fsf@deeprootsystems.com>
 <alpine.DEB.2.10.1504011130030.14762@ayla.of.borg>
Message-ID: <551BBEC5.7070801@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/15 10:37, Geert Uytterhoeven wrote:
> 	Hi Kevin,
> 
> On Tue, 31 Mar 2015, Kevin Hilman wrote:
>> Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
>> Nope, that branch is already part of linux-next, and linux-next still
>> fails to compile for 20+ defconfigs[1]
>>
>>> Could you elaborate on the issue please? What is the error you are
>>> getting, and can you confirm that is is caused by ld choking on the
>>> linker script? If not, this is another error than the one we have been
>>> trying to fix
>>
>> It's definitely not linker script related.
>>
>> Using "arm-linux-gnueabi-gcc (Ubuntu/Linaro 4.7.3-12ubuntu1) 4.7.3",
>> here's the error when building for multi_v7_defconfig (full log
>> available[2]):
>>
>> ../mm/migrate.c: In function 'migrate_pages':
>> ../mm/migrate.c:1148:1: internal compiler error: in push_minipool_fix, at config/arm/arm.c:13101
>> Please submit a full bug report,
>> with preprocessed source if appropriate.
>> See <file:///usr/share/doc/gcc-4.7/README.Bugs> for instructions.
>> Preprocessed source stored into /tmp/ccO1Nz1m.out file, please attach
>> this to your bugreport.
>> make[2]: *** [mm/migrate.o] Error 1
>> make[2]: Target `__build' not remade because of errors.
>> make[1]: *** [mm] Error 2
>>
>> build bisect points to commit 21f992084aeb[3], but that doesn't revert
>> cleanly so I haven't got any further than that yet.
> 
> I installed gcc-arm-linux-gnueabi (4:4.7.2-1 from Ubuntu 14.04 LTS) and could
> reproduce the ICE. I came up with the workaround below.
> Does this work for you?
> 
> From 7ebe83316eaf1952e55a76754ce7a5832e461b8c Mon Sep 17 00:00:00 2001
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Date: Wed, 1 Apr 2015 11:22:51 +0200
> Subject: [PATCH] mm/migrate: Mark unmap_and_move() "noinline" to avoid ICE in
>  gcc 4.7.3
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> With gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-12ubuntu1) :
> 
>     mm/migrate.c: In function ?migrate_pages?:
>     mm/migrate.c:1148:1: internal compiler error: in push_minipool_fix, at config/arm/arm.c:13500
>     Please submit a full bug report,
>     with preprocessed source if appropriate.
>     See <file:///usr/share/doc/gcc-4.7/README.Bugs> for instructions.
>     Preprocessed source stored into /tmp/ccPoM1tr.out file, please attach this to your bugreport.
>     make[1]: *** [mm/migrate.o] Error 1
>     make: *** [mm/migrate.o] Error 2
> 
> Mark unmap_and_move() (which is used in a single place only) "noinline"
> to work around this compiler bug.
> 
> Reported-by: Kevin Hilman <khilman@kernel.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  mm/migrate.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 114602a68111d809..98f8574456c2010c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -904,9 +904,10 @@ out:
>   * Obtain the lock on page, remove all ptes and migrate the page
>   * to the newly allocated page in newpage.
>   */
> -static int unmap_and_move(new_page_t get_new_page, free_page_t put_new_page,
> -			unsigned long private, struct page *page, int force,
> -			enum migrate_mode mode)
> +static noinline int unmap_and_move(new_page_t get_new_page,
> +				   free_page_t put_new_page,
> +				   unsigned long private, struct page *page,
> +				   int force, enum migrate_mode mode)
>  {
>  	int rc = 0;
>  	int *result = NULL;
> 

Ouch. That's really ugly. And on 32bit ARM, we end-up spilling half of
the parameters on the stack, which is not going to help performance
either (not that this would be useful on 32bit ARM anyway...).

Any chance you could make this dependent on some compiler detection
mechanism?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
