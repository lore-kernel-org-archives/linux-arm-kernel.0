From: pasha.tatashin@oracle.com (Pavel Tatashin)
Date: Mon, 9 Oct 2017 15:07:01 -0400
Subject: [PATCH v9 09/12] mm/kasan: kasan specific map populate function
In-Reply-To: <20171009190213.GF30828@arm.com>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-10-pasha.tatashin@oracle.com>
 <20171003144845.GD4931@leverpostej>
 <20171009171337.GE30085@arm.com>
 <CAOAebxtHHFvYn4WysMASe1GqvgKYPVyjJ572UM3Sef5sP0hi9A@mail.gmail.com>
 <20171009182217.GC30828@arm.com>
 <CAOAebxu1310eCrk88EC=Oaw3n90-9RuHZ1KBhPvLu_DyXBNZFQ@mail.gmail.com>
 <20171009184834.GE30828@arm.com>
 <CAOAebxs5s3DKV8f+Zw+LFVB98PE6cs=RwcOH8qEiU_MPLM9RvQ@mail.gmail.com>
 <20171009190213.GF30828@arm.com>
Message-ID: <CAOAebxvcg9r00bCWDJS4V_mmKk_dELVs_SfxqrxemDg7=uZx_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> Ok, but I'm still missing why you think that is needed. What would be the
> second page table walker that needs implementing?
>
> I guess we could implement that on arm64 using our current vmemmap_populate
> logic and an explicit memset.
>

Hi Will,

What do you mean by explicit memset()? We can't simply memset() from
start to end without doing the page table walk, because at the time
kasan is calling vmemmap_populate() we have a tmp_pg_dir instead of
swapper_pg_dir.

We could do the explicit memset() after
cpu_replace_ttbr1(lm_alias(swapper_pg_dir)); but again, this was in
one of my previous implementations, and I was asked to replace that.

Pavel
