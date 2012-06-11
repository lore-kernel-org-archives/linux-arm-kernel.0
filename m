From: zkabelac@redhat.com (Zdenek Kabelac)
Date: Mon, 11 Jun 2012 15:06:13 +0200
Subject: Kernel 3.4 error on Dreamplug: [vectors]: mlock failed: Cannot
 allocate memory
In-Reply-To: <20120610201625.GA26603@schnuecks.de>
References: <1338401183.22894.11.camel@hactar>
 <20120610201625.GA26603@schnuecks.de>
Message-ID: <4FD5ED45.50208@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 10.6.2012 22:16, Simon Baatz napsal(a):
> Hi,
>
> [cross posted to linux-lvm, because I think it is a lvm problem]
>
> On Wed, May 30, 2012 at 03:06:23PM -0300, Thiago Jung Bauermann wrote:
>> I have just upgraded my Dreamplug to the 3.4 kernel, and when creating
>> an LVM snapshot volume, I see errors for which I didn't find any report
>> yet:
>>
>> # lvcreate -s -L 80M -n root-fsck-snapshot marv2-vg/root
>>    ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
>>    ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
>>    ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: munlock failed: Cannot allocate memory
>>    ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
>>    ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
>>    ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: munlock failed: Cannot allocate memory
>>    Logical volume "root-fsck-snapshot" created
>>
>> Ironically, the main reason I upgraded the kernel from 3.0.0 was to get
>
> I see similar errors on an IB-NAS6210 box. Apparently, lvm2 tries to
> mlock/munlock all readable maps it finds in "proc/self/maps", i.e
> also the "[vectors]" page.  Between 3.0 and 3.4 there has been the
> change f9d4861f "ARM: 7294/1: vectors: use gate_vma for vectors user
> mapping", which might have changed the behaviour when mlocking
> vectors.
>
> In LVM2, there is a list in lib/mm/memlock.c of maps to ignore:
>
> /* list of maps, that are unconditionaly ignored */
> static const char * const _ignore_maps[] = {
>      "[vdso]",
>      "[vsyscall]",
> };
>
> "[vdso]" seem to be based on gate_vma as well. Thus, I think
> "[vectors]" needs to be added to this list.

Opps - missed multilist posting - so again with all copies...

Yep, looks like simple patch to add.
Is there any other area which is missing ?

Zdenek
