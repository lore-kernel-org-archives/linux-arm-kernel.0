From: trd@45mercystreet.com (Toby Douglass)
Date: Tue, 24 Nov 2009 23:24:29 +0100
Subject: CAS implementation may be broken
In-Reply-To: <1259061596.13956.15.camel@pc1117.cambridge.arm.com>
References: <20091124013231.GB14645@shareable.org>
	<1259061596.13956.15.camel@pc1117.cambridge.arm.com>
Message-ID: <4B0C5D1D.6040603@45mercystreet.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> On Tue, 2009-11-24 at 01:32 +0000, Jamie Lokier wrote:
>> Russell King - ARM Linux wrote:

>>> However, I don't think you've understood the original problem at all.

>> I think I have - I agreed with you and Catalin already that LL/SC does
>> not suffice.  But do you mean that Catalin's suggestion to put the
>> LDREX before the LDR does not work either?  (Maybe it needs a barrier
>> too).

> It definitely needs a barrier after the LDREX and maybe one after STREX
> but that depends on the semantics of such operation.

In the latest kernel, there is a memory barrier (the DMB instruction on 
v7 and above) immediately before and immediately after the call to the 
CAS function.

I thought about this a little.  If the memory barrier is immediately 
before and given the next instruction is the LDREX, *all* threads coming 
to the LDREX *must* have preceeding them a DMB and so be up to date on 
memory, regardless of pauses in thread execution.

This however is in conflict with Catalin's comments.
