From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Nov 2009 22:56:05 +0000
Subject: CAS implementation may be broken
In-Reply-To: <4B0C5F90.7050503@45mercystreet.com>
References: <20091124013231.GB14645@shareable.org>
	<1259061596.13956.15.camel@pc1117.cambridge.arm.com>
	<4B0C5F90.7050503@45mercystreet.com>
Message-ID: <20091124225605.GJ17481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2009 at 11:34:56PM +0100, Toby Douglass wrote:
> I wrote:
>> I thought about this a little.  If the memory barrier is immediately  
>> before and given the next instruction is the LDREX, *all* threads 
>> coming to the LDREX *must* have preceeding them a DMB and so be up to 
>> date on memory, regardless of pauses in thread execution.
>
> Additionally; the DMB afterwards seemed to have no value.  You could  
> perform the STREX and then your thread could pause indefinitely and were  
> you in a situation where you store was not immediately visible or  
> correctly ordered to another thread, that thread would then read the old  
> value.

The two DMBs are there to prevent other loads and stores on the _local_
CPU being speculated inside the compare-and-swap operation, either by
the compiler or the CPU.
