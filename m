From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 18 Nov 2015 11:14:02 -0600
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <20151118162932.GA13355@leverpostej>
References: <1447858999-26665-1-git-send-email-jeremy.linton@arm.com>
 <20151118152044.GD10644@leverpostej> <564CA29A.9050905@arm.com>
 <20151118162932.GA13355@leverpostej>
Message-ID: <564CB1DA.4090304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2015 10:29 AM, Mark Rutland wrote:
> On Wed, Nov 18, 2015 at 10:08:58AM -0600, Jeremy Linton wrote:
>> 	No, its not defconfig, its roughly the RHELSA config tossed into a
>> mainline 4.4 tree and all the default options selected. AFAIK RHELSA
>> is still limited access.
>
> That renders this extremely difficult for anyone else to reproduce...

Well the kernel in question boots fine on a Juno. I haven't tried any 
other APM based machines. And given whats happening I doubt its config 
related.

> That 48 / 0b110000 for the DFSC decodes as "TLB conflict abort" per the
> ARM ARM. Other than that, the WnR bit is set in the ISS.
>
> So this is probably a break-before-make issue.
>
> Can you figure out where 0xfffffe0000d60588 pointed to, and where in the
> kernel the access was performed? It would be nice to know if this is
> consistently happening at some edge of the kernel address space.

I decoded everything when I initially saw it, but it didn't make a lick 
of sense related to what I was attempting to accomplish so I didn't keep 
any of it. Only later when I found out it wasn't related to the patches 
I was applying did I start trying to track down the regression. Even so, 
given some other patches that went in, it wasn't blindingly obvious 
where the problem was until I was sure that it was related to the linear 
mapping changes. AKA I didn't think anyone would be able to debug the 
failure with that little information, maybe i'm wrong on that point... 
Anyway, the kernel that produced that failure is long gone, I can in the 
near future attempt to reproduce the message.


>> Once I find/fix the console issue on that machine with 4.4rc1 (there
>> are a small handful of issues that keep mainline from working on it,
>> including the sata patch that was posted, and rejected), I will
>> focus on hoisting the tlb flush into create_mapping_late() and
>> removing the splattering of flushes in those code paths. That is
>> unless there is a reason to be preforming them as soon as the
>> directories are split.
>
> We need to figure out exactly what maintenance we actually need.
>
> Hoisting the TLB flush isn't necessarily possible if we need to perform
> break-before-make at the PTE level, and even that may not be possible
> for the kernel page tables; we might need to do something more
> drastic like using ASIDs and double-buffering them...
>
> We also need to figure out what's happening with the code as it is.

Well, I'm suspect what is happening is that there are conflicting TLB's 
hanging around, one for a cont range that is overlapping a stale non 
cont one. This sort of implies that this has been happening all along, 
AKA RO regions were being "lazy" activated if you will. Its only on a 
core that aborts when it detects that (which i assume requires differing 
size entries for this core) does it cause problems. The 
break-before-make issue, seems like it won't cause a big problem here as 
long as there is some way to assure valid TLBs before the update, and 
then assure they are cleared following it. Hence the overly aggressive 
change works because it flushes following every cont block update. Which 
would bother me more if the code were run more than once per boot (or in 
the future per module load/unload if someone gets around to updating the 
no execute reliably).
