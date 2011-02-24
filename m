From: mnazarewicz@google.com (Michal Nazarewicz)
Date: Thu, 24 Feb 2011 23:10:09 +0100
Subject: [PATCH 1/2] lib: vsprintf: optimised put_dec() function
In-Reply-To: <20110224135101.9205d91e.akpm@linux-foundation.org>
References: <a02a83033d5d61c5d78f110b44f24ae5cd94ab06.1298384703.git.mina86@mina86.com>
	<20110224135101.9205d91e.akpm@linux-foundation.org>
Message-ID: <op.vrfg66mgvgw7ix@mnazarewicz-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Feb 2011 22:51:01 +0100, Andrew Morton wrote:

>> Cc: linux-arm at lists.arm.linux.org.uk, Michal Nazarewicz  
>> <mina86@mina86.com>, "Douglas W. Jones" <jones@cs.uiowa.edu>, Denis  
>> Vlasenko <vda.linux@googlemail.com
>
> linux-arm-kernel is for arm patches.  linux-kernel at vger.kernel.org
> would be an appropriate cc for patches against lib/vsprintf.c.

Yes, I realised I forgot about LKML just after I submitted the patch.
I included ARM because of the benchmark I did on ARM I mentioned.

> On Tue, 22 Feb 2011 15:26:26 +0100 Michal Nazarewicz wrote:
>> The put_dec() and family of functions were based on a code
>> optimised for processors with 8-bit ALU but since we don't
>> need to limit ourselves to such small ALUs, the code was
>> optimised and used capacities of an 16-bit ALU anyway.
[...]

> I don't think this was worth optimising!  If any kernel workload is
> calling sprintf("%d") with any frequency then something surely is
> busted.

>>  lib/vsprintf.c |  269  
>> ++++++++++++++++++++++++++++++++++++++------------------
>>  1 files changed, 185 insertions(+), 84 deletions(-)

> Despite the code bloat, the patch somehow reduces the vsprintf.o
> footprint by 150 bytes (1%).
>
> I'm not really sure that we should apply this.  But given that the
> existing code is an incomprehensible over-optimised mess I guess this
> patch doesn't make things much worse.
>
> However I think that a better approach would be to rip out the existing
> stuff and go for some small, simple and slow thing.  Reduce the kernel
> footprint and increase understandability and hence maintainability.
>
> Unless I'm all wrong and you're aware of a workload which calls these
> things with any frequency?

Oh, no, I just felt like hacking this piece of code one evening. ;)
I don't have any strong feelings about this patch so feel free to
ignore it.  I just wanted decision to include it or not to include
it be made by someone with experience rather than be a consequence
of me forgetting about this patch.


>> +	r      = (q * (uint64_t)0xcccd) >> 19;
>> +	*buf++ = (q - 10 * r) + '0';

On Thu, 24 Feb 2011 22:52:42 +0100, Andrew Morton wrote:
> Also, the funky indenting to align on the "=" is atypical for kernel
> code and is inconsistent with the rest of vsprintf.c.  Just a single
> space, please.

Want me to resubmit with spaces fixed?

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michal "mina86" Nazarewicz    (o o)
ooo +-----<email/xmpp: mnazarewicz@google.com>-----ooO--(_)--Ooo--
