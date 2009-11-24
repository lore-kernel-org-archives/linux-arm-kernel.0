From: trd@45mercystreet.com (Toby Douglass)
Date: Tue, 24 Nov 2009 23:34:56 +0100
Subject: CAS implementation may be broken
In-Reply-To: <1259061596.13956.15.camel@pc1117.cambridge.arm.com>
References: <20091124013231.GB14645@shareable.org>
	<1259061596.13956.15.camel@pc1117.cambridge.arm.com>
Message-ID: <4B0C5F90.7050503@45mercystreet.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I wrote:
> I thought about this a little.  If the memory barrier is immediately 
> before and given the next instruction is the LDREX, *all* threads coming 
> to the LDREX *must* have preceeding them a DMB and so be up to date on 
> memory, regardless of pauses in thread execution.

Additionally; the DMB afterwards seemed to have no value.  You could 
perform the STREX and then your thread could pause indefinitely and were 
you in a situation where you store was not immediately visible or 
correctly ordered to another thread, that thread would then read the old 
value.

A more common example would be that another thread is reading the 
destination value for some reason, and reads after the STREX and before 
the trailing DMB.

This implies you need a DMB as the instruction immediately preceding 
every read and every write of destination.  On x86/x64, all the atomic 
ops (e.g. the LOCK prefix) act as full memory barriers.

Note that I'm not yet fully conversant with the issues in multi-core 
threading, so I may be writing rubbish :-)
