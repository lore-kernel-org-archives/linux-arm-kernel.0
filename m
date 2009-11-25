From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Nov 2009 11:11:56 +0000
Subject: CAS implementation may be broken
In-Reply-To: <4B0C5D1D.6040603@45mercystreet.com>
References: <4B0C5D1D.6040603@45mercystreet.com>
Message-ID: <1259147516.30270.51.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-11-24 at 22:24 +0000, Toby Douglass wrote:
> Catalin Marinas wrote:
> > On Tue, 2009-11-24 at 01:32 +0000, Jamie Lokier wrote:
> >> Russell King - ARM Linux wrote:
> 
> >>> However, I don't think you've understood the original problem at all.
> 
> >> I think I have - I agreed with you and Catalin already that LL/SC does
> >> not suffice.  But do you mean that Catalin's suggestion to put the
> >> LDREX before the LDR does not work either?  (Maybe it needs a barrier
> >> too).
> 
> > It definitely needs a barrier after the LDREX and maybe one after STREX
> > but that depends on the semantics of such operation.
> 
> In the latest kernel, there is a memory barrier (the DMB instruction on
> v7 and above) immediately before and immediately after the call to the
> CAS function.
> 
> I thought about this a little.  If the memory barrier is immediately
> before and given the next instruction is the LDREX, *all* threads coming
> to the LDREX *must* have preceeding them a DMB and so be up to date on
> memory, regardless of pauses in thread execution.
> 
> This however is in conflict with Catalin's comments.

My comment was to a new implementation for the ABA issue using LDR for
the next pointer after LDREX and these would need to be separated by a
barrier. Looking at this a bit more, it isn't actually needed since the
subsequent LDR uses the pointer read by LDREX and thus creating an
address dependency ("the value returned by a read access is used to
compute the virtual address of a subsequent read or write access") which
implies strict ordering between LDREX and LDR (A3.8.2 in the ARM ARM).
But as I said, LDR between LDREX/STREX may no always work.

You may need barriers before and after you routine as we do in the CAS
case but it depends how you define your routine, you may ask the caller
of such routine to add the barriers explicitly.

-- 
Catalin
