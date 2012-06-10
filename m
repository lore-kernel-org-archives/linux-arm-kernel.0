From: gmbnomis@gmail.com (Simon Baatz)
Date: Sun, 10 Jun 2012 22:16:25 +0200
Subject: Kernel 3.4 error on Dreamplug: [vectors]: mlock failed: Cannot
 allocate memory
In-Reply-To: <1338401183.22894.11.camel@hactar>
References: <1338401183.22894.11.camel@hactar>
Message-ID: <20120610201625.GA26603@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[cross posted to linux-lvm, because I think it is a lvm problem]

On Wed, May 30, 2012 at 03:06:23PM -0300, Thiago Jung Bauermann wrote:
> I have just upgraded my Dreamplug to the 3.4 kernel, and when creating
> an LVM snapshot volume, I see errors for which I didn't find any report
> yet:
> 
> # lvcreate -s -L 80M -n root-fsck-snapshot marv2-vg/root
>   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
>   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
>   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: munlock failed: Cannot allocate memory
>   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
>   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
>   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: munlock failed: Cannot allocate memory
>   Logical volume "root-fsck-snapshot" created
> 
> Ironically, the main reason I upgraded the kernel from 3.0.0 was to get

I see similar errors on an IB-NAS6210 box. Apparently, lvm2 tries to
mlock/munlock all readable maps it finds in "proc/self/maps", i.e
also the "[vectors]" page.  Between 3.0 and 3.4 there has been the
change f9d4861f "ARM: 7294/1: vectors: use gate_vma for vectors user
mapping", which might have changed the behaviour when mlocking
vectors.

In LVM2, there is a list in lib/mm/memlock.c of maps to ignore:

/* list of maps, that are unconditionaly ignored */
static const char * const _ignore_maps[] = {
    "[vdso]",
    "[vsyscall]",
};

"[vdso]" seem to be based on gate_vma as well. Thus, I think
"[vectors]" needs to be added to this list.


- Simon
