From: agraf@suse.de (Alexander Graf)
Date: Wed, 13 Jul 2016 18:14:11 +0200
Subject: [PATCH] arm64: Add config to limit user space to 47bits
In-Reply-To: <CAKv+Gu_QH=sZi--FVqHebd1P+6UMzEqWQQ1u3Y170B7cND8Kgw@mail.gmail.com>
References: <1468424567-15925-1-git-send-email-agraf@suse.de>
 <CAKv+Gu_QH=sZi--FVqHebd1P+6UMzEqWQQ1u3Y170B7cND8Kgw@mail.gmail.com>
Message-ID: <578668D3.6010406@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2016 05:59 PM, Ard Biesheuvel wrote:
> On 13 July 2016 at 17:42, Alexander Graf <agraf@suse.de> wrote:
>> Some user space applications are known to break with 48 bits virtual
> known by whom? At least I wasn't aware of it, so could you please
> share some examples?

Sure! Known to me so far are:

   * mozjs17
   * mozjs24
   * mozjs38
   * js-1.8.5
   * java-1.7 (older JITs, fixed in newer ones)

I'm not sure if there are more, but the fact that I've run into this 
problem more than once doesn't make me incredibly happy :).

>
>> address space. As interim step until the world is healed and everyone
>> embraces correct code, this patch allows to only expose 47 bits of
>> virtual address space to user space.
>>
> Is this a code generation/toolchain issue?

mozjs uses a single 64bit value to combine doubles, ints and pointers 
into a single variable. It is very smart and uses the upper 17 bits for 
metadata such as "which type of variable is this". Coincidentally those 
bits happen to overlap the "double is an infinite number" bits, so that 
you can also express a NaN with it. When using such a value, the upper 
17 bits get masked out.

That one was fixed upstream by force allocating the javascript heap 
starting at a fixed location which is below 47 bits.

js-1.8.5 has the same as above, but also uses pointers to .rodata as 
javascript pointers, so it doesn't only use the heap, it also uses 
pointers to the library itself, which gets mapped high up the address 
space. I don't have a solution for that one yet.

IcedTea for java-1.7 had a bug where it incorrectly caused an overflow 
when trying to calculating a relative adrp offset from <address high up> 
to <address really low>, so that the resulting pointer had the upper 
bits set as 1s. That one is long fixed upstream, we only ran into it 
because we used an ancient IcedTea snapshot.

My main concern however is with code that I do not know is broken today.


Alex
