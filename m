From: laura@labbott.name (Laura Abbott)
Date: Mon, 23 Nov 2015 08:37:29 -0800
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <5653387A.2000101@redhat.com>
References: <1447858999-26665-1-git-send-email-jeremy.linton@arm.com>
 <20151118152044.GD10644@leverpostej> <564CA29A.9050905@arm.com>
 <20151118162932.GA13355@leverpostej>
 <20151123155132.GC32300@e104818-lin.cambridge.arm.com>
 <5653387A.2000101@redhat.com>
Message-ID: <565340C9.7010605@labbott.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/15 8:02 AM, Jeremy Linton wrote:
> On 11/23/2015 09:51 AM, Catalin Marinas wrote:
>> Call trace:
>> [<ffffffc0000952b8>] __create_mapping.isra.5+0x360/0x530
>> [<ffffffc0000954ec>] fixup_init+0x64/0x80
>> [<ffffffc0000945a4>] free_initmem+0xc/0x38
>> [<ffffffc0005eb9f8>] kernel_init+0x20/0xe0
>> [<ffffffc000085c50>] ret_from_fork+0x10/0x40
>>
>> What I don't get is why we have fixup_init() even when
>> !CONFIG_DEBUG_RODATA. It probably breaks the initial mapping just to get
>> a non-executable init section. However, the other sections are left
>> executable when this config option is disabled. The patch below fixes
>> the warnings above:
>
>      Well the kernel permissions are a bit of a mess, and not at all
> "secure" in their current state. But I guess the thought must have been
> that turning off execute on the init sections was a good way to find
> functions incorrectly marked _init(). Which is different from RO.
> Frankly, I expect someone will push to cleanup the kernel permissions at
> some point (I've got it on my "spare time todo, list"), but this will of
> course make the create_mapping_late a lot more popular as I see it being
> called during module load/unload.
>      Anyway, I've been saying the problem is create_mapping_late() all
> along, as you notice there isn't any TLB flushes in fixup_init() and
> that is the core of the problem, not all this other discussion.
>

fixup_init was deliberately designed to change the sections even if
DEBUG_RODATA was not enabled. This was partially designed to match the
behavior of arm(32) which also drops the nx bit but also good practice
in general for security.

Which permissions still need to be cleaned up from your perspective?

Thanks,
Laura
